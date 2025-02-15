import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/insights/screening_q.dart';
import 'package:flutter/material.dart';

class EndQ extends StatelessWidget {
  const EndQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink[50],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                image: AssetImage('assets/images/logo.png'), // Add your image asset here
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                "\nThank you for Completing the Screening Quiz!\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                   fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                " We appreciate your participation in this important step towards breast health awareness. Regular screenings are crucial for early detection, so be sure to keep up with your screenings and use our app’s reminder feature to stay on track."
" If there are any changes in your circumstances, we encourage you to retake the quiz to keep your screening results up to date.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Stay informed, stay proactive, and let’s continue prioritizing your health together.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                   fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ScreeningQ()), // Navigate to HomePage
                );
              },
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tap Here to see your Responces',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                ],
              ),
            ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
