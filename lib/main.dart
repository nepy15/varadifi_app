import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varadifi_app/final_view.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgoundHandler);

  setupNotifications();
  runApp(const MainApp());
}

Future<void> setupNotifications() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    final token = await messaging.getToken();
    print('FCM Token: $token');

    await messaging.subscribeToTopic('Varadifi');
    print('Subscribed to Varadifi topic');
  }
}

void setupMessageHandlers(BuildContext context) {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('User tapped backgorund notification');
    if (message.messageId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.notification!.title ?? 'New Event!'),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      print('App opened from terminated state via notification');
      handleNotificationNavigation(context, message);
    }
  });
}

void handleNotificationNavigation(BuildContext context, RemoteMessage message) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => FinalView()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(debugShowCheckedModeBanner: false, home: FinalView());
  }
}
