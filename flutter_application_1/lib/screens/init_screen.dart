import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
//import 'package:flutter_application_1/screens/profile/profile_screen.dart'; // Import ProfileScreen class

const Color inActiveIconColor = Color(0xFFB6B6B6);

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final List<Widget> pages = [
    HomeScreen(),
   // FavoriteScreen(),
    Center(
      child: Text("Chat"),
    ),
    //ProfileScreen(), // Instantiate ProfileScreen class
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: inActiveIconColor,
            ),
            activeIcon: Icon(
              Icons.shop,
              color: kPrimaryColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: inActiveIconColor,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: kPrimaryColor,
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              color: inActiveIconColor,
            ),
            activeIcon: Icon(
              Icons.chat_bubble,
              color: kPrimaryColor,
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: inActiveIconColor,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: kPrimaryColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
