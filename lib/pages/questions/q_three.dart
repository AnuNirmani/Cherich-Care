import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/q_four.dart';
import 'package:cherich_care_2/pages/questions/q_two.dart';
import 'package:cherich_care_2/pages/questions/q_zero.dart';
import 'package:flutter/material.dart';

class QThree extends StatelessWidget {
  const QThree({super.key});

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
        MaterialPageRoute(builder: (context) => QTwo()),
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
            const Icon(
              Icons.cake_outlined,
              size: 64,
              color: Colors.black,
            ),
            const SizedBox(height: 24),
            const Text(
              "Unless you have figured the secret to staying young forever, your risk will increase as you age."
              "So make sure to beaware of any changes you find, and to follow your screening plan that will be created for you at the end of this quiz.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Also, just being a woman means breast cancer is a risk. "
              "Only 1% of breast cancer patients are male.",
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
        MaterialPageRoute(builder: (context) => QFour()),
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