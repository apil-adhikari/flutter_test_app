import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/example_two_provider.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ExampleTwoProvider>(context, listen: true);
    print('build');
    return Scaffold(
      appBar: AppBar(title: Text('MultiProvider Example'), elevation: 1),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<ExampleTwoProvider>(
              builder: (context, value, child) => Slider(
                min: 0,
                max: 255,
                value: value.currentValue,
                onChanged: (val) {
                  value.setAlpha(val);
                },
              ),
            ),
            Consumer<ExampleTwoProvider>(
              builder: (context, value, child) => Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(
                          value.currentValue.toInt(),
                        ),
                      ),
                      child: Center(child: Text("Contaiiner 1")),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(value.currentValue.toInt()),
                      ),
                      child: Center(child: Text("Contaiiner 2")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
