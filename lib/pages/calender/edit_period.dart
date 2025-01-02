import 'package:cherich_care_2/pages/calender/calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPeriod extends StatefulWidget {
  @override
  _EditPeriodState createState() => _EditPeriodState();
}

class _EditPeriodState extends State<EditPeriod> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now(); // Initialize with the current date
  }

  void _navigateToPreviousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
    });
  }

  void _navigateToNextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
    });
  }

  List<int> _getDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    // Find the weekday of the first day of the month
    final firstWeekday = firstDayOfMonth.weekday;

    // Create a list of all the days for the calendar
    List<int> daysInMonth = [];
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      daysInMonth.add(i);
    }

    // Add empty days for the start of the month (if it doesn't start on Sunday)
    int leadingEmptyDays = firstWeekday - 1;
    List<int> calendarDays = List.filled(leadingEmptyDays, 0) + daysInMonth;

    return calendarDays;
  }

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateFormat('MMMM yyyy').format(_currentDate);
    final daysInMonth = _getDaysInMonth(_currentDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          currentMonth, // Dynamically display the current month
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              // Add calendar action
            },
          ),
        ],
      ),
      backgroundColor: Colors.pink.shade50, // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Month Navigation with Arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, color: Colors.black),
                  onPressed: _navigateToPreviousMonth,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right, color: Colors.black),
                  onPressed: _navigateToNextMonth,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Days of the week
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sun",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Mon",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Tue",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Wed",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Thu",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Fri",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                Text("Sat",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            // Calendar Grid for the current month
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 columns for each day of the week
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                  final day = daysInMonth[index];
                  final isToday = (_currentDate.day == day);

                  return GestureDetector(
                    onTap: () {
                      // Add day selection logic here
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isToday && day != 0
                            ? Colors.blue
                            : Colors.transparent, // Highlight today's date
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      alignment: Alignment.center,
                      child: day != 0
                          ? Text(
                              "$day",
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            // Save Button
            const SizedBox(height: 10.0),
            Center(
              child: SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calendar()),
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
}