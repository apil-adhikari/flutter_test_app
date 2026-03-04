import 'dart:async';

import 'package:flutter/material.dart';

class WhyProvider extends StatefulWidget {
  const WhyProvider({super.key});

  @override
  State<WhyProvider> createState() => _WhyProviderState();
}

class _WhyProviderState extends State<WhyProvider> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build $count');
    return Scaffold(
      appBar: AppBar(title: Text("Why Provider"), elevation: 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "${DateTime.now().hour}:${DateTime.now().minute}: ${DateTime.now().second}",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              count.toString(),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
