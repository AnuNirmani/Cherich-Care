import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/end_q.dart';
import 'package:cherich_care_2/pages/questions/q_eighteen.dart';
import 'package:cherich_care_2/pages/questions/q_eleven.dart';
import 'package:cherich_care_2/pages/questions/q_sixteen.dart';
import 'package:cherich_care_2/pages/questions/q_thirteen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class QSeventeen extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com'
  ).ref();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _saveResponse(BuildContext context, String response) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        await _database
          .child('users')
          .child(currentUser.uid)
          .child('quiz_responses')
          .child('q17')
          .set({
            'response': response,
            'timestamp': ServerValue.timestamp,
        });
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  QEighteen()),
            (route) => false,
          );
        }
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving response: $e'))
        );
      }
    }
  }

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
              MaterialPageRoute(builder: (context) =>  QSixteen()),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => _showExitDialog(context),
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
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Have you tested positive for a BRCA genetic mutation",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton(
      onPressed: () => _saveResponse(context, 'yes'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        side: const BorderSide(color: Colors.black, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(200, 45), // Make buttons wider
      ),
      child: const Text(
        "Yes",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
    const SizedBox(height: 18), // Add space between buttons
    ElevatedButton(
      onPressed: () => _saveResponse(context, 'No, but Iwas tested'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(200, 45),
      ),
      child: const Text(
        "No, but I was tested",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
    const SizedBox(height: 18),
    ElevatedButton(
      onPressed: () => _saveResponse(context, 'No, I have not been tested'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(200, 45),
      ),
      child: const Text(
        "No, I have not been tested",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
    const SizedBox(height: 18),

  ],
),
                    ],
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

void _showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "Are you sure you want to exit the quiz?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
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
