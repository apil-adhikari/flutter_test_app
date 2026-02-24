import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int followersCount = 0;
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Portfolio")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade100),

        child: Column(
          children: [
            Text(
              "$followersCount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
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
                ElevatedButton.icon(
                  onPressed: () {
                    if (isFollowing) {
                      setState(() {
                        isFollowing = !isFollowing;
                        followersCount--;
                      });
                    } else {
                      setState(() {
                        isFollowing = !isFollowing;
                        followersCount++;
                      });
                    }
                  },
                  icon: isFollowing ? Icon(Icons.check) : Icon(Icons.add),
                  label: isFollowing ? Text("Following") : Text("Follow"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFollowing
                        ? Colors.grey.shade100
                        : Colors.blue.shade500,
                    foregroundColor: isFollowing ? Colors.blue : Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.message),
                  label: Text("Message"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.w700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
