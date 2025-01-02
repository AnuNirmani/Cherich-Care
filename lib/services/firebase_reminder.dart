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
      
      
      Future<void> saveReminders(Map<String, bool> reminders, Map<String, String> daysInfo) async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        Map<String, dynamic> reminderData = {};
        
        for (var title in reminders.keys) {
          reminderData[title] = {
            'isActive': reminders[title],
            'daysInfo': daysInfo[title] ?? '',
            'lastUpdated': ServerValue.timestamp,
          };
        }
        
        await _database
            .child('users')
            .child(userId.uid)
            .child('reminders')
            .set(reminderData);
      }
    } catch (e) {
      print('Error saving reminders: $e');
      throw Exception('Failed to save reminders');
    }
  }

  Future<void> updateSingleReminder(String title, bool isActive, String daysInfo) async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        await _database
            .child('users')
            .child(userId.uid)
            .child('reminders')
            .child(title)
            .update({
          'isActive': isActive,
          'daysInfo': daysInfo,
          'lastUpdated': ServerValue.timestamp,
        });
      }
    } catch (e) {
      print('Error updating reminder: $e');
      throw Exception('Failed to update reminder');
    }
  }

  Future<Map<String, dynamic>> getReminders() async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('reminders')
            .once();

        if (snapshot.snapshot.value != null) {
          final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
          
          Map<String, bool> reminders = {};
          Map<String, String> daysInfo = {};

          data.forEach((key, value) {
            if (value is Map) {
              Map<String, dynamic> reminderData = Map<String, dynamic>.from(value);
              reminders[key] = reminderData['isActive'] ?? false;
              daysInfo[key] = reminderData['daysInfo'] ?? '';
            }
          });

          return {
            'reminders': reminders,
            'daysInfo': daysInfo,
          };
        }
      }
      return {
        'reminders': <String, bool>{},
        'daysInfo': <String, String>{},
      };
    } catch (e) {
      print('Error getting reminders: $e');
      return {
        'reminders': <String, bool>{},
        'daysInfo': <String, String>{},
      };
    }
  }
}