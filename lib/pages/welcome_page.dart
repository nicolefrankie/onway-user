import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onway_user/Pages/UserPages/SignUpPage/user_info.dart';

import 'package:onway_user/widgets/images.dart';
import 'package:onway_user/Pages/UserPages/signin_page.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.2175,
                      color: const Color.fromARGB(223, 255, 53, 53),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 214,
                    height: 205,
                    child: imageWidget("assets/images/logo.png"),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'Experience Seamless Deliveries with Our Trusted Service',
                    style: GoogleFonts.notoSansArmenian(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserInformation(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(223, 255, 53, 53),
                          onPrimary: const Color(0xFFEDEDED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFEDEDED)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFEDEDED),
                          onPrimary: const Color.fromARGB(223, 255, 53, 53),
                          side: const BorderSide(
                            color: Color.fromARGB(223, 255, 53, 53),
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(223, 255, 53, 53),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
