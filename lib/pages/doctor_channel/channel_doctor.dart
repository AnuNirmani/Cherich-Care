import 'package:cherich_care_2/pages/doctor_channel/search_doc.dart';
import 'package:flutter/material.dart';

class ChannelDoctor extends StatefulWidget {
  const ChannelDoctor({Key? key}) : super(key: key);

  @override
  _ChannelDoctorState createState() => _ChannelDoctorState();
}

class _ChannelDoctorState extends State<ChannelDoctor> {
  String? selectedSpecialty = 'Oncologist';
  String? selectedHospital = 'Hemas Hospital - Wattala';
  String? selectedDate = '17-12-2014';

  final List<String> specialties = ['Oncologist'];
  final List<String> hospitals = ['Hemas Hospital - Wattala', 'Asiri Hospital - Colombo', 'Nawaloka Hospital - Negombo', 'Nawaloka Hospital - Colombo'];
  final List<String> dates = ['15-12-2014', '17-12-2014', '20-12-2014'];

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
          "Channel a Doctor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.pink.shade50,
      body: Column(
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.pink[50],
            child: const Center(
              child: Text(
                "\n\nMeet your Doctor...\n",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Specialty Dropdown
                  const Text(
                    "Specialty*",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedSpecialty,
                    items: specialties
                        .map((specialty) => DropdownMenuItem<String>(
                              value: specialty,
                              child: Text(specialty),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSpecialty = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Hospital Dropdown
                  const Text(
                    "Hospital",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedHospital,
                    items: hospitals
                        .map((hospital) => DropdownMenuItem<String>(
                              value: hospital,
                              child: Text(hospital),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedHospital = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Date Dropdown
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedDate,
                    items: dates
                        .map((date) => DropdownMenuItem<String>(
                              value: date,
                              child: Text(date),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDate = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Spacer ensures alignment
                  const Spacer(),
                  // Search Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  SearchDoc(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
