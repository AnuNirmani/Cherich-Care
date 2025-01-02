import 'package:cherich_care_2/pages/calender/notes_page.dart';
import 'package:cherich_care_2/pages/notes.dart';
import 'package:flutter/material.dart';
import 'package:cherich_care_2/services/firebase_note.dart';
import 'package:intl/intl.dart';


class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NotesState();
}

class _NotesState extends State<NoteList> {
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  Map<String, String> _notes = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    print("Starting to load notes"); // Debug print
    setState(() => _isLoading = true);
    try {
      final notes = await _firebaseService.getAllNotes();
      print("Loaded notes: $notes"); // Debug print
      setState(() => _notes = notes);
    } catch (e) {
      print('Error loading notes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading notes: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'My Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Notes()),
        (route) => false,
      );
    },
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        children: [
          Expanded(
            child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadNotes,
              child: _notes.isEmpty
                  ? ListView(
                      children: const [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'No notes yet. Click + to add a note!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        final date = _notes.keys.elementAt(index);
                        final note = _notes[date] ?? '';
                        final formattedDate = DateFormat('MMMM dd, yyyy')
                            .format(DateFormat('yyyy-MM-dd').parse(date));

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              formattedDate,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.pinkAccent,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                note,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesPage(initialDate: date),
                                ),
                              );
                              _loadNotes(); // Reload notes when returning
                            },
                          ),
                        );
                      },
                    ),
            ),
            ),
          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 120,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Notes(), // Replace with your new page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'OK',  // Replace with your button text
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
      
    
      
    );
  }
}