import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      backgroundColor: const Color.fromARGB(225, 228, 220, 207),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 103, 24, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              // myTextField("Enter Phone Number", Icons.person_outline,
              //   _emailTextController),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}