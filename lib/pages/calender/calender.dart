import 'package:cherich_care_2/pages/notes.dart';
import 'package:cherich_care_2/pages/calender/notes_page.dart';
import 'package:cherich_care_2/pages/calender/quiz.dart';
import 'package:cherich_care_2/pages/review_symptoms.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class PeriodPage extends StatelessWidget {
  const PeriodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Period Ends",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotesPage()),
                          );
                        },
                        child: const Text(
                          "• Add Note",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quiz()),
                          );
                        },
                        child: const Text(
                          "• Help",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Remove Period",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPeriod()),
                          );
                        },
                        child: const Text(
                          "• Edit Period",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Map<String, dynamic>? _symptomsData;
  Map<String, String?>? _symptomValues;

  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _fetchSymptoms() async {
    final symptoms = await _firebaseService.fetchSymptoms();
    setState(() {
      _symptomsData = symptoms;
      _parseSymptomValues();
    });
  }

  void _parseSymptomValues() {
    if (_symptomsData != null) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(_symptomsData!['data']);
      _symptomValues = {};
      data.forEach((key, value) {
        _symptomValues![key] = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Cherry Analysis Report",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.pink.shade50, // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Date :- 16/12/2024",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Symptoms Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Identified symptoms by you, when doing the self exam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  if (_symptomValues != null)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _symptomValues!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_symptomValues!.keys.elementAt(index),
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  _symptomValues![_symptomValues!.keys
                                          .elementAt(index)] ??
                                      'Not specified',
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Risk Level
            /*const Text(
              "Risk Level :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You are identified as in a low risk.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),*/
            // Recommendation
            const Text(
              "We are recommending always talk to your doctor when making health decisions.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

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

class AnyDatePage extends StatelessWidget {
  const AnyDatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Period Startes",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotesPage()),
                          );
                        },
                        child: const Text(
                          "• Add Note",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPeriod()),
                          );
                        },
                        child: const Text(
                          "• Edit Period",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelfExamPage extends StatelessWidget {
  const SelfExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Remove Self Exam",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quiz()),
                          );
                        },
                        child: const Text(
                          "• Help",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewSymptoms()),
                          );
                        },
                        child: const Text(
                          "• Edit Self Exam",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Report()),
                          );
                        },
                        child: const Text(
                          "• View Self Exam Report",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Example: Add custom markers for specific dates
  final Map<DateTime, String> _dateImages = {
    DateTime(2024, 12, 9): 'assets/images/period.png',
    DateTime(2024, 12, 10): 'assets/images/period.png',
    DateTime(2024, 12, 11): 'assets/images/period.png',
    DateTime(2024, 12, 12): 'assets/images/period.png',
    DateTime(2024, 12, 13): 'assets/images/period.png',
    DateTime(2024, 12, 14): 'assets/images/period.png',
    DateTime(2024, 12, 08): 'assets/images/period.png',
    DateTime(2024, 12, 15): 'assets/images/selfexam3.png',
    DateTime(2024, 12, 21): 'assets/images/fertile.png',
    DateTime(2024, 12, 22): 'assets/images/fertile.png',
    DateTime(2024, 12, 23): 'assets/images/fertile.png',
    DateTime(2024, 12, 24): 'assets/images/fertile.png',
    DateTime(2024, 12, 25): 'assets/images/ovulation.png',
    DateTime(2024, 12, 26): 'assets/images/fertile.png',
    DateTime(2024, 12, 27): 'assets/images/fertile.png',
  };

  void _navigateToPage(String imagePath) {
    Widget destination;

    if (imagePath.contains('period')) {
      destination = const PeriodPage();
    } else if (imagePath.contains('selfexam3')) {
      destination = SelfExamPage();
    } else if (imagePath.contains('fertile')) {
      destination = const FertilePage();
    } else if (imagePath.contains('ovulation')) {
      destination = const OvulationPage();
    } else {
      return; // Do nothing for unmatched cases
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Table Calendar widget
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnyDatePage()),
                );
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: const TextStyle(color: Colors.black),
                weekendTextStyle: const TextStyle(color: Colors.red),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  // Ensure the date matches by ignoring time
                  final isImageDate = _dateImages.keys.any(
                    (date) =>
                        date.year == day.year &&
                        date.month == day.month &&
                        date.day == day.day,
                  );
                  if (isImageDate) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              _navigateToPage(
                                _dateImages[
                                    DateTime(day.year, day.month, day.day)]!,
                              );
                            },
                            child: Image.asset(
                              _dateImages[
                                  DateTime(day.year, day.month, day.day)]!,
                              height: 20.0,
                              width: 20.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),

            // Divider above the date row
            const Divider(
              color: Color.fromARGB(255, 255, 255, 255),
              thickness: 2.0,
            ),

            // Selected date display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDay.day}, ${_selectedDay.month}, ${_selectedDay.year}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Quiz()),
                      );
                    },
                    child: Image.asset(
                      'assets/images/q.png', // Replace with your asset path
                      height: 24.0,
                      width: 24.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            // Divider below the date row
            const Divider(
              color: Color.fromARGB(255, 255, 255, 255),
              thickness: 2.0,
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes()),
                );
              },
              child: Image.asset(
                'assets/images/note.png', // Replace with your asset path
                height: 24.0,
                width: 24.0,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 8.0),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes()),
                );
              },
              child: const Text(
                "Add Note",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
