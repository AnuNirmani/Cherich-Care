import 'package:cherich_care_2/pages/doctor_channel/channel_doctor.dart';
import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:cherich_care_2/services/screen_plan_f.dart';
import 'package:flutter/material.dart';

class ScreenPlanP extends StatefulWidget {
  const ScreenPlanP({super.key});

  @override
  State<ScreenPlanP> createState() => _ScreenPlanPState();
}

class _ScreenPlanPState extends State<ScreenPlanP> {
  final TextEditingController _doctorVisitController = TextEditingController();
  final TextEditingController _mamogramController = TextEditingController();
  final TextEditingController _breastMRIController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;
  
  // Store initial values to check for changes
  String? _initialDoctorVisit;
  String? _initialMammogram;
  String? _initialBreastMRI;

  @override
  void initState() {
    super.initState();
    _loadExistingPlan();
    
    // Add listeners to detect changes
    _doctorVisitController.addListener(_onFieldChanged);
    _mamogramController.addListener(_onFieldChanged);
    _breastMRIController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    final hasChanges = 
      _doctorVisitController.text != (_initialDoctorVisit ?? 'not set') ||
      _mamogramController.text != (_initialMammogram ?? 'not set') ||
      _breastMRIController.text != (_initialBreastMRI ?? 'not set');
    
    setState(() {
      _hasUnsavedChanges = hasChanges;
    });
  }

  @override
  void dispose() {
    _doctorVisitController.dispose();
    _mamogramController.dispose();
    _breastMRIController.dispose();
    super.dispose();
  }

  Future<void> _loadExistingPlan() async {
    try {
      final plan = await _firebaseService.getScreeningPlan();
      if (plan != null && mounted) {
        setState(() {
          _initialDoctorVisit = plan['doctorVisit'] ?? 'not set';
          _initialMammogram = plan['mammogram'] ?? 'not set';
          _initialBreastMRI = plan['breastMRI'] ?? 'not set';
          
          _doctorVisitController.text = _initialDoctorVisit!;
          _mamogramController.text = _initialMammogram!;
          _breastMRIController.text = _initialBreastMRI!;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading plan: $e')),
        );
      }
    }
  }

  Future<void> _handleSave() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseService.saveScreeningPlan(
        doctorVisit: _doctorVisitController.text,
        mammogram: _mamogramController.text,
        breastMRI: _breastMRIController.text,
      );

      setState(() {
        _hasUnsavedChanges = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Screening plan saved successfully!')),
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving plan: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasUnsavedChanges) {
      return true;
    }

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text('Do you want to save your changes before leaving?'),
        actions: [
          TextButton(
            child: const Text('Discard'),
            onPressed: () {
              Navigator.of(context).pop(true); // Discard changes and go back
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              await _handleSave();
              if (mounted) {
                Navigator.of(context).pop(true); // Save and go back
              }
            },
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text(
            'Screening Plan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (_hasUnsavedChanges) {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Unsaved Changes'),
                    content: const Text('Do you want to save your changes before leaving?'),
                    actions: [
                      TextButton(
                        child: const Text('Discard'),
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () async {
                          await _handleSave();
                          if (mounted) {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Go back
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        backgroundColor: Colors.pink[50],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\nDoctor Visit',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 8),
              _buildTextField(_doctorVisitController),
              const SizedBox(height: 20),

              const Text(
                'Mammogram',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 8),
              _buildTextField(_mamogramController),
              const SizedBox(height: 20),

              const Text(
                'Breast MRI',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 8),
              _buildTextField(_breastMRIController),
              const SizedBox(height: 36),

              Center(
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading || !_hasUnsavedChanges ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: _hasUnsavedChanges ? Colors.white : Colors.white70,
                          ),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChannelDoctor()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(150, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Channel a Doctor',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'not set',
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: IconButton(
          icon: Image.asset(
            'assets/images/note2.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            // Handle the icon press
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}