import 'package:cherich_care_2/pages/all_bad.dart';
import 'package:cherich_care_2/pages/all_good.dart';
import 'package:flutter/material.dart';

class SelfCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Self Count',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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

            const SizedBox(height: 20),

            // "You're Amazing!" Text
            const Text(
              "You're Amazing!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            // Green Check Icon
            Image.asset(
                  'assets/images/greenright.png',
                  width: 100,
                  height: 100,
                ),
            const SizedBox(height: 20),

            // "How did it go?" Text
            const Text(
              "How did it go?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            // Blue and Red Buttons
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 156, 214, 255), // Light blue rounded section
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 60),
              child: Column(
                children: [
                  // "All Good" Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 17, 0, 255), // Blue button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllGood(),
                    ),
                  );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'All Good',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                  'assets/images/allgood.png',
                  width: 30,
                  height: 30,
                ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // "Not Good" Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 248, 17, 0), // Red button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllBad(),
                    ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Not Good',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                  'assets/images/allbad.png',
                  width: 30,
                  height: 30,
                ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
