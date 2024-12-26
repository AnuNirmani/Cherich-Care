import 'package:cherich_care_2/pages/addmedicine/medicine_page3.dart';
import 'package:flutter/material.dart';

class MedicinePage2 extends StatefulWidget {
  @override
  _MedicinePage2State createState() => _MedicinePage2State();
}

class _MedicinePage2State extends State<MedicinePage2> {
  int frequency = 1;
  int doses = 2;
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    var selectedInterval;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        title: Text(
          "Vienva Reminder",
          style: TextStyle(color: Colors.pink[700]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[700]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 30),
            // Interval Section
            const Text(
              "Interval",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedInterval,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: [
                "Everyday",
                "Per Month",
                "Per Year",
                "2 Months"
              ].map((String interval) {
                return DropdownMenuItem<String>(
                  value: interval,
                  child: Text(interval),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedInterval = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            // Frequency Section
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
                    controller:
                        TextEditingController(text: frequency.toString()),
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
            // Reminder Section
            Text(
              "Reminder 1",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText:
                        "${selectedTime.hour.toString().padLeft(2, '0')} : ${selectedTime.minute.toString().padLeft(2, '0')}",
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
            // Next Button
            Center(
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MedicinePage3()), // Redirects to SignIn again
                      );
                    },
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MedicinePage2(),
  ));
}
