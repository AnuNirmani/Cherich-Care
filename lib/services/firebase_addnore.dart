import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';


class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com/')
      .ref();


 Future<void> saveNote(String noteContent, String date) async {
    try {
      final User? userId = FirebaseAuth.instance.currentUser;
      if (userId == null) throw Exception('No user logged in');

      await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .child(date)
          .set({
        'content': noteContent,
        'timestamp': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error saving note: $e');
      throw Exception('Failed to save note: $e');
    }
  }

  // Get note for specific date
  Future<String?> getNote(String date) async {
    try {
      final User? userId = FirebaseAuth.instance.currentUser;
      if (userId == null) throw Exception('No user logged in');

      final snapshot = await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .child(date)
          .child('content')
          .once();

      if (snapshot.snapshot.value != null) {
        return snapshot.snapshot.value.toString();
      }
      return null;
    } catch (e) {
      print('Error getting note: $e');
      throw Exception('Failed to get note: $e');
    }
  }

  // Get all notes for the user
  Future<Map<String, String>> getAllNotes() async {
    try {
      final User? userId = FirebaseAuth.instance.currentUser;
      if (userId == null) throw Exception('No user logged in');

      final snapshot = await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .once();

      if (snapshot.snapshot.value != null) {
        final Map<dynamic, dynamic> values = 
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        
        return Map<String, String>.fromEntries(
          values.entries.map((entry) => MapEntry(
            entry.key.toString(),
            (entry.value['content'] ?? '').toString(),
          )),
        );
      }
      return {};
    } catch (e) {
      print('Error getting all notes: $e');
      throw Exception('Failed to get notes: $e');
    }
  }

  // Delete note for specific date
  Future<void> deleteNote(String date) async {
    try {
      final User? userId = FirebaseAuth.instance.currentUser;
      if (userId == null) throw Exception('No user logged in');

      await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .child(date)
          .remove();
    } catch (e) {
      print('Error deleting note: $e');
      throw Exception('Failed to delete note: $e');
    }
  }
}