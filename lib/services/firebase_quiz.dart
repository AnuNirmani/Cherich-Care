import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseQuizService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com'
  ).ref().child('users');

  Future<void> saveResponse(String userId, String questionId, String response) async {
    try {
      await _database
        .child('users')
        .child(userId)
        .child('quiz_responses')
        .child(questionId)
        .set({
          'response': response,
          'timestamp': ServerValue.timestamp,
      });
    } catch (e) {
      print('Error saving response: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>?> getAllResponses(String userId) async {
    try {
      DatabaseEvent event = await _database
        .child(userId)
        .child('quiz_responses')
        .once();
      return event.snapshot.value as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting responses: $e');
      return null;
    }
  }
}