  
import 'package:cherich_care_2/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com/')
      .ref();

      final FirebaseAuth _auth = FirebaseAuth.instance;
      
      
//       Future<void> saveNote(String noteContent) async {
//   print("FirebaseService: Starting saveNote"); // Debug print
//   try {
//     User? userId = Auth().currentUser;
//     print("FirebaseService: Current user ID: ${userId?.uid}"); // Debug print
    
//     if (userId != null) {
//       String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
//       print("FirebaseService: Saving note for date: $date"); // Debug print
      
//       await _database
//           .child('users')
//           .child(userId.uid)
//           .child('notes')
//           .child(date)
//           .set({
//         'content': noteContent,
//         'timestamp': ServerValue.timestamp,
//       });
//       print("FirebaseService: Note saved successfully"); // Debug print
//     } else {
//       print("FirebaseService: No user logged in"); // Debug print
//       throw Exception('No user logged in');
//     }
//   } catch (e) {
//     print('FirebaseService: Error saving note: $e'); // Debug print
//     throw e;
//   }
// }

  // Add method to get note for specific date
  Future<String?> getNote(String date) async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        DatabaseEvent event = await _database
            .child('users')
            .child(userId.uid)
            .child('notes')
            .child(date)
            .once();

        if (event.snapshot.value != null) {
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          return data['content'] as String?;
        }
      }
      return null;
    } catch (e) {
      print('Error getting note: $e');
      throw e;
    }
  }

  // Add method to get all notes
  Future<Map<String, String>> getAllNotes() async {
    print("Starting getAllNotes"); // Debug print
    try {
      User? userId = Auth().currentUser;
      Map<String, String> notes = {};

      if (userId != null) {
        print("Getting notes for user: ${userId.uid}"); // Debug print
        DatabaseEvent event = await _database
            .child('users')
            .child(userId.uid)
            .child('notes')
            .once();

        if (event.snapshot.value != null) {
          print("Found notes data: ${event.snapshot.value}"); // Debug print
          final data = event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            if (value is Map) {
              notes[key.toString()] = value['content']?.toString() ?? '';
              print("Loaded note for date $key: ${value['content']}"); // Debug print
            }
          });
        } else {
          print("No notes found"); // Debug print
        }
      } else {
        print("No user logged in"); // Debug print
      }

      return Map.fromEntries(
        notes.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key)) // Sort by date in descending order
      );
    } catch (e) {
      print('Error getting all notes: $e'); // Debug print
      throw e;
    }
  }



  Future<void> saveNote(String noteContent, String date) async {
  try {
    User? userId = Auth().currentUser;
    
    if (userId != null) {
      await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .child(date)
          .set({
        'content': noteContent,
        'timestamp': ServerValue.timestamp,
      });
    } else {
      throw Exception('No user logged in');
    }
  } catch (e) {
    print('FirebaseService: Error saving note: $e');
    throw e;
  }
}


  // Future<void> updateNote(String date, String updatedContent) async {
  //   try {
  //     User? userId = Auth().currentUser;
  //     if (userId != null) {
  //       await _database
  //           .child('users')
  //           .child(userId.uid)
  //           .child('notes')
  //           .child(date)
  //           .update({
  //         'content': updatedContent,
  //         'lastModified': ServerValue.timestamp,
  //       });
  //     }
  //   } catch (e) {
  //     print('Error updating note: $e');
  //     throw e;
  //   }
  // }


  // Future<void> deleteNote(String date) async {
  //   try {
  //     User? userId = Auth().currentUser;
  //     if (userId != null) {
  //       await _database
  //           .child('users')
  //           .child(userId.uid)
  //           .child('notes')
  //           .child(date)
  //           .remove();
  //     }
  //   } catch (e) {
  //     print('Error deleting note: $e');
  //     throw e;
  //   }
  // }
}