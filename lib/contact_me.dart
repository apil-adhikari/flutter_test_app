import 'package:flutter/material.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({super.key});

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;
  final _contactMeFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Me"), elevation: 1),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade200,
        child: Form(
          key: _contactMeFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.person, size: 20),
                  prefixIconColor: Colors.blue,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                validator: (value) {
                  // If value is empty or null
                  if (value == null || value.isEmpty) {
                    return "Please fill your full name";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded, size: 20),
                  prefixIconColor: Colors.blue,
                  prefixStyle: TextStyle(fontSize: 14),

                  labelText: "Email",

                  labelStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                validator: (value) {
                  // If value is empty or null
                  if (value == null || value.isEmpty) {
                    return "Please enter your email address";
                  }

                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return "Please enter a valid email address";
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 14),
                minLines: 4,
                maxLines: 8,

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.message_rounded, size: 20),
                  prefixIconColor: Colors.blue,

                  hintText: "Enter your message",
                  labelText: "Message",

                  labelStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),

                validator: (value) {
                  // If value is empty or null
                  if (value == null || value.isEmpty) {
                    return "Please enter some message";
                  }

                  if (value.length < 30) {
                    return "Message must be atleast 30 characters";
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_contactMeFormKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                    }

                    try {
                      // Simulating 5 seconds delay
                      await Future.delayed(Duration(seconds: 1));

                      // Simulating 10% faliure rate
                      if (DateTime.now().millisecond % 10 == 0) {
                        throw Exception("Network Error");
                      }

                      final formData = {
                        "name": _fullNameController.text.trim(),
                        "email": _emailController.text.trim().toLowerCase(),
                        "message": _messageController.text.trim(),
                      };

                      if (formData['name'] == "null" ||
                          formData['name']!.isEmpty &&
                              formData['email'] == "null" ||
                          formData['email']!.isEmpty &&
                              formData['message'] == "null" ||
                          formData['message']!.isEmpty) {
                        return;
                      }
                      if (context.mounted) {
                        Navigator.pop(context, formData);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Error: $e",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                            showCloseIcon: true,
                          ),
                        );
                      }
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text("Send"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
