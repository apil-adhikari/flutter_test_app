import 'package:flutter/material.dart';
import 'package:test_app/albums_screen.dart';
import 'package:test_app/data_fetching.dart';
import 'package:test_app/contact_me.dart';
import 'package:test_app/message_screen.dart';
import 'package:test_app/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Profile _profile;
  bool isFollowing = false;

  Future<void> _navigateAndDisplayMessage(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => MessageScreen(email: _profile.email),
      ),
    );

    // Check if the context is still valid (mounted) before usig it after an asyc gap
    if (!context.mounted) return;

    if (result == null || result.isEmpty) return;
    // Show an SnackBar
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("The new email is: $result"),
          backgroundColor: Colors.green,
          // action: SnackBarAction(label: "Ok", onPressed: () {}),
          duration: Duration(seconds: 2),
        ),
      );
  }

  // Contact me:
  Future<void> _navigateToContactMe(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactMe()),
    );

    // TEST
    debugPrint(result);
  }

  @override
  void initState() {
    super.initState();
    _profile = Profile(
      name: "Apil Adhikari",
      title: "💠Mobile App Developer",
      email: "hello@apil.com",
      phone: "9800000000",
      followersCount: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(_profile.name);
    return Scaffold(
      appBar: AppBar(title: Text("My Portfolio")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.blue.shade100),

        child: Column(
          children: [
            Text(
              _profile.followersCount.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
            CircleAvatar(backgroundColor: Colors.purple, radius: 50),
            SizedBox(height: 10),
            Text(
              _profile.name,
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
              child: Text(
                _profile.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  label: Text(
                    _profile.email,
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
                  label: Text(_profile.phone),
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
                    // if (isFollowing) {
                    //   setState(() {
                    //     isFollowing = !isFollowing;
                    //     _profile.followersCount--;
                    //   });
                    // } else {
                    //   setState(() {
                    //     isFollowing = !isFollowing;
                    //     _profile.followersCount++;
                    //   });
                    // }

                    setState(() {
                      isFollowing = !isFollowing;
                      _profile.followersCount += isFollowing ? 1 : -1;
                    });
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

                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => _navigateAndDisplayMessage(context),
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
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _navigateToContactMe(context);
              },
              label: Text("Contact Me"),
              icon: Icon(Icons.contact_mail_rounded),
              iconAlignment: IconAlignment.end,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),

            SizedBox(height: 10),

            // Conatct API Form
            ElevatedButton.icon(
              onPressed: () {
                // _navigateToContactApiForm(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataFetching()),
                );
              },
              label: Text("API Call Demo"),
              icon: Icon(Icons.api_rounded),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlbumsScreen()),
                );
              },
              label: Text("Albums"),
              icon: Icon(Icons.album),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_profile.followersCount > 0) {
            setState(() {
              isFollowing = false;
              _profile.followersCount = 0;
            });
          }
        },
        tooltip: "Reset data?",
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,

        mini: true,
        shape: CircleBorder(),
        child: Icon(Icons.restore_page_rounded),
      ),
    );
  }
}
