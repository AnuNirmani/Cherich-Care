import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cherich_care_2/pages/doctor_channel/channel_doctor.dart';

class SearchDoc extends StatelessWidget {
 final String selectedHospital;
 final String selectedDate;
 
 final List<Map<String, String>> doctors = [
   {"name": "Dr. Sagara Weeranayaka", "specialty": "Oncologist"},
   {"name": "Dr. Divya Pathirana", "specialty": "Cardiologist"},
   {"name": "Dr. Ahasna Athapaththu", "specialty": "Neurologist"},
   {"name": "Dr. Sahas Rajapaksha", "specialty": "Dermatologist"},
   {"name": "Dr. Menaka Jayasinghe", "specialty": "Pediatrician"},
 ];

 SearchDoc({
   super.key,
   required this.selectedHospital,
   required this.selectedDate,
 });

 Future<void> _launchPDF() async {
   final Uri url = Uri.parse('https://www.doc.lk/');
   if (!await launchUrl(url)) {
     throw Exception('Could not launch $url');
   }
 }

 Future<void> _launchILovePDF() async {
   final Uri url = Uri.parse('https://www.doc.lk/');
   if (!await launchUrl(url)) {
     throw Exception('Could not launch $url');
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
             MaterialPageRoute(builder: (context) => const ChannelDoctor()),
             (route) => false,
           );
         },
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
             Container(
               padding: const EdgeInsets.all(16),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.2),
                     blurRadius: 10,
                     offset: const Offset(0, 5),
                   ),
                 ],
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const ListTile(
                     contentPadding: EdgeInsets.zero,
                     leading: Icon(Icons.person, color: Colors.black),
                     title: Text(
                       "Dr. Saman Bandara",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                   const Divider(),
                   ListTile(
                     contentPadding: EdgeInsets.zero,
                     leading: const Icon(Icons.local_hospital, color: Colors.black),
                     title: Text(selectedHospital),
                   ),
                   const Divider(),
                   const ListTile(
                     contentPadding: EdgeInsets.zero,
                     leading: Icon(Icons.medical_services, color: Colors.black),
                     title: Text("Oncologist"),
                   ),
                   const Divider(),
                   ListTile(
                     contentPadding: EdgeInsets.zero,
                     leading: const Icon(Icons.calendar_today, color: Colors.black),
                     title: Text(selectedDate),
                   ),
                   const SizedBox(height: 10),
                   Center(
                     child: ElevatedButton(
                       onPressed: _launchILovePDF,
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
                       onPressed: _launchPDF,
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