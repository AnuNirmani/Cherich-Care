import 'package:cherich_care_2/pages/profile/settings/settings.dart';
import 'package:cherich_care_2/services/firebase_lan_con.dart';
import 'package:flutter/material.dart';

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  final FirebaseService _firebaseService = FirebaseService();
  String _selectedLanguage = 'English';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    setState(() => _isLoading = true);
    try {
      final language = await _firebaseService.getLanguage();
      setState(() => _selectedLanguage = language);
    } catch (e) {
      print('Error loading language: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectLanguage(String language) async {
    setState(() => _isLoading = true);
    try {
      await _firebaseService.saveLanguage(language);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(selectedLanguage: language),
        ),
      );
    } catch (e) {
      print('Error saving language: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving language: ${e.toString()}'),
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
        backgroundColor: Colors.pink[50],
        title: const Text(
          'Languages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        
      ),
      backgroundColor: Colors.pink[50],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLanguageOption('English'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Sinhala'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Tamil'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Japanese'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Chinese'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Korean'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('German'),
                    const SizedBox(height: 10),
                    _buildLanguageOption('Spanish'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }

  // Helper to build individual options
 Widget _buildLanguageOption(String language) {
    return GestureDetector(
      onTap: () => _selectLanguage(language),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: const TextStyle(fontSize: 16),
            ),
            if (_selectedLanguage == language)
              const Icon(Icons.check, color: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }
}
