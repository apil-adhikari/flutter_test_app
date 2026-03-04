import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/list_provider.dart';
import 'package:test_app/provider_state_management/second_screen.dart';

class CountExample extends StatefulWidget {
  const CountExample({super.key});

  @override
  State<CountExample> createState() => _CountExampleState();
}

class _CountExampleState extends State<CountExample> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumbersProvider>(
      builder: (context, numbersProviderModel, child) => Scaffold(
        appBar: AppBar(title: Text('Provider Example'), elevation: 1),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(numbersProviderModel.numbers.last.toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: numbersProviderModel.numbers.length,
                  itemBuilder: (context, index) {
                    int number = numbersProviderModel.numbers[index];
                    return Text(number.toString());
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
                    ),
                  );
                },
                label: Text("Second Page"),
                icon: Icon(Icons.next_plan_rounded),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            numbersProviderModel.add();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
