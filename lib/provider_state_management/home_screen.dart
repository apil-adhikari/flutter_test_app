import 'package:flutter/material.dart';
import 'package:test_app/provider_state_management/stateful_widget_screen.dart';
import 'package:test_app/provider_state_management/why_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // The variables inside StatelessWidget must be final because it can't change afterwards.
  final int x = 100;
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("State management using Provider"),
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatefulWidgetScreen()),
            ),
            label: Text("Take to Stateful Widget Screen"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WhyProvider()),
              );
            },
            child: Text("Why Provider ?"),
          ),
          SizedBox(
            child: Center(
              child: Text(x.toString(), style: TextStyle(fontSize: 32)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // x++;
          print(x);
        },
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
