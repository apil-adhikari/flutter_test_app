import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesExample extends StatefulWidget {
  const SharedPreferencesExample({super.key});

  @override
  State<SharedPreferencesExample> createState() =>
      _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  final TextEditingController _nameController = TextEditingController();

  static const String KEYNAME = "name";
  String nameValue = "No saved value";
  @override
  initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Preferences')),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                label: Text("Name"),
                hint: Text('Enter your name'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5, color: Colors.blue),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text.toString();

                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.setString(KEYNAME, name);
              },
              child: Text('Save'),
            ),
            SizedBox(height: 10),
            Text(nameValue),
          ],
        ),
      ),
    );
  }

  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getName = prefs.getString(KEYNAME);
    setState(() {
      nameValue = getName ?? "No saved value";
    });
  }
}
