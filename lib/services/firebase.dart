
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

  


  // Add method for saving screening plan
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
          .child('screening_plans')
          .child(userId)
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
          .child('screening_plans')
          .child(userId)
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
          .child('screening_plans')
          .child(userId)
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
          .child('screening_plans')
          .child(userId)
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
        .child('screening_plans')
        .child(userId)
        .onValue;
  }

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



  Future<void> saveNote(String noteContent) async {
  print("FirebaseService: Starting saveNote"); // Debug print
  try {
    User? userId = Auth().currentUser;
    print("FirebaseService: Current user ID: ${userId?.uid}"); // Debug print
    
    if (userId != null) {
      String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      print("FirebaseService: Saving note for date: $date"); // Debug print
      
      await _database
          .child('users')
          .child(userId.uid)
          .child('notes')
          .child(date)
          .set({
        'content': noteContent,
        'timestamp': ServerValue.timestamp,
      });
      print("FirebaseService: Note saved successfully"); // Debug print
    } else {
      print("FirebaseService: No user logged in"); // Debug print
      throw Exception('No user logged in');
    }
  } catch (e) {
    print('FirebaseService: Error saving note: $e'); // Debug print
    throw e;
  }
}

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


  Future<String> getCountry() async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('country')
            .once();

        if (snapshot.snapshot.value != null) {
          return snapshot.snapshot.value.toString();
        }
      }
      return 'Sri Lanka'; // Default country
    } catch (e) {
      print('Error getting country: $e');
      return 'Sri Lanka';
    }
  }


  Future<void> saveUserData(Map<String, dynamic> userData) async {
  User? userId = Auth().currentUser;
  if (userId != null) {
    // If this is profile data (has username and email)
    if (userData.containsKey('username') && userData.containsKey('email')) {
      await _database.child('users').child(userId.uid).update(userData);
    } 
    // If this is additional user details from SignIn
    else {
      await _database.child('users').child(userId.uid).child('userdetails').set(userData);
    }
  }
}


  Future<Map<String, dynamic>> getUserData() async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        final snapshot = await _database.child('users').child(userId.uid).once();
        
        if (snapshot.snapshot.value != null) {
          final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
          print('Retrieved user data: $data'); // For debugging
          return {
            'username': data['username'] ?? '',
            'email': data['email'] ?? '',
            'profilePicture': data['profilePicture'] ?? 'assets/images/profile1.png',
          };
        }
      }
      return {
        'username': '',
        'email': '',
        'profilePicture': 'assets/images/profile1.png',
      };
    } catch (e) {
      print('Error in getUserData: $e');
      return {
        'username': '',
        'email': '',
        'profilePicture': 'assets/images/profile1.png',
      };
    }
  }


  Future<void> saveNameEmailChanges(String username, String email) async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        await _database.child('users').child(userId.uid).update({
          'username': username,
          'email': email,
          'lastUpdated': ServerValue.timestamp,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      print('Error saving name and email changes: $e');
      throw Exception('Failed to save changes');
    }
  }

 
  Future<Map<String, dynamic>> getInitialNameEmail() async {
    try {
      User? userId = Auth().currentUser;
      if (userId != null) {
        final snapshot = await _database.child('users').child(userId.uid).once();
        
        if (snapshot.snapshot.value != null) {
          final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
          return {
            'username': data['username'] ?? '',
            'email': data['email'] ?? '',
          };
        }
      }
      return {
        'username': '',
        'email': '',
      };
    } catch (e) {
      print('Error getting initial name and email: $e');
      return {
        'username': '',
        'email': '',
      };
    }
  }


  Future<bool> checkEmailExists(String email) async {
    try {
      final snapshot = await _database
          .child('users')
          .orderByChild('email')
          .equalTo(email)
          .once();
      
      return snapshot.snapshot.value != null;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }


  Future<void> saveProfileData(String username, String email) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      await _database.child('users').child(userId.uid).update({
        'username': username,
        'email': email,
        'lastUpdated': ServerValue.timestamp,
      });
    }
  }


  Future<Map<String, dynamic>> getProfileData() async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      final snapshot = await _database.child('users').child(userId.uid).once();
      if (snapshot.snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
        return {
          'username': data['username'] ?? '',
          'email': data['email'] ?? '',
        };
      }
    }
    return {
      'username': '',
      'email': '',
    };
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

  // Add this new method for saving profile picture
  Future<void> saveProfilePicture(String imagePath) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      await _database.child('users').child(userId.uid).update({
        'profilePicture': imagePath,
        'lastUpdated': ServerValue.timestamp,
      });
    }
  }

}
