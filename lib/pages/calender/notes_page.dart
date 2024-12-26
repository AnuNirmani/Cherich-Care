import 'package:cherich_care_2/pages/notes.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

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
          'Add Note',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          // Add Note Row at the top
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.check,
                    color: Color.fromARGB(255, 252, 228, 236), size: 26),
                const Text(
                  'Add Note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.black, size: 26),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notes()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Typable Yellow Background with Curved Edges
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFDD), // Light yellow
                  borderRadius: BorderRadius.circular(16.0), // Curved edges
                ),
                padding: const EdgeInsets.all(16.0),
                child: const TextField(
                  maxLines: null, // Allows multiline input
                  expands: true, // Expands the TextField to fill its parent
                  decoration: InputDecoration(
                    hintText: 'Type your note here...',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          // Pink background below the yellow box
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.pink[50], // Light pink background
            ),
          ),
        ],
      ),
    );
  }
}
