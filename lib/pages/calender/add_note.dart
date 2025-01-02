import 'package:cherich_care_2/pages/calender/note_list.dart';
import 'package:cherich_care_2/services/firebase_addnore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddNote extends StatefulWidget {
  final String? initialDate;
  
  const AddNote({
    Key? key, 
    this.initialDate,
  }) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _noteController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  late String _selectedDate;

  @override
  void initState() {
    super.initState();
    // Safely handle the date initialization
    _initializeDate();
    _loadExistingNote();
  }

  void _initializeDate() {
    try {
      if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
        // Try to parse the provided date to validate it
        DateTime.parse(widget.initialDate!);
        _selectedDate = widget.initialDate!;
      } else {
        // If no valid date provided, use current date
        _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    } catch (e) {
      // If there's any error parsing the date, use current date
      print('Error parsing date: $e');
      _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  Future<void> _loadExistingNote() async {
    setState(() => _isLoading = true);
    try {
      String? existingNote = await _firebaseService.getNote(_selectedDate);
      if (existingNote != null) {
        _noteController.text = existingNote;
      }
    } catch (e) {
      _showError('Error loading note: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSaveNote() async {
    if (_noteController.text.trim().isEmpty) {
      _showError('Please enter a note before saving');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _firebaseService.saveNote(_noteController.text, _selectedDate);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note saved successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NoteList()),
        );
      }
    } catch (e) {
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

  String _formatDisplayDate() {
    try {
      final date = DateTime.parse(_selectedDate);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      print('Error formatting display date: $e');
      return 'Invalid Date';
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
        title: Text(
          'Add Note for ${_formatDisplayDate()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.pink[50],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.check,
                          color: Color.fromARGB(255, 252, 228, 236), size: 26),
                      const Text(
                        'Add Note in here',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.black, size: 26),
                        onPressed: _handleSaveNote,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFDD),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _noteController,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                          hintText: 'Type your note here...',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.pink[50],
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