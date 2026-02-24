import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Learning Flutter",
      home: Scaffold(
        appBar: AppBar(title: Text("My Portfolio")),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue.shade100),
          child: Column(
            children: [
              CircleAvatar(backgroundColor: Colors.purple, radius: 50),
              SizedBox(height: 10),
              const Text(
                "Apil Adhikari",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Text(
                  "💠 Mobile App Developer",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: const Text(
                      "hello@apil.com",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    icon: Icon(Icons.mail),
                    style: ButtonStyle(),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: const Text("9800000000"),
                    icon: Icon(Icons.phone),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},

                    style: ButtonStyle(),
                    child: const Text("Follow"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Message"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
