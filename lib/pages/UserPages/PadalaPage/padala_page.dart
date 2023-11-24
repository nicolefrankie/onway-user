import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:onway_user/Pages/UserPages/PadalaPage/history_page.dart';
import 'package:onway_user/Pages/UserPages/PadalaPage/padala_info.dart';

import 'package:onway_user/components/google_maps.dart';

class PadalaHomePage extends StatefulWidget {
  const PadalaHomePage({super.key});

  @override
  State<PadalaHomePage> createState() => _PadalaHomePageState();
}

class _PadalaHomePageState extends State<PadalaHomePage> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _userLocationController = TextEditingController();

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
          'Padala',
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPadalaPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child:
                  Image.asset('assets/images/bill.png', height: 30, width: 30),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(
                        20), // Add more padding for a cleaner look
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userLocationController,
                          decoration: InputDecoration(
                            hintText: 'User Location',
                            prefixIcon: const Icon(
                              Icons.store,
                              color: Color(0xFFE37E7E), // Custom icon color
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () {},
                          // onChanged: (value) {
                          //   print(value);
                          // },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _destinationController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Where to?',
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Color(0xFFE37E7E), // Custom icon color
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GoogleMapsLocator(),
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Google Maps...
            const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PadalaPurchaseInformation(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDEDED),
                    foregroundColor: const Color.fromARGB(223, 255, 53, 53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(223, 255, 53, 53),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
