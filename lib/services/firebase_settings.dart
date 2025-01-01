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
    String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }
  

  Future<void> saveDoubleMastectomySetting(bool isEnabled) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        await _database.child('users').child(userId.uid).child('settings').update({
          'doubleMastectomy': isEnabled,
          'lastUpdated': ServerValue.timestamp,
        });
      } catch (e) {
        print('Error saving double mastectomy setting: $e');
        throw e;
      }
    }
  }

  Future<void> savePeriodTrackerSetting(bool isEnabled) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        await _database.child('users').child(userId.uid).child('settings').update({
          'periodTracker': isEnabled,
          'lastUpdated': ServerValue.timestamp,
        });
      } catch (e) {
        print('Error saving period tracker setting: $e');
        throw e;
      }
    }
  }

  Future<bool> getDoubleMastectomySetting() async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('doubleMastectomy')
            .once();
        return snapshot.snapshot.value as bool? ?? true;
      } catch (e) {
        print('Error getting double mastectomy setting: $e');
        return true;
      }
    }
    return true;
  }

  Future<bool> getPeriodTrackerSetting() async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('periodTracker')
            .once();
        return snapshot.snapshot.value as bool? ?? true;
      } catch (e) {
        print('Error getting period tracker setting: $e');
        return true;
      }
    }
    return true;
  }

}