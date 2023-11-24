import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onway_user/Pages/UserPages/signin_page.dart';
import 'package:onway_user/components/categories_menu.dart';
import 'package:onway_user/pages/UserPages/chat_page.dart';
import 'package:onway_user/pages/UserPages/notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "nicole";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 229, 104, 104),
        title: Text(
          'Welcome' +  name + "!",
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatPage(),
                    ),
                  );
            },
            child: const Icon(
              FontAwesomeIcons.solidMessage,
              color: Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(width: 35),
          InkWell(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
            },
            child: const Icon(
              FontAwesomeIcons.solidBell,
              color: Colors.black,
              size: 22,
            ),
          ),
          const SizedBox(width: 35),
          InkWell(
            onTap: () {
            showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Log Out'),
                          content: const Text('Do you want to Log Out?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ),
                                );
                              },
                              child: const Text('Log Out'),
                            ),
                          ],
                        );
                      },
                    );
                  },
            child: const Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.black,
              size: 22,
            ),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: const CategoriesMenu(),
          ),
        ],
      ),
    );
  }
}
