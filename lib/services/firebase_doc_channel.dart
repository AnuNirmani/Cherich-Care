import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com/'
  ).ref();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch available dates
  Future<List<String>> fetchAvailableDates() async {
  try {
    DatabaseEvent event = await _database.child('dates').once();
    
    if (event.snapshot.value != null) {
      final List<dynamic> values = event.snapshot.value as List;
      List<String> dates = [];
      
      for (var value in values) {
        if (value != null) {
          dates.add(value.toString());
        }
      }
      
      dates.sort();
      return dates;
    }
    return [];
  } catch (e) {
    print('Error fetching dates: $e');
    return [];
  }
}

  // Save a new date
  Future<void> saveDate(String date) async {
    try {
      DatabaseReference newDateRef = _database.child('dates').push();
      await newDateRef.set(date);
    } catch (e) {
      print('Error saving date: $e');
      throw e;
    }
  }

  // Delete a date
  Future<void> deleteDate(String dateKey) async {
    try {
      await _database.child('dates').child(dateKey).remove();
    } catch (e) {
      print('Error deleting date: $e');
      throw e;
    }
  }
}