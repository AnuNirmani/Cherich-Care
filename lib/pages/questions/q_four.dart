import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/q_five.dart';
import 'package:cherich_care_2/pages/questions/q_three.dart';
import 'package:cherich_care_2/pages/questions/q_zero.dart';
import 'package:flutter/material.dart';

class QFour extends StatelessWidget {
  const QFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Screening Quiz",
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
        MaterialPageRoute(builder: (context) => QThree()),
        (route) => false,);
                        },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              _showExitDialog(context);
            },
          ),
        ],
      ),

            body: Container(
        color: Colors.pink[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
            'assets/images/q5.png', // Put your image path here
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              "The more estrogen you have been exposed to, the more your risk may increase.\n\n"
              "Treatments can stop your body from making estrogen or prevent hormone receptors from binding to estrogen. "
              "People who use estrogen hormone therapy for menopause symptoms may be more prone to estrogen-dependent cancers.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => QFive()),
        (route) => false,);
                        },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      


      void _showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Are you sure you want to exit the quiz?",
          style: TextStyle(fontSize: 16), // Adjust font size here
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Insights()),
                (route) => false,
              );
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}