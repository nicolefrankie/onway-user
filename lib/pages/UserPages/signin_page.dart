// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onway_user/Pages/UserPages/SignUpPage/user_info.dart';
import 'package:onway_user/pages/UserPages/home_page.dart';
// import 'package:onway_user/Pages/UserPages/home_page.dart';

import 'package:onway_user/widgets/images.dart';
import 'package:onway_user/Components/forgot_password.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> login() async {
  //   final email = _emailController.text;
  //   final password = _passwordController.text;

  //   final apiUrl = 'http://192.168.100.121:8000/api/customers/$email&$password';

  //   try {
  //     final response = await http.post(Uri.parse(apiUrl));

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => HomePage(),
  //         ),
  //       );
  //     } else {
  //       // Handle error cases
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Error'),
  //             content: Text('User Account Not Found'),
  //             actions: <Widget>[
  //               TextButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     print('Error $e');
  //     // Handle other exceptions as needed
  //   }
  // }

//   Future<void> login(BuildContext context) async {
//   var url = Uri.parse('http://192.168.100.121/register.php');
//   var response = await http.post(url, body: {
//     "email": _emailController.text,
//     "password": _passwordController.text
//   });

//   var data = json.decode(response.body);

//   if (data == "success") {
    
//   } else {
//     Fluttertoast.showToast(
//       msg: "The email and password don't match",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       fontSize: 16,
//     );
//   }
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(23, 103, 23, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Logo
              Container(
                margin: const EdgeInsets.fromLTRB(2, 0, 0, 45),
                width: 214,
                height: 205,
                child: imageWidget("assets/images/logo.png"),
              ),

              Form(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email",
                        style: GoogleFonts.amiko(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 254, 254),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password",
                        style: GoogleFonts.amiko(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      cursorColor: const Color.fromARGB(255, 0, 0, 0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 254, 254),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                _passwordVisible = !_passwordVisible;
                              },
                            );
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              //Forgot Password
              forgetPassword(context),

              const SizedBox(
                height: 10,
              ),

              ElevatedButton(
                // onPressed: login,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(223, 255, 53, 53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              //Sign In Option: If the user doesn't have an account
              const SizedBox(
                height: 40,
              ),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  //Sign In Option: If the user doesn't have an account
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Create an account?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserInformation(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 114, 166),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  //Forgot Password
  Widget forgetPassword(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
      // height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 114, 166),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ForgotPassword(),
          ),
        ),
      ),
    );
  }
}
