import 'package:cherich_care_2/pages/addmedicine/medicine_page3.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';

class MedicinePage2 extends StatefulWidget {
  final String medicineKey;
  
  const MedicinePage2({Key? key, required this.medicineKey}) : super(key: key);
  
  @override
  _MedicinePage2State createState() => _MedicinePage2State();
}

class _MedicinePage2State extends State<MedicinePage2> {
  final FirebaseService _firebaseService = FirebaseService();
  
  int frequency = 1;
  int doses = 2;
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  String _selectedInterval = "Everyday";  // Initialize with a default value

  final List<String> intervalOptions = [
    "Everyday",
    "Per Fortnight",
    "Every 2 days",
    "Every 5 days", 
    "Every 10 days", 
    "Every 15 days",
    "Per Week",             
    "Per Month",
    "Per Year"
  ];

  @override
  void initState() {
    super.initState();
    _loadScheduleDetails();
  }

  Future<void> _loadScheduleDetails() async {
    try {
      final medicineDetails = await _firebaseService.getMedicineDetails(widget.medicineKey);
      if (medicineDetails != null && medicineDetails['schedule'] != null) {
        final schedule = medicineDetails['schedule'] as Map<String, dynamic>;
        setState(() {
          frequency = schedule['frequency'] ?? 1;
          doses = schedule['doses'] ?? 2;
          if (schedule['selectedTime'] != null) {
            final timeParts = schedule['selectedTime'].toString().split(':');
            selectedTime = TimeOfDay(
              hour: int.parse(timeParts[0]),
              minute: int.parse(timeParts[1])
            );
          }
          if (schedule['interval'] != null && 
              intervalOptions.contains(schedule['interval'])) {
            _selectedInterval = schedule['interval'];
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading schedule details: $e')),
        );
      }
    }
  }

  Future<void> _saveAndNavigate() async {
    try {
      if (!intervalOptions.contains(_selectedInterval)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a valid interval')),
        );
        return;
      }

      await _firebaseService.updateMedicineSchedule(
        widget.medicineKey,
        frequency: frequency,
        doses: doses,
        selectedTime: selectedTime,
        interval: _selectedInterval,
      );
      
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicinePage3(medicineKey: widget.medicineKey),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving schedule details: $e')),
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
            const SizedBox(height: 30),
            const Text(
              "Interval",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _selectedInterval,
                isExpanded: true,
                underline: Container(),
                padding: EdgeInsets.symmetric(horizontal: 10),
                items: intervalOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedInterval = newValue;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            Text(
              "Frequency",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: frequency.toString()),
                    onChanged: (value) {
                      setState(() {
                        frequency = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Text("Time"),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      frequency++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (frequency > 1) frequency--;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            Text(
              "Reminder 1",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (pickedTime != null && pickedTime != selectedTime) {
                  setState(() {
                    selectedTime = pickedTime;
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "${selectedTime.hour.toString().padLeft(2, '0')} : ${selectedTime.minute.toString().padLeft(2, '0')}",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: doses.toString()),
                    onChanged: (value) {
                      setState(() {
                        doses = int.tryParse(value) ?? 2;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Text("Doses"),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      doses++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (doses > 1) doses--;
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
    );
  }
}