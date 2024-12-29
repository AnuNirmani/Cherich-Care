
import 'package:cherich_care_2/pages/profile/settings/settings.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';

class Contry extends StatefulWidget {
  const Contry({super.key});

  @override
  State<Contry> createState() => _ContryState();
}

class _ContryState extends State<Contry> {

  final FirebaseService _firebaseService = FirebaseService();
  String _selectedCountry = 'Sri Lanka';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentCountry();
  }

  Future<void> _loadCurrentCountry() async {
    setState(() => _isLoading = true);
    try {
      final country = await _firebaseService.getCountry();
      setState(() => _selectedCountry = country);
    } catch (e) {
      print('Error loading country: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectCountry(String country) async {
    setState(() => _isLoading = true);
    try {
      await _firebaseService.saveCountry(country);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Settings(selectedCountry: country),
          ),
        );
      }
    } catch (e) {
      print('Error saving country: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving country: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        title: const Text(
          'Country',
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
                    _buildCountryOption('USA'),
                    const SizedBox(height: 10),
                    _buildCountryOption('Sri Lanka'),
                    const SizedBox(height: 10),
                    _buildCountryOption('UK'),
                    const SizedBox(height: 10),
                    _buildCountryOption('Japan'),
                    const SizedBox(height: 10),
                    _buildCountryOption('China'),
                    const SizedBox(height: 10),
                    _buildCountryOption('Korea'),
                    const SizedBox(height: 10),
                    _buildCountryOption('Germany'),
                    const SizedBox(height: 10),
                    _buildCountryOption('Spain'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }

  // Helper to build individual options
  Widget _buildCountryOption(String country) {
    return GestureDetector(
      onTap: () => _selectCountry(country),
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
              country,
              style: const TextStyle(fontSize: 16),
            ),
            if (_selectedCountry == country)
              const Icon(Icons.check, color: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }
}
