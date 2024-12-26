import 'package:cherich_care_2/pages/home_page.dart';
import 'package:flutter/material.dart';


class BookDoc extends StatelessWidget {
  const BookDoc({super.key});

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
          "Doctor Details",
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
            children: [
              // Doctor Info Card
              Container(
                padding: EdgeInsets.all(16),
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
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 80,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Dr. Saman Bandara",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "Special Notes: \nAvailable for channeling at Hemas Hospital - Wattala, Nawaloka Hospital Colombo, and Negombo. Please contact 0112222220 or 0115555220.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Hemas Hospital - Wattala Sessions"),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Oncologist - 12 Sessions"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Available Sessions
              const Column(
                children: [
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:00 AM",
                    sessionNumber: "No 1",
                    isBooked: true,
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:15 AM",
                    sessionNumber: "No 2",
                    isBooked: true,
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:30 AM",
                    sessionNumber: "No 3",
                    isBooked: false,
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:45 AM",
                    sessionNumber: "No 4",
                    isBooked: false,
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 08:00 AM",
                    sessionNumber: "No 5",
                    isBooked: false,
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 08:15 AM",
                    sessionNumber: "No 6",
                    isBooked: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class ChannelPage extends StatelessWidget {
  final String doctorName;

  const ChannelPage({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Channel Doctor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),*/
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have booked successfully $doctorName.",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Spacing between the message and the button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Go to Home Page",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class SessionCard extends StatelessWidget {
  final String date;
  final String time;
  final String sessionNumber;
  final bool isBooked;

  const SessionCard({super.key, 
    required this.date,
    required this.time,
    required this.sessionNumber,
    required this.isBooked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: isBooked ? Colors.redAccent.shade100 : Colors.white,
      child: ListTile(
        title: Text(
          "$date - $time",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBooked ? Colors.black54 : Colors.black,
          ),
        ),
        subtitle: Text("Session: $sessionNumber"),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isBooked ? Colors.grey : Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: isBooked
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChannelPage(doctorName: "Dr. Saman Bandara"),
                    ),
                  );
                },
          child: Text(
            isBooked ? "Booked" : "Book",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}










class SearchDoc extends StatelessWidget {
  // List of doctors with their specialties
  final List<Map<String, String>> doctors = [
    {"name": "Dr. Sagara Weeranayaka", "specialty": "Oncologist"},
    {"name": "Dr. Divya Pathirana", "specialty": "Cardiologist"},
    {"name": "Dr. Ahasna Athapaththu", "specialty": "Neurologist"},
    {"name": "Dr. Sahas Rajapaksha", "specialty": "Dermatologist"},
    {"name": "Dr. Menaka Jayasinghe", "specialty": "Pediatrician"},
  ];

   SearchDoc({super.key});

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
                        "Dr. Saman Bandara",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.info_outline, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailsPage(
                                name: "Dr. Saman Bandara",
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
                      title: Text("17/12/2024"),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookDoc(),
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
              SizedBox(height: 20),
              // Other Doctors Section
              const Text(
                "   Other Doctors",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
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





// Details Page for Doctor Information
class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String specialty;

  const DoctorDetailsPage({super.key, required this.name, required this.specialty});

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
          "Doctor Details",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Specialty: $specialty",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              "\nAdditional information about the doctor can be added here.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}





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
                              builder: (context) => BookDoc(),
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