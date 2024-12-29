import 'package:cherich_care_2/pages/calender/note_list.dart';
import 'package:cherich_care_2/pages/notes.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  final String? initialDate;
  const NotesPage({Key? key, this.initialDate}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _noteController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadExistingNote();
  }

  Future<void> _loadExistingNote() async {
    if (widget.initialDate != null) {
      setState(() => _isLoading = true);
      try {
        String? existingNote = await _firebaseService.getNote(widget.initialDate!);
        if (existingNote != null) {
          _noteController.text = existingNote;
        }
      } catch (e) {
        _showError('Error loading note: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSaveNote() async {
  print("Starting save note process"); // Debug print
  
  if (_noteController.text.trim().isEmpty) {
    _showError('Please enter a note before saving');
    return;
  }

  setState(() => _isLoading = true);
  try {
    print("Note content: ${_noteController.text}"); // Debug print
    await _firebaseService.saveNote(_noteController.text);
    print("Note saved successfully"); // Debug print
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note saved successfully!')),
      );
      // Navigate to NoteList instead of Notes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoteList()),  // or NotesW if you prefer that implementation
      );
    }
  } catch (e) {
    print('Error saving note: $e'); // Debug print
    _showError('Error saving note: $e');
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

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
      body:  _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  'Add Note in here',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.black, size: 26),
                  onPressed: () {
                    print("Save button pressed"); // Debug print
                    _handleSaveNote();
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
                child: TextField(
                  controller: _noteController,
                  maxLines: null, // Allows multiline input
                  expands: true, // Expands the TextField to fill its parent
                  decoration: const InputDecoration(
                    hintText: 'Type your note here...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 18),
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
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}
