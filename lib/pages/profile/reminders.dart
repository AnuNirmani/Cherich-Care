
import 'package:cherich_care_2/services/firebase_reminder.dart';
import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = true;
  bool _hasUnsavedChanges = false;
  
  final Map<String, bool> _reminders = {
    'Self Check': false,
    'Period Cycle': false,
    'Mammogram': false,
    'Doctor Visit': false,
    'Breast MRI': false,
  };

  final Map<String, String> _daysInfo = {
    'Self Check': '26 days',
    'Period Cycle': '30 days',
    'Mammogram': '',
    'Doctor Visit': '',
    'Breast MRI': '',
  };

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final savedData = await _firebaseService.getReminders();
      
      if (savedData['reminders'].isNotEmpty) {
        setState(() {
          _reminders.addAll(Map<String, bool>.from(savedData['reminders']));
          _daysInfo.addAll(Map<String, String>.from(savedData['daysInfo']));
        });
      }
    } catch (e) {
      debugPrint('Error loading saved data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      _isLoading = true;
    });
    
    // Debug print to verify data being saved
    print('Saving reminder states: $_reminders');

    try {
      await _firebaseService.saveReminders(_reminders, _daysInfo);
      setState(() {
        _hasUnsavedChanges = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reminders saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save reminders'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Reminders',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_hasUnsavedChanges) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Unsaved Changes'),
                  content: const Text('Do you want to save your changes before leaving?'),
                  actions: [
                    TextButton(
                      child: const Text('Discard'),
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Go back
                      },
                    ),
                    TextButton(
                      child: const Text('Save'),
                      onPressed: () async {
                        await _saveChanges();
                        if (mounted) {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back
                        }
                      },
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '\nChoose which reminders you\nwant to get from us:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  children: _reminders.keys.map((key) {
                    return _buildReminderRow(key, _reminders[key]!, _daysInfo[key]!);
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _hasUnsavedChanges ? _saveChanges : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _hasUnsavedChanges ? Colors.white : Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildReminderRow(String title, bool isActive, String daysInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (daysInfo.isNotEmpty)
                  Text(
                    daysInfo,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            activeColor: Colors.pinkAccent,
            onChanged: (value) {
              setState(() {
                _reminders[title] = value;
                _hasUnsavedChanges = true;
              });
            },
          ),
        ],
      ),
    );
  }
}