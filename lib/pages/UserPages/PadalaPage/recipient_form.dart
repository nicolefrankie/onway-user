import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:onway_user/Pages/UserPages/PadalaPage/padala_info.dart';

class RecipientForm extends StatefulWidget {
  const RecipientForm({Key? key}) : super(key: key);

  @override
  State<RecipientForm> createState() => _RecipientFormState();
}

class _RecipientFormState extends State<RecipientForm> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _name = '';
  // ignore: unused_field
  final String _contactNumber = '';
  // ignore: unused_field
  final String _address = '';

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
          'Add Recipient Details',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        // centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recipient Name:',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter the recipient name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact Number:',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter the contact number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number is required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Address:',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter the address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number is required.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form != null) {
                      if (form.validate()) {
                        // All fields are valid, proceed with saving the recipient's information.
                        // You can access the form values using _name, _contactNumber, _address.
                        // For now, let's just print them to the console.

                        // You can navigate to the next screen here if needed.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PadalaPurchaseInformation(),
                          ),
                        );
                      } else {
                        // Show a SnackBar indicating that some fields are required.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Please fill in all required fields.'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
