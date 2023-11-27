import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPadalaPage extends StatefulWidget {
  const HistoryPadalaPage({super.key});

  @override
  State<HistoryPadalaPage> createState() => _HistoryPadalaPageState();
}

class _HistoryPadalaPageState extends State<HistoryPadalaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 104, 104),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Delivery History',
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/emptycart.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'All your items are here!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}