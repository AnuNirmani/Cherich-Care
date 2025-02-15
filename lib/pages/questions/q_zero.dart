import 'package:cherich_care_2/pages/insights/risk_assesment.dart';
import 'package:cherich_care_2/pages/questions/q_one.dart';
import 'package:flutter/material.dart';

class QZero extends StatelessWidget {
  const QZero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "QUIZ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RiskAssesment()),
        (route) => false,
      );
          },
        ),
      ),
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
                "\nWelcome to the",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Cherish Care \n Risk Assessment Quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 20),
              const Text(
                "Screening is important to detect breast cancer \n as early as possible",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Use the result from the quiz to \n have a better understanding of your risk",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => QOne()),
        (route) => false,);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text(
                  "Begin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
