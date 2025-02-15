
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

String getTodayDate() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}

final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initializeUserSettings(String userId) async {
    try {
      await _database.child('users').child(userId).child('settings').set({
        'doubleMastectomy': false,
        'periodTracker': false,
        'country': 'Sri Lanka'
      });
    } catch (e) {
      print('Error initializing user settings: $e');
      throw e;
    }
  }

      

    Future<void> saveDoubleMastectomySetting(bool value) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _database
            .child('users')
            .child(user.uid)
            .child('settings')
            .child('doubleMastectomy')
            .set(value);
      }
    } catch (e) {
      print('Error saving double mastectomy setting: $e');
      throw e;
    }
  }

  Future<void> savePeriodTrackerSetting(bool value) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _database
            .child('users')
            .child(user.uid)
            .child('settings')
            .child('periodTracker')
            .set(value);
      }
    } catch (e) {
      print('Error saving period tracker setting: $e');
      throw e;
    }
  }

   Future<bool> getDoubleMastectomySetting() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DatabaseEvent event = await _database
            .child('users')
            .child(user.uid)
            .child('settings')
            .child('doubleMastectomy')
            .once();
        return event.snapshot.value as bool? ?? false;
      }
      return false;
    } catch (e) {
      print('Error getting double mastectomy setting: $e');
      return false;
    }
  }

  Future<bool> getPeriodTrackerSetting() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DatabaseEvent event = await _database
            .child('users')
            .child(user.uid)
            .child('settings')
            .child('periodTracker')
            .once();
        return event.snapshot.value as bool? ?? false;
      }
      return false;
    } catch (e) {
      print('Error getting period tracker setting: $e');
      return false;
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
      print(userId);
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child("symptom")
          .child(getTodayDate())
          .child("symptoms")
          .once();
print(snapshot.snapshot.value);
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



Future<String> getCountry() async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('country')
            .once();
        return snapshot.snapshot.value?.toString() ?? 'Sri Lanka';
      } catch (e) {
        print('Error getting country: $e');
        return 'Sri Lanka';
      }
    }
    return 'Sri Lanka';
  }

  Future<void> saveCountry(String country) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        await _database.child('users').child(userId.uid).child('settings').update({
          'country': country,
          'lastUpdated': ServerValue.timestamp,
        });
      } catch (e) {
        print('Error saving country: $e');
        throw e;
      }
    }
  }

  Future<void> saveUserSettingsCountry(String country) async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        await _database.child('users').child(userId.uid).child('settings').update({
          'country': country,
          'lastUpdated': ServerValue.timestamp,
        });
      } catch (e) {
        print('Error saving country in settings: $e');
        throw e;
      }
    }
  }

  Future<String> getUserSettingsCountry() async {
    User? userId = Auth().currentUser;
    if (userId != null) {
      try {
        final snapshot = await _database
            .child('users')
            .child(userId.uid)
            .child('settings')
            .child('country')
            .once();
        
        return snapshot.snapshot.value?.toString() ?? 'Sri Lanka';
      } catch (e) {
        print('Error getting country from settings: $e');
        return 'Sri Lanka';
      }
    }
    return 'Sri Lanka';
  }




}
