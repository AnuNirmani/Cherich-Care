import 'package:cherich_care_2/pages/addmedicine/medicine_page.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddMedicine extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
   AddMedicine({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Medicine',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Hold to delete record',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Add Medicine'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return _PillNameDialog(
                            onSuccess: (String medicineKey) {
                              // First pop the dialog
                              Navigator.pop(dialogContext);
                              // Then navigate to the medicine page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicinePage(medicineKey: medicineKey),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                
                StreamBuilder<DatabaseEvent>(
  stream: firebaseService.allMedicinesStream(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    
    if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
      return const Center(child: Text('No medicines added yet'));
    }

    final medicines = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
    
    return Expanded(
      child: ListView.builder(
        itemCount: medicines.entries.length,
        itemBuilder: (context, index) {
          final entry = medicines.entries.elementAt(index);
          final medicine = Map<String, dynamic>.from(entry.value as Map);
          
          // Format the time if available
          String reminderTime = '';
          if (medicine['schedule'] != null && medicine['schedule']['selectedTime'] != null) {
            reminderTime = medicine['schedule']['selectedTime'];
          }

          // Format other details
          final isNotificationEnabled = medicine['isNotificationEnabled'] ?? false;
          final durationDays = medicine['durationDays']?.toString() ?? '';
          final interval = medicine['schedule']?['interval'] ?? '';

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                radius: 30,
                child: Image.asset(
                  "assets/images/pin.png",
                  fit: BoxFit.contain,
                  width: 40,
                  height: 40,
                ),
              ),
              title: Text(
                medicine['pillName'] ?? 'Unknown Medicine',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (reminderTime.isNotEmpty)
                    Text('Time: $reminderTime'),
                  if (interval.isNotEmpty)  
                    Text('Interval: $interval'),
                  if (durationDays.isNotEmpty)
                    Text('Duration: $durationDays days'),
                  Text('Notifications: ${isNotificationEnabled ? "On" : "Off"}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  isNotificationEnabled ? Icons.notifications_active : Icons.notifications_off,
                  color: isNotificationEnabled ? Colors.pinkAccent : Colors.grey,
                ),
                onPressed: () async {
                  try {
                    await firebaseService.updateMedicineBasicDetails(
                      entry.key,
                      medicineName: medicine['pillName'],
                      isNotificationEnabled: !isNotificationEnabled,
                      isForever: medicine['isForever'] ?? false,
                      durationDays: medicine['durationDays'] ?? 14,
                      startDate: DateTime.parse(medicine['startDate'] ?? DateTime.now().toIso8601String()), selectedInterval: '',
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notifications ${!isNotificationEnabled ? "enabled" : "disabled"}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error updating notifications: $e')),
                    );
                  }
                },
              ),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MedicinePage(medicineKey: entry.key),
              //     ),
              //   );
              // },
              onTap: () async {
                showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Delete Medicine',
          style: TextStyle(color: Colors.black),
        ),
        content: const Text(
          'Are you sure you want to delete this medicine?',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close dialog
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Close dialog first
              Navigator.of(dialogContext).pop();
              
              // Then perform delete operation
              try {
                await firebaseService.deleteMedicine(entry.key);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Medicine deleted successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting medicine: $e')),
                  );
                }
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
              },
            ),
          );
        },
      ),
    );
  },
)
              ],
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildListItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    required Widget trailingWidget,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }){
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 251, 251, 251),
          radius: 30,
          child: Image.asset(
            iconPath,
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: trailingWidget,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}





class _PillNameDialog extends StatefulWidget {
  final Function(String) onSuccess;

  const _PillNameDialog({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  _PillNameDialogState createState() => _PillNameDialogState();
}

class _PillNameDialogState extends State<_PillNameDialog> {
  final TextEditingController _pillNameController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Pill Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
  controller: _pillNameController,  // Add this line
  decoration: const InputDecoration(
    labelText: 'Pill Name',
    border: OutlineInputBorder(),
  ),
),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 248, 17, 0),
                  ),
                  child: const Text('Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
                 ElevatedButton(
                  onPressed: () async {
                    if (_pillNameController.text.isNotEmpty) {
                      try {
                        final medicineKey = await firebaseService.createNewMedicine(
                          _pillNameController.text
                        );
                        widget.onSuccess(medicineKey);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a pill name')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 0, 255),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pillNameController.dispose();
    super.dispose();
  }
}
