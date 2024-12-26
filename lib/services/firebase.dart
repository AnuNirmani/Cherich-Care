import 'package:cherich_care_2/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com/')
      .ref();

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    User? userId = Auth().currentUser;
    await _database.child('users').child(userId?.uid ?? "").set(userData);
  }

  Future<void> saveSymptoms(Map<String, dynamic> symptomsData) async {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    User? userId = Auth().currentUser;
    await _database
        .child('users')
        .child(userId?.uid ?? "")
        .child("symptom")
        .child(formattedDate)
        .set(symptomsData);
  }

  Future<Map<String, dynamic>> fetchSymptoms() async {
    try {
      final userId = Auth().currentUser?.uid ?? "";
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child("symptom")
          .child("2024-12-17")
          .child("symptoms")
          .once();

      if (snapshot.snapshot.value != null) {
        // Cast the data to Map<String, dynamic>
        final data = snapshot.snapshot.value;
        print(data);
        return {"data": data};
        // Convert any nested maps to Map<String, dynamic>
        // return data.map((k, v) => MapEntry(
        //     k.toString(), v is Map ? Map<String, dynamic>.from(v) : v));
      } else {
        return {};
      }
      return {};
    } catch (e) {
      print('Error fetching symptoms: $e');
      return {};
    }
  }
}
