import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';



class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com/')
      .ref();

      final FirebaseAuth _auth = FirebaseAuth.instance;

 // Add new method for saving screening plan
  Future<void> saveScreeningPlan({
    required String doctorVisit,
    required String mammogram,
    required String breastMRI,
  }) async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      Map<String, dynamic> screeningPlanData = {
        'doctorVisit': doctorVisit,
        'mammogram': mammogram,
        'breastMRI': breastMRI,
        'userId': userId,
        'createdAt': ServerValue.timestamp,
      };

      await _database
        .child('users')
        .child(userId)
        .child('screening_plans')
          .set(screeningPlanData);
    } catch (e) {
      print('Error saving screening plan: $e');
      rethrow;
    }
  }

  // Add method for getting screening plan
  Future<Map<String, dynamic>?> getScreeningPlan() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      DatabaseEvent event = await _database
        .child('users')
        .child(userId)
        .child('screening_plans')
          .once();

      if (event.snapshot.value != null) {
        return Map<String, dynamic>.from(event.snapshot.value as Map);
      }
      return null;
    } catch (e) {
      print('Error getting screening plan: $e');
      rethrow;
    }
  }

  // Add method for updating screening plan
  Future<void> updateScreeningPlan({
    required String doctorVisit,
    required String mammogram,
    required String breastMRI,
  }) async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      Map<String, dynamic> updates = {
        'doctorVisit': doctorVisit,
        'mammogram': mammogram,
        'breastMRI': breastMRI,
        'updatedAt': ServerValue.timestamp,
      };

      await _database
        .child('users')
        .child(userId)
        .child('screening_plans')
          .update(updates);
    } catch (e) {
      print('Error updating screening plan: $e');
      rethrow;
    }
  }

  // Add method for deleting screening plan
  Future<void> deleteScreeningPlan() async {
    try {
      final String? userId = _auth.currentUser?.uid;
      if (userId == null) {
        throw Exception('No user logged in');
      }

      await _database
        .child('users')
        .child(userId)
        .child('screening_plans')
          .remove();
    } catch (e) {
      print('Error deleting screening plan: $e');
      rethrow;
    }
  }

  // Add method for real-time updates
  Stream<DatabaseEvent> screeningPlanStream() {
    final String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('No user logged in');
    }
    
    return _database
        .child('users')
        .child(userId)
        .child('screening_plans')
        .onValue;
  }
}