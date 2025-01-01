import 'package:cherich_care_2/pages/addmedicine/add_medicine.dart';
import 'package:cherich_care_2/pages/calender/note_list.dart';
import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/calender/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd  MMMM yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Add Note",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          ),
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListItem(
                  context,
                  iconPath: "assets/images/pin.png",
                  title: "Period Started",
                  trailingWidget: const Icon(Icons.check_box_outline_blank, color: Colors.pinkAccent),
                ),
                _buildListItem(
                  context,
                  iconPath: "assets/images/flow.png",
                  title: "Flow",
                  trailingWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(4, (index) {
                      return const Icon(Icons.water_drop, color: Colors.pinkAccent);
                    }),
                  ),
                ),
                _buildListItem(
                  context,
                  iconPath: "assets/images/pin.png",
                  title: "Period Ended",
                  trailingWidget: const Icon(Icons.check_box_outline_blank, color: Colors.pinkAccent),
                ),
                _buildListItem(
                  context,
                  iconPath: "assets/images/note.png",
                  title: "Add Notes",
                  trailingWidget: const Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                  onTap: () {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotesPage(initialDate: formattedDate),
                      ),
                    );
                  },
                ),
                _buildListItem(
                  context,
                  iconPath: "assets/images/note3.png",
                  title: "View Notes",
                  trailingWidget: const Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NoteList()),
                    );
                  },
                ),
                _buildListItem(
                  context,
                  iconPath: "assets/images/medecide.png",
                  title: "Medicine",
                  trailingWidget: const Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AddMedicine()),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: SizedBox(
                    width: 130,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
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
        ],
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required String iconPath,
    required String title,
    required Widget trailingWidget,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 251, 251, 251),
          radius: 30,
          child: Image.asset(
            iconPath,
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: trailingWidget,
        onTap: onTap,
      ),
    );
  }
}