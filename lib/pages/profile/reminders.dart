import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  // Map to manage toggle states
  final Map<String, bool> _reminders = {
    'Self Check': true,
    'Period Cycle': true,
    'Mammogram': false,
    'Doctor Visit': false,
    'Breast MRI': false,
  };

  // Map to display days information
  final Map<String, String> _daysInfo = {
    'Self Check': '26 days',
    'Period Cycle': '30 days',
    'Mammogram': '',
    'Doctor Visit': '',
    'Breast MRI': '',
  };

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
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
              });
            },
          ),
        ],
      ),
    );
  }
}
