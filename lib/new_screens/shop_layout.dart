import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:varadifi_app/misc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class ShopLayout extends StatefulWidget {
  @override
  _ShopLayoutState createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(0, 50, 0, 50),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _Header(),
              Container(
                height: 1400,
                margin: EdgeInsets.only(top: 10),
                child: _ProductList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 0),
      child: Column(
        children: [
          Row(
            spacing: 15,
            children: [
              Text(
                'Merch-ek',
                style: GoogleFonts.manrope(
                  color: Color(0xFFE5E2E1),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2.4,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFF3FE56C),
                  borderRadius: BorderRadius.circular(99999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('shopItems').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final isLastItem = index == products.length - 1;
              final product = products[index];
              return _ProductItem(
                marginBottom: isLastItem ? 900 : 64,
                title: product['title'],
                price: product['price'],
                imageUrl: product['imagePath'],
                description: product['description'],
              );
            },
          );
        }
        return CircularProgressIndicator(color: Color(0xFF3FE56C));
      },
    );
  }
}

class _ProductItem extends StatelessWidget {
  final double marginBottom;
  final String title;
  final double price;
  final String imageUrl;
  final String description;

  const _ProductItem({
    this.marginBottom = 64,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 608,
      margin: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 0,
        bottom: marginBottom,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 456,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ), //image
          SizedBox(height: 5),
          SizedBox(
            height: 52,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: SizedBox(
                    width: 400,
                    height: 52,
                    child: Column(
                      spacing: 5,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.manrope(
                                color: Color(0xFFE5E2E1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ), //title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              description,
                              style: GoogleFonts.inter(
                                color: Color(0xFFBBCBB8),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ), //description
                      ],
                    ),
                  ),
                ), //text labels
                Positioned(
                  top: 0,
                  right: 0,
                  child: Text(
                    '$price RON',
                    style: GoogleFonts.manrope(
                      color: Color(0xFF3FE56C),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ), //price
              ],
            ),
          ), //informations
          Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.9, -1.15),
                end: Alignment(0.1, 1.15),
                colors: [Color(0xFF3FE56C), Color(0xFF00C853)],
                stops: [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _BuyForm(productId: title);
                  },
                );
              },
              splashColor: Color(0x803FE56C),
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Text(
                  'Vásárlás',
                  style: GoogleFonts.manrope(
                    color: Color(0xFF002108),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.4,
                    height: 0.02,
                  ),
                ),
              ),
            ),
          ), //button
        ],
      ),
    );
  }
}

class _BuyForm extends StatefulWidget {
  final String productId;

  const _BuyForm({required this.productId});

  @override
  _BuyFormState createState() => _BuyFormState();
}

class _BuyFormState extends State<_BuyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _gender = ['Férfi', 'Nő'];

  String selectedSize = 'S';
  String selectedGender = 'Férfi';
  String name = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 300,
        margin: EdgeInsets.symmetric(vertical: 200, horizontal: 33),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Color(0x803FE56C), width: 1.5),
          color: Color(0xFF080A08),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  'Vásárlás',
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE5E2E1),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  spacing: 15,
                  children: [
                    TextFormField(
                      style: GoogleFonts.inter(
                        color: Color(0xFFE5E2E1),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Teljes név',
                        labelStyle: GoogleFonts.inter(
                          color: Color(0xFFE5E2E1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00C853)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3FE56C)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x80E53935)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: GoogleFonts.inter(
                          color: Color(0xFFE53935),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE53935)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kérem adja meg a teljes nevét';
                        }
                        name = value;
                        return null;
                      },
                    ), //teljes nev
                    TextFormField(
                      style: GoogleFonts.inter(
                        color: Color(0xFFE5E2E1),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Telefonszám',
                        labelStyle: GoogleFonts.inter(
                          color: Color(0xFFE5E2E1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00C853)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF3FE56C)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x80E53935)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorStyle: GoogleFonts.inter(
                          color: Color(0xFFE53935),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE53935)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kérem adja meg a telefonszámot';
                        }
                        phoneNumber = value;
                        return null;
                      },
                    ), //telefonszám
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Visibility(
                            visible: widget.productId != 'Pix',
                            child: DropdownButton<String>(
                              iconEnabledColor: Color(0x803FE56C),
                              style: GoogleFonts.inter(
                                color: Color(0xFFE5E2E1),
                                fontWeight: FontWeight.w400,
                              ),
                              isExpanded: false,
                              dropdownColor: Color(0xFF2D2D2D),
                              borderRadius: BorderRadius.circular(15),
                              underline: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0x803FE56C)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              value: selectedSize,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSize = newValue!;
                                });
                              },
                              items: _sizes.map((String size) {
                                return DropdownMenuItem<String>(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                            ),
                          ), //meret
                          DropdownButton<String>(
                            iconEnabledColor: Color(0x803FE56C),
                            style: GoogleFonts.inter(
                              color: Color(0xFFE5E2E1),
                              fontWeight: FontWeight.w400,
                            ),
                            isExpanded: false,
                            dropdownColor: Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(15),
                            underline: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0x803FE56C)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            value: selectedGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: _gender.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                          ), //nemek
                        ],
                      ),
                    ), //Dropdown Menus
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 15,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF131313),
                          foregroundColor: Color(0xFF00C853),
                          textStyle: GoogleFonts.inter(
                            color: Color(0xFFE5E2E1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text('Vissza'),
                      ),
                    ), //vissza button
                    Positioned(
                      bottom: 0,
                      right: 15,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            db.collection('orders').add({
                              'orderId': widget.productId,
                              'name': name,
                              'phoneNumber': phoneNumber,
                              'size': selectedSize,
                              'gender': selectedGender,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF131313),
                                content: Text(
                                  'Sikeres vásárlás!',
                                  style: GoogleFonts.manrope(
                                    color: Color(0x803FE56C),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            );
                            _formKey.currentState!.reset();
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00C853),
                          foregroundColor: Color(0xFF002108),
                          textStyle: GoogleFonts.inter(
                            color: Color(0xFFE5E2E1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text('Vásárlás'),
                      ),
                    ), //vasarlas button
                  ],
                ),
              ), //buttons
            ],
          ),
        ),
      ),
    );
  }
}
