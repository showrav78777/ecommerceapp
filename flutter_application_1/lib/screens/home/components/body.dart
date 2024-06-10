import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../../../loginandregistration/login.dart';

import '../../../size_config.dart';
import 'cart.dart';

import 'discount_banner.dart';
import 'home_header.dart';

import 'product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User? _user;
  late String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _user = user;
        _userName = userDoc['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Image.asset(
              'assets/images/consultation.jpg',
              width: 60,
              height: 60,
            ),
            title: const Text(
              'Simple',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
              ),
              PopupMenuButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Welcome, $_userName'), // Display username
                    enabled: false,
                  ),
                  // PopupMenuItem(
                  //   child: Text('User Profile'),
                  //   value: 'profile',
                  // ),
                  const PopupMenuItem(
                    child: Text('Logout'),
                    value: 'logout',
                  ),
                ],
                onSelected: (value) {
                  if (value == 'profile') {
                    // Navigate to the user profile screen
                    // Implement your navigation logic here
                  } else if (value == 'logout') {
                    // Perform logout action
                    FirebaseAuth.instance.signOut();
                    // After logout, navigate to the login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeHeader(key: UniqueKey()),
              SizedBox(height: getProportionateScreenWidth(20)),
              DiscountBanner(key: UniqueKey()),
              SpecialOffers(key: UniqueKey()),
              SizedBox(height: getProportionateScreenWidth(20)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Pro(),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ),
    );
  }
}
