import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';

class MedicinePage3 extends StatefulWidget {
  final String medicineKey;
  
  const MedicinePage3({Key? key, required this.medicineKey}) : super(key: key);
  
  @override
  _MedicinePage3State createState() => _MedicinePage3State();
}

class _MedicinePage3State extends State<MedicinePage3> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _notificationTextController = TextEditingController();
  final TextEditingController _snoozeController = TextEditingController();

  // Changed default value to match dropdown items
  String _selectedSnooze = "2 minutes";
  
  // Define snooze options as a constant
  final List<String> snoozeOptions = [
    "2 minutes",
    "5 minutes",
    "10 minutes",
    "30 minutes",
    "1 hour",
    "2 hours"
  ];
  
  bool isVibrate = true;
  bool isRingtoneEnabled = true;
  String ringtone = 'Default (Spaceline)';

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    try {
      final medicineDetails = await _firebaseService.getMedicineDetails(widget.medicineKey);
      if (medicineDetails != null && medicineDetails['notifications'] != null) {
        final notifications = medicineDetails['notifications'] as Map<String, dynamic>;
        setState(() {
          _notificationTextController.text = notifications['notificationText'] ?? '';
          _snoozeController.text = notifications['snoozeSettings'] ?? '0 minute, 0 time';
          isVibrate = notifications['isVibrate'] ?? true;
          isRingtoneEnabled = notifications['isRingtoneEnabled'] ?? true;
          ringtone = notifications['ringtone'] ?? 'Default (Spaceline)';
          
          // Safely set snooze value
          final loadedSnooze = notifications['snooze'];
          if (loadedSnooze != null && snoozeOptions.contains(loadedSnooze)) {
            _selectedSnooze = loadedSnooze;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading notification settings: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100], 
        elevation: 0,
        title: Text( 
          "Medicine Reminder",
          style: TextStyle(color: Colors.pink[700]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[700]),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            const Text(
              "Notification Text",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _notificationTextController,
              decoration: InputDecoration(
                labelText: "Tap to edit",
                hintText: "Take your medicine",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            Text(
              "Snooze",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedSnooze,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: snoozeOptions.map((String interval) {
                return DropdownMenuItem<String>(
                  value: interval,
                  child: Text(interval),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSnooze = newValue;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Vibrate",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Checkbox(
                  value: isVibrate,
                  activeColor: Colors.pink,
                  onChanged: (bool? value) {
                    setState(() {
                      isVibrate = value ?? false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ringtone",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        ringtone,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: isRingtoneEnabled,
                  activeColor: Colors.pink,
                  onChanged: (bool? value) {
                    setState(() {
                      isRingtoneEnabled = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _firebaseService.updateMedicineNotifications(
                        widget.medicineKey,
                        notificationText: _notificationTextController.text,
                        snoozeSettings: _selectedSnooze,
                        isVibrate: isVibrate,
                        isRingtoneEnabled: isRingtoneEnabled,
                        ringtone: ringtone,
                      );
                      
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Medicine reminder saved successfully!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error saving notification settings: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _notificationTextController.dispose();
    _snoozeController.dispose();
    super.dispose();
  }
}