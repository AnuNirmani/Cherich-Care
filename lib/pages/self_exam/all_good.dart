import 'package:flutter/material.dart';
import '../home_page.dart'; // Import the HomePage

class AllGood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.pink[50], // Light pink background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cherry Image
            Image.asset(
              'assets/images/logo.png', // Replace with the path to your cherry image
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            // "You're Amazing!" Text
            const Text(
              "Normal is Great",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              "\n\nThe Best \nProtection is \nEarly Detection\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.pink,
              ),
            ),
            const Text(
              "Keep doing \nself-exam\n\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            // Home Icon
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to HomePage
                );
              },
              child: Image.asset(
                'assets/images/home.png', // Home icon
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
