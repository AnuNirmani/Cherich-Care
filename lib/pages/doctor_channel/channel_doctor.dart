import 'package:cherich_care_2/pages/doctor_channel/search_doc.dart';
import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/services/firebase_doc_channel.dart';
import 'package:flutter/material.dart';

class ChannelDoctor extends StatefulWidget {
  const ChannelDoctor({Key? key}) : super(key: key);

  @override
  _ChannelDoctorState createState() => _ChannelDoctorState();
}

class _ChannelDoctorState extends State<ChannelDoctor> {
  String? selectedHospital = 'Hemas Hospital - Wattala';
  String? selectedDate;

  final List<String> hospitals = [
    'Hemas Hospital - Wattala',
    'Asiri Hospital - Colombo',
    'Nawaloka Hospital - Negombo',
    'Nawaloka Hospital - Colombo'
  ];
  List<String> dates = [];
  bool isLoading = true;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _loadDates();
  }

  Future<void> _loadDates() async {
    setState(() => isLoading = true);
    try {
      final datesList = await _firebaseService.fetchAvailableDates();
      setState(() {
        dates = datesList;
        selectedDate = dates.isNotEmpty ? dates[0] : null;
      });
    } catch (e) {
      print('Error loading dates: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    },
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
                  const Text(
                    "Specialty*",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Oncologist',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "Hospital",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildDropdown(
                    value: selectedHospital,
                    items: hospitals,
                    onChanged: (value) => setState(() => selectedHospital = value),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildDropdown(
                          value: selectedDate,
                          items: dates,
                          onChanged: (value) => setState(() => selectedDate = value),
                          hint: 'Select Date',
                        ),

                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchDoc(
                              selectedHospital: selectedHospital ?? '',
                              selectedDate: selectedDate ?? '',
                            ),
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

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    String? hint,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: hint != null ? Text(hint) : null,
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}