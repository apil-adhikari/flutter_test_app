import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/screens/shared_preferences/sp_login_screen.dart';
import 'package:test_app/utils/constants.dart';

class SpHomeScreen extends StatelessWidget {
  const SpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SP Home Screen'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (!context.mounted) return;
                bool success = await prefs.setBool(Constants.KEYLOGIN, false);
                if (!context.mounted) return;

                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SpLoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Failed to logout')));
                }
              } catch (e) {
                print('Error saving the prefrences: $e');
              }
            },
            icon: Icon(Icons.logout_rounded),
            // color: Colors.red,
            style: IconButton.styleFrom(
              hoverColor: Colors.red,
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(child: Text("Home Screen")),
      ),
    );
  }
}
