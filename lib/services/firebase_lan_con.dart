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
      
      
      Future<void> saveLanguage(String language) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      await _database.child('users').child(userId.uid).child('settings').update({
        'language': language,
        'lastUpdated': ServerValue.timestamp,
      });
    }
  }


  Future<String> getLanguage() async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('language')
            .once();

        if (snapshot.snapshot.value != null) {
          return snapshot.snapshot.value.toString();
        }
      }
      return 'English'; // Default language
    } catch (e) {
      print('Error getting language: $e');
      return 'English';
    }
  }


  Future<void> saveCountry(String country) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      await _database.child('users').child(userId.uid).child('settings').update({
        'country': country,
        'lastUpdated': ServerValue.timestamp,
      });
    }
  }

}