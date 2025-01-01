import 'package:cherich_care_2/pages/doctor_channel/book_doc.dart';
import 'package:cherich_care_2/pages/doctor_channel/doctor_details_page.dart';
import 'package:cherich_care_2/pages/home_page.dart';
import 'package:flutter/material.dart';



// Other Doctor Page for Doctor Information
class OtherDoctorPage extends StatelessWidget {
  // List of doctors with their specialties
  final List<Map<String, String>> doctors = [
    {"name": "Dr. Saman Bandara", "specialty": "Oncologist"},
    {"name": "Dr. Divya Pathirana", "specialty": "Cardiologist"},
    {"name": "Dr. Ahasna Athapaththu", "specialty": "Neurologist"},
    {"name": "Dr. Sahas Rajapaksha", "specialty": "Dermatologist"},
    {"name": "Dr. Menaka Jayasinghe", "specialty": "Pediatrician"},
  ];

   OtherDoctorPage({super.key});

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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selected Doctor Details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: const Text(
                        "Dr. Sagara Weeranayaka",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DoctorDetailsPage(
                                name: "Dr. Sagara Weeranayaka",
                                specialty: "Oncologist",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.local_hospital, color: Colors.black),
                      title: Text("Hemas Hospital - Wattala"),
                    ),
                    Divider(),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.medical_services, color: Colors.black),
                      title: Text("Oncologist"),
                    ),
                    Divider(),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.calendar_today, color: Colors.black),
                      title: Text("29/08/2024"),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 64,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Channel",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Other Doctors Section
              const Text(
                "   Other Doctors",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Column(
                children: doctors.map((doctor) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: Text(doctor["name"]!),
                      subtitle: Text(doctor["specialty"]!),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherDoctorPage(
                                //name: doctor["name"]!,
                                //specialty: doctor["specialty"]!,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}