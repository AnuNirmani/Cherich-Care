import 'package:cherich_care_2/pages/self_exam/self_exam.dart';
import 'package:flutter/material.dart';

class SaveSymptoms2 extends StatelessWidget {
  const SaveSymptoms2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Risk Identification Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 156, 214, 255),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Replace emoji with an image
                  Image.asset(
                    'assets/images/savesymptoms2.png', // Replace with your image path
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "You are Identified as in a",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Low Risk !",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Be aware yourself with\nCherish Care",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelfExam(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 17, 0, 255),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

