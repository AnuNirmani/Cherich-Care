
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

  


  

   // Create a new medicine
  Future<String> createNewMedicine(String pillName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final newMedicineKey = _database.child('medicines').push().key;
      
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(newMedicineKey!)
        .set({
          'pillName': pillName,
          'createdAt': ServerValue.timestamp,
          'status': 'active',
          'startDate': DateTime.now().toIso8601String(),
          'isNotificationEnabled': false,
          'isForever': false,
          'durationDays': 14,
        });
        
      return newMedicineKey;
    }
    throw Exception('User not authenticated');
  }

  // Update medicine basic details
  Future<void> updateMedicineBasicDetails(
    String medicineKey, {
    required String medicineName,
    required bool isNotificationEnabled,
    required bool isForever,
    required int durationDays,
    required DateTime startDate, required String selectedInterval,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .update({
          'medicineName': medicineName,
          'isNotificationEnabled': isNotificationEnabled,
          'isForever': isForever,
          'durationDays': durationDays,
          'startDate': startDate.toIso8601String(),
          'updatedAt': ServerValue.timestamp,
        });
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Update medicine schedule
  Future<void> updateMedicineSchedule(
    String medicineKey, {
    required int frequency,
    required int doses,
    required TimeOfDay selectedTime,
    required String interval,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .child('schedule')
        .set({
          'frequency': frequency,
          'doses': doses,
          'selectedTime': '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
          'interval': interval,
          'updatedAt': ServerValue.timestamp,
        });
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Update notification settings
  Future<void> updateMedicineNotifications(
    String medicineKey, {
    required String notificationText,
    required String snoozeSettings,
    required bool isVibrate,
    required bool isRingtoneEnabled,
    String ringtone = 'Default (Spaceline)',
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .child('notifications')
        .set({
          'notificationText': notificationText,
          'snoozeSettings': snoozeSettings,
          'isVibrate': isVibrate,
          'isRingtoneEnabled': isRingtoneEnabled,
          'ringtone': ringtone,
          'updatedAt': ServerValue.timestamp,
        });
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Get medicine details
  Future<Map<String, dynamic>?> getMedicineDetails(String medicineKey) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .get();
        
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      }
      return null;
    }
    throw Exception('User not authenticated');
  }

  // Get all medicines
  Future<List<Map<String, dynamic>>> getAllMedicines() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .get();
        
      if (snapshot.exists) {
        final medicinesMap = Map<String, dynamic>.from(snapshot.value as Map);
        return medicinesMap.entries.map((entry) {
          final medicine = Map<String, dynamic>.from(entry.value as Map);
          medicine['key'] = entry.key;
          return medicine;
        }).toList();
      }
      return [];
    }
    throw Exception('User not authenticated');
  }

  // Delete medicine
  Future<void> deleteMedicine(String medicineKey) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .remove();
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Toggle medicine status (active/inactive)
  Future<void> toggleMedicineStatus(String medicineKey, bool isActive) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .update({
          'status': isActive ? 'active' : 'inactive',
          'updatedAt': ServerValue.timestamp,
        });
    } else {
      throw Exception('User not authenticated');
    }
  }

  // Stream all medicines for real-time updates
  Stream<DatabaseEvent> allMedicinesStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .onValue;
    }
    throw Exception('User not authenticated');
  }

  // Stream single medicine details
  Stream<DatabaseEvent> medicineSingleStream(String medicineKey) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .onValue;
    }
    throw Exception('User not authenticated');
  }

  // Update specific medicine field
  Future<void> updateMedicineField(
    String medicineKey,
    String field,
    dynamic value,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _database
        .child('users')
        .child(user.uid)
        .child('medicines')
        .child(medicineKey)
        .update({
          field: value,
          'updatedAt': ServerValue.timestamp,
        });
    } else {
      throw Exception('User not authenticated');
    }
  }
}