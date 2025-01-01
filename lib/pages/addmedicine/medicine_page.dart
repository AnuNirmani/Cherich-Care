import 'package:cherich_care_2/pages/addmedicine/medicine_page2.dart';
import 'package:cherich_care_2/services/firebase_medecine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MedicinePage extends StatefulWidget {
  final String medicineKey;
  
  const MedicinePage({Key? key, required this.medicineKey}) : super(key: key);
  
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isNotificationEnabled = false;
  bool isForever = false;
  int durationDays = 14;
  DateTime startDate = DateTime.now();
  String selectedInterval = "Everyday";
  final TextEditingController medicineNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key

  @override
  void initState() {
    super.initState();
    _loadMedicineDetails();
  }

  Future<void> _loadMedicineDetails() async {
    try {
      final medicineDetails = await _firebaseService.getMedicineDetails(widget.medicineKey);
      if (medicineDetails != null) {
        setState(() {
          medicineNameController.text = medicineDetails['medicineName'] ?? '';
          isNotificationEnabled = medicineDetails['isNotificationEnabled'] ?? false;
          isForever = medicineDetails['isForever'] ?? false;
          durationDays = medicineDetails['durationDays'] ?? 14;
          if (medicineDetails['startDate'] != null) {
            startDate = DateTime.parse(medicineDetails['startDate']);
          }
          selectedInterval = medicineDetails['selectedInterval'] ?? "Everyday";
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading medicine details: $e')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  Future<void> _saveAndNavigate() async {
    if (medicineNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a medicine name')),
      );
      return;
    }

    try {
      await _firebaseService.updateMedicineBasicDetails(
        widget.medicineKey,
        medicineName: medicineNameController.text.trim(),
        isNotificationEnabled: isNotificationEnabled,
        isForever: isForever,
        durationDays: durationDays,
        startDate: startDate,
        selectedInterval: selectedInterval,
      );
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicinePage2(medicineKey: widget.medicineKey),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving medicine details: $e')),
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Medicine Name",
                    style: TextStyle(fontSize: 18),
                  ),
                  Checkbox(
                    value: isNotificationEnabled,
                    onChanged: (value) {
                      setState(() {
                        isNotificationEnabled = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Updated TextField with validation
              TextFormField(
                controller: medicineNameController,
                decoration: InputDecoration(
                  labelText: "Tap to edit",
                  hintText: "Medicine Name",
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a medicine name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Divider(thickness: 1, color: Colors.black26),
              const SizedBox(height: 20),
              const Text(
                "Duration",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: isForever,
                          onChanged: (value) {
                            setState(() {
                              isForever = value ?? false;
                            });
                          },
                        ),
                        Text("Forever"),
                      ],
                    ),
                  ),
                  if (!isForever)
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController(
                                text: durationDays.toString()),
                            onChanged: (value) {
                              setState(() {
                                durationDays = int.tryParse(value) ?? 14;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("Days"),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              durationDays++;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (durationDays > 1) durationDays--;
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              const Divider(thickness: 1, color: Colors.black26),
              SizedBox(height: 20),
              const Text(
                "Start Date",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText:
                          "${startDate.day} ${_monthName(startDate.month)}, ${startDate.year}",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Spacer(),
              Center(
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveAndNavigate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Next",
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
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    medicineNameController.dispose();
    super.dispose();
  }
}