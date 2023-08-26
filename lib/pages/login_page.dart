import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharebao/const.dart';

// User can signin using their email and password

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Login failed error message
  String errMsg = '';

  // Text controllers
  final newEmailController = TextEditingController();
  final newPasswordController = TextEditingController();

  // Email password authentication
  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: newEmailController.text.trim(),
        password: newPasswordController.text.trim(),
      );
    } catch (e) {
      errMsg = 'email or password is incorrect';
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(errMsg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    newEmailController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Share.. Bao~",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: newEmailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'email',
                                  fillColor: Colors.grey[200],
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'password',
                                  fillColor: Colors.grey[200],
                                  filled: true),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => login(),
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
