import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/q_four.dart';
import 'package:cherich_care_2/pages/questions/q_fourteen.dart';
import 'package:cherich_care_2/pages/questions/q_twelve.dart';
import 'package:flutter/material.dart';

class QThirteen extends StatelessWidget {
  const QThirteen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Genetics",
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
        MaterialPageRoute(builder: (context) => QTwelve()),
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
            'assets/images/q13.png', // Put your image path here
              height: 200,
              width: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              "GENETICS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "About 10% of the time, breast cancer is caused by a genetic mutation. \n"
              "Those with a genetic mutation can get access to additional testing, making it easier to find it early if it ever happens. \n"
              "Next are some genetic risk questions to think about.",
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
        MaterialPageRoute(builder: (context) => QFourteen()),
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