import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/q_four.dart';
import 'package:cherich_care_2/pages/questions/q_six.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class QFive extends StatelessWidget {
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
         .child('q05')
         .set({
           'response': response,
           'timestamp': ServerValue.timestamp,
       });
       if (context.mounted) {
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(builder: (context) => QSix()),
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
             MaterialPageRoute(builder: (context) => const QFour()),
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
            'assets/images/q5.png', // Put your image path here
              height: 100,
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
                   "Have you entered menopause yet? \n\n (no period for at least 12 months)",
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
                     ElevatedButton(
                       onPressed: () => _saveResponse(context, 'yes'),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                         side: const BorderSide(color: Colors.black, width: 1),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8),
                         ),
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
                     ElevatedButton(
                       onPressed: () => _saveResponse(context, 'no'),
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.white,
                         side: const BorderSide(color: Colors.black, width: 1),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8),
                         ),
                       ),
                       child: const Text(
                         "No",
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                           color: Colors.black,
                         ),
                       ),
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