import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/questions/q_one.dart';
import 'package:cherich_care_2/pages/questions/q_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class QTwo extends StatefulWidget {
 @override
 _QTwoState createState() => _QTwoState();
}

class _QTwoState extends State<QTwo> {
 final DatabaseReference _database = FirebaseDatabase.instanceFor(
   app: Firebase.app(),
   databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com'
 ).ref();

 final FirebaseAuth _auth = FirebaseAuth.instance;
 DateTime selectedDate = DateTime(1999, 8, 13);

 Future<void> _saveResponse(BuildContext context) async {
   try {
     User? currentUser = _auth.currentUser;
     if (currentUser != null) {
       String formattedDate = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
       await _database
         .child('users')
         .child(currentUser.uid)
         .child('quiz_responses')
         .child('q02')
         .set({
           'response': formattedDate,
           'age': _calculateAge(selectedDate),
           'timestamp': ServerValue.timestamp,
       });
       if (mounted) {
         Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(builder: (context) => QThree()),
           (route) => false,
         );
       }
     } else {
       throw Exception('No user logged in');
     }
   } catch (e) {
     if (mounted) {
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
             MaterialPageRoute(builder: (context) => QOne()),
             (route) => false,
           );
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
             color: Color.fromARGB(255, 0, 0, 0),
           ),
           const SizedBox(height: 16),
           Container(
             padding: const EdgeInsets.all(16.0),
             decoration: BoxDecoration(
               color: Colors.blue.shade50,
               borderRadius: BorderRadius.circular(12),
             ),
             child: Column(
               children: [
                 const Text(
                   "When were you born?",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),
                 ),
                 const SizedBox(height: 16),
                 GestureDetector(
                   onTap: () async {
                     final DateTime? pickedDate = await showDatePicker(
                       context: context,
                       initialDate: selectedDate,
                       firstDate: DateTime(1900),
                       lastDate: DateTime.now(),
                     );
                     if (pickedDate != null && pickedDate != selectedDate) {
                       setState(() {
                         selectedDate = pickedDate;
                       });
                     }
                   },
                   child: Container(
                     padding: const EdgeInsets.symmetric(
                         horizontal: 16.0, vertical: 12.0),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(8),
                       border: Border.all(color: Colors.grey),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "${selectedDate.day} ${_monthName(selectedDate.month)} ${selectedDate.year}",
                           style: const TextStyle(fontSize: 16),
                         ),
                         const Icon(Icons.calendar_today, color: Colors.grey),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(height: 16),
                 Text(
                   "Age: ${_calculateAge(selectedDate)}",
                   style: const TextStyle(
                     fontSize: 16,
                     color: Colors.black,
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 24),
           ElevatedButton(
             onPressed: () => _saveResponse(context),
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.black,
               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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

 String _monthName(int month) {
   const months = [
     "January",
     "February",
     "March",
     "April",
     "May",
     "June",
     "July",
     "August",
     "September",
     "October",
     "November",
     "December"
   ];
   return months[month - 1];
 }

 int _calculateAge(DateTime birthDate) {
   final today = DateTime.now();
   int age = today.year - birthDate.year;
   if (today.month < birthDate.month ||
       (today.month == birthDate.month && today.day < birthDate.day)) {
     age--;
   }
   return age;
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
