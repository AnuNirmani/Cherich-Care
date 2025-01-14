import 'package:cherich_care_2/pages/profile/settings/contry.dart';
import 'package:cherich_care_2/pages/profile/settings/languages.dart';
import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:cherich_care_2/pages/profile/settings/theam_color.dart';
import 'package:cherich_care_2/services/firebase.dart';  // Updated import
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final String? selectedLanguage;
  final String? selectedCountry;

  const Settings({
    super.key,
    this.selectedLanguage,
    this.selectedCountry,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isDoubleMastectomyEnabled = false;
  bool isPeriodTrackerEnabled = false;
  Color _saveButtonColor = Colors.pinkAccent;
  String _currentLanguage = 'English';
  String _currentCountry = 'Sri Lanka';
  bool _isLoading = false;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // In _SettingsState class
Future<void> _loadSettings() async {
  setState(() => _isLoading = true);
  try {
    final doubleMastectomy = await _firebaseService.getDoubleMastectomySetting();
    final periodTracker = await _firebaseService.getPeriodTrackerSetting();
    final savedCountry = await _firebaseService.getUserSettingsCountry();
    
    setState(() {
      _currentLanguage = widget.selectedLanguage ?? 'English';
      _currentCountry = widget.selectedCountry ?? savedCountry;
      isDoubleMastectomyEnabled = doubleMastectomy;
      isPeriodTrackerEnabled = periodTracker;
    });
  } catch (e) {
    print('Error loading settings: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error loading settings')),
    );
  } finally {
    setState(() => _isLoading = false);
  }
}

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);
    try {
      await _firebaseService.saveDoubleMastectomySetting(isDoubleMastectomyEnabled);
      await _firebaseService.savePeriodTrackerSetting(isPeriodTrackerEnabled);
      setState(() => _hasUnsavedChanges = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving settings: $e')),
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
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
        (route) => false,
      );
    },
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildSettingOption(
                    context,
                    title: 'Language',
                    value: _currentLanguage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Languages()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSettingOption(
                    context,
                    title: 'Country',
                    value: _currentCountry,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Contry()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildSettingOption(
                    context,
                    title: 'Change theme color',
                    value: '',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TheamColor()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Toggle for Double Mastectomy
                  _buildToggleOption(
                    context,
                    title: 'Double Mastectomy',
                    value: isDoubleMastectomyEnabled,
                    onChanged: (newValue) {
                      setState(() {
                        isDoubleMastectomyEnabled = newValue;
                        _hasUnsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Toggle for Period Tracker
                  _buildToggleOption(
                    context,
                    title: 'Period Tracker',
                    value: isPeriodTrackerEnabled,
                    onChanged: (newValue) {
                      setState(() {
                        isPeriodTrackerEnabled = newValue;
                        _hasUnsavedChanges = true;
                      });
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _hasUnsavedChanges ? _saveSettings : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _saveButtonColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSettingOption(BuildContext context,
      {required String title, required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
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
              title,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(BuildContext context,
      {required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Container(
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
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Switch(
            value: value,
            activeColor: Colors.pinkAccent,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}