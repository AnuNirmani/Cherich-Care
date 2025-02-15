import 'package:cherich_care_2/pages/calender/any_date_page.dart';
import 'package:cherich_care_2/pages/calender/period_page.dart';
import 'package:cherich_care_2/pages/calender/self_exam_page.dart';
import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/notes.dart';
import 'package:cherich_care_2/pages/calender/quiz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';




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

    DateTime(2025, 01, 6): 'assets/images/period.png',
    DateTime(2025, 01, 7): 'assets/images/period.png',
    DateTime(2025, 01, 1): 'assets/images/period.png',
    DateTime(2025, 01, 2): 'assets/images/period.png',
    DateTime(2025, 01, 3): 'assets/images/period.png',
    DateTime(2025, 01, 4): 'assets/images/period.png',
    DateTime(2025, 01, 5): 'assets/images/period.png',
    DateTime(2025, 01, 13): 'assets/images/selfexam3.png',
    DateTime(2025, 01, 28): 'assets/images/fertile.png',
    DateTime(2025, 01, 22): 'assets/images/fertile.png',
    DateTime(2025, 01, 23): 'assets/images/fertile.png',
    DateTime(2025, 01, 24): 'assets/images/fertile.png',
    DateTime(2025, 01, 25): 'assets/images/ovulation.png',
    DateTime(2025, 01, 26): 'assets/images/fertile.png',
    DateTime(2025, 01, 27): 'assets/images/fertile.png',

    DateTime(2025, 02, 10): 'assets/images/selfexam3.png',
    DateTime(2025, 02, 9): 'assets/images/selfexam3.png',
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
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
              onDaySelected: (selectedDay, focusedDay) 
              {
  setState(() {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
  });
  
  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AnyDatePage(selectedDate: formattedDate),
    ),
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
                    '${_selectedDay.day}/ ${_selectedDay.month}/ ${_selectedDay.year}',
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
                "Notes",
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
