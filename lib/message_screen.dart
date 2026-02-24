import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final String email;
  const MessageScreen({super.key, required this.email});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isSending = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Screen")),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              cursorOpacityAnimates: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),

                prefixIconColor: Colors.blueAccent,

                labelText: "Enter here",
                labelStyle: TextStyle(fontSize: 14, color: Colors.blueAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade200),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email address";
                      }

                      return null;
                    },
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isSending = true;
                        });

                        try {
                          await Future.delayed(Duration(seconds: 5));

                          final message = _emailController.text.trim();

                          if (!context.mounted) return;
                          Navigator.pop(context, message);
                        } catch (e) {
                          if (!context.mounted) return;
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          setState(() {
                            _isSending = false;
                          });
                        }

                        // ScaffoldMessenger.of(context)
                        //   ..removeCurrentSnackBar()
                        //   ..showSnackBar(
                        //     SnackBar(
                        //       content: Text(_emailController.text),
                        //       // action: SnackBarAction(
                        //       //   label: "Go to Cart",
                        //       //   onPressed: () {},
                        //       //   backgroundColor: Colors.yellow,
                        //       //   textColor: Colors.black,
                        //       // ),
                        //       showCloseIcon: true,
                        //       backgroundColor: Colors.pink.shade300,
                        //       duration: Duration(seconds: 2),
                        //     ),
                        //   );
                      }
                    },
                    child: _isSending
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text("Submit"),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Send email to ${widget.email}"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _emailController.text);
              },
              child: const Text("Go to Profile Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
