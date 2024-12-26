import 'package:cherich_care_2/pages/addmedicine/medicine_page2.dart';
import 'package:flutter/material.dart';

class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  bool isNotificationEnabled = false;
  bool isForever = false;
  int durationDays = 14;
  DateTime startDate = DateTime.now();
  String selectedInterval = "Everyday";

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

  @override
  Widget build(BuildContext context) {
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
            // Notification Row
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification",
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
            // Text Input Field
            const TextField(
              decoration: InputDecoration(
                labelText: "Tap to edit",
                hintText: "Vienva",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            const SizedBox(height: 20),
            // Duration Section
            const Text(
              "Duration",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // Forever Checkbox
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
                      // Increment/Decrement Buttons
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
            // Start Date Section
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
            //const Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),

            // Interval Section
            // const Text(
            //   "Interval",
            //   style: TextStyle(fontSize: 18),
            // ),
            // SizedBox(height: 10),
            // DropdownButtonFormField<String>(
            //   value: selectedInterval,
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //   ),
            //   items: [
            //     "Everyday",
            //     "Per Month",
            //     "Per Year",
            //     "2 Months"
            //   ].map((String interval) {
            //     return DropdownMenuItem<String>(
            //       value: interval,
            //       child: Text(interval),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedInterval = value!;
            //     });
            //   },
            // ),

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
                        MaterialPageRoute(builder: (context) => MedicinePage2()), // Redirects to SignIn again
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

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MedicinePage(),
  ));
}
