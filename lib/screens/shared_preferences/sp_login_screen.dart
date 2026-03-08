import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/provider_state_management/sp_login_screen_provider.dart';
import 'package:test_app/screens/shared_preferences/sp_home_screen.dart';
import 'package:test_app/utils/constants.dart';

class SpLoginScreen extends StatefulWidget {
  const SpLoginScreen({super.key});
  @override
  State<SpLoginScreen> createState() => _SpLoginScreenState();
}

class _SpLoginScreenState extends State<SpLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Prefrences login screen"),
        elevation: 1,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Theme.of(context).primaryColor,
                  hint: Text("Enter your email address"),
                  label: Text("Email"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Consumer<SpLoginScreenProvider>(
                builder: (context, value, child) => TextField(
                  controller: _passwordController,
                  obscureText: !value.showPassword,

                  decoration: InputDecoration(
                    hint: Text("Enter your password"),
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Theme.of(context).primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        value.toggleShowPassword();
                      },
                      icon: Icon(
                        value.showPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    suffixIconColor: Theme.of(context).primaryColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 6,
                      spreadRadius: -1,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      blurRadius: 4,
                      spreadRadius: -1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      bool success = await prefs.setBool(
                        Constants.KEYLOGIN,
                        true,
                      );

                      if (!context.mounted) return;
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpHomeScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to save login state')),
                        );
                      }
                    } catch (e) {
                      print(("Error saving the prefrences: $e"));
                    }

                    // Successful -> set the isLoggedIn to true
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool(Constants.KEYLOGIN, true); //

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SpHomeScreen()),
                    );
                  },

                  label: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
