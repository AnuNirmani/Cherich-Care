
import 'package:cherich_care_2/pages/profile/settings/settings.dart';
import 'package:flutter/material.dart';

class Contry extends StatefulWidget {
  const Contry({super.key});

  @override
  State<Contry> createState() => _ContryState();
}

class _ContryState extends State<Contry> {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              _buildSettingOption(
                context,
                title: 'USA',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

              _buildSettingOption(
                context,
                title: 'Sri Lanka',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

              _buildSettingOption(
                context,
                title: 'UK',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

               _buildSettingOption(
                context,
                title: 'Japan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

               _buildSettingOption(
                context,
                title: 'China',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

               _buildSettingOption(
                context,
                title: 'Korea',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

               _buildSettingOption(
                context,
                title: 'Germany',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),

               _buildSettingOption(
                context,
                title: 'Spain',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
                value: '',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build individual options
  Widget _buildSettingOption(
      BuildContext context, {
        required String title,
        required String value,
        required VoidCallback onTap,
      }) {
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
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
