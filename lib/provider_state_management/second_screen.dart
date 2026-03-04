import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider_state_management/list_provider.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Consumer<NumbersProvider>(
      builder: (context, numbersProviderModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Provider Example Second Page'),
          elevation: 1,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(numbersProviderModel.numbers.last.toString()),
              SizedBox(
                height: 200,
                width: double.maxFinite,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: numbersProviderModel.numbers.length,
                  itemBuilder: (context, index) {
                    int number = numbersProviderModel.numbers[index];
                    return Text(
                      number.toString(),
                      style: TextStyle(fontSize: 50),
                    );
                  },
                ),
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
