import 'package:flutter/material.dart';

import '../../../loginandregistration/login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_2.png', // Replace 'your_image.png' with your image asset path
              width: 200, // Adjust the width of the image
              height: 200, // Adjust the height of the image
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to Simple',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'You can get service as long as buy your desired product.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Set the button color
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Set the button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Set the button border radius
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18, // Set the button text size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
