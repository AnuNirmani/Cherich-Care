import 'package:cherich_care_2/pages/addmedicine/medicine_page.dart';
import 'package:flutter/material.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({Key? key}) : super(key: key);

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
          'Add Medicine',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Hold to delete record',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Add Medicine'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const _PillNameDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PillNameDialog extends StatelessWidget {
  const _PillNameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color.fromARGB(255, 156, 214, 255),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Pill Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Pill Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 248, 17, 0),
                  ),
                  child: const Text('Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MedicinePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 0, 255),
                  ),
                  child: const Text('OK',
                  style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
