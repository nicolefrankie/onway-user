import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onway_user/Pages/UserPages/PabiliPages/history_page.dart';
import 'package:onway_user/Pages/UserPages/home_page.dart';
import 'package:onway_user/components/search_places.dart';
import 'package:onway_user/pages/UserPages/PabiliPages/deliver_confirm.dart';

class PabiliItem {
  String itemName;
  int quantity;

  PabiliItem({required this.itemName, required this.quantity});
}

class PabiliHomePage extends StatefulWidget {
  const PabiliHomePage({super.key});

  @override
  State<PabiliHomePage> createState() => _PabiliHomePageState();
}

class _PabiliHomePageState extends State<PabiliHomePage> {
  List<Container> containers = [];
  List<PabiliItem> pabiliItems = []; 

  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _estimatedPriceController = TextEditingController();
  final TextEditingController _shopLocationController = TextEditingController();
  final TextEditingController _userLocationController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  // ignore: unused_field
  int _characterCount = 0;
  final int _maxCharacterCount = 90;

  bool addSchedule = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }


  @override
  void dispose() {
    itemController.dispose();
    qtyController.dispose();
    _instructionController.dispose();
    _estimatedPriceController.dispose();
    _shopLocationController.dispose();
    _userLocationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 104, 104),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Pabili',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryItemPage(),
                ),
              );
            },
            child: Image.asset('assets/images/bill.png', height: 30, width: 30),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Ability to search the store and user location
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _shopLocationController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Shop Location',
                              prefixIcon: const Icon(
                                Icons.store,
                                color: Color(0xFFE37E7E), // Custom icon color
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPlacesPage( locationController: _shopLocationController,),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: TextFormField(
                          controller: _userLocationController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Destination',
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Color(0xFFE37E7E),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPlacesPage( locationController: _userLocationController,),
                                ),
                              );
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Items to Purchase:',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: itemController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Item',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                // You can access the inputted text using the 'value' parameter
                                // Do something with the input, if needed
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              controller: qtyController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Qty.',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) {
                                // You can access the inputted text using the 'value' parameter
                                // Do something with the input, if needed
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: containers.length,
                      itemBuilder: (context, index) {
                        return containers[index];
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String item = itemController.text;
                              String qty = qtyController.text;
                              if (item.isNotEmpty && qty.isNotEmpty) {
                                PabiliItem pabiliItem = PabiliItem(itemName: item, quantity: int.parse(qty));
                                pabiliItems.add(pabiliItem);
                              }
                              containers.add(
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText: 'Item',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 10,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                hintText: 'Qty.',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 10,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Instruction:',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '(Feel free to give instructions to your pabili)',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _instructionController,
                      maxLength: _maxCharacterCount,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (text) {
                        setState(() {
                          _characterCount = text.length;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.red,
                        ),
                        children: [
                          TextSpan(
                            text: 'Estimated Price ',
                            style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text:
                                '(Amount should be more than P100 but limited to P2000)',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _estimatedPriceController,
                      decoration: InputDecoration(
                        hintText: 'Enter estimated price (PHP)',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Do you want to set schedule?",
                        style: GoogleFonts.amiko(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: addSchedule,
                          onChanged: (bool? value) {
                            setState(() {
                              addSchedule = value!;
                            });
                          },
                        ),
                        Text(
                          'Yes',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Radio(
                          value: false,
                          groupValue: addSchedule,
                          onChanged: (bool? value) {
                            setState(() {
                              addSchedule = value!;
                            });
                          },
                        ),
                        Text(
                          'No',
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                      ],
                    ),
                    if (addSchedule)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEDEDED),
                              foregroundColor: const Color.fromARGB(223, 255, 53, 53),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            child: Text(
                              'Select Date',
                              style: GoogleFonts.amiko(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _selectTime(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEDEDED),
                              foregroundColor: const Color.fromARGB(223, 255, 53, 53),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            child: Text(
                              'Select Time',
                              style: GoogleFonts.amiko(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Selected Date: ${selectedDate.toLocal()}',
                            style: GoogleFonts.amiko(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Selected Time: ${selectedTime.format(context)}',
                            style: GoogleFonts.amiko(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),

                    ElevatedButton(
                      onPressed: () {
                        // Validate the estimated price
                        double? estimatedPrice =
                            double.tryParse(_estimatedPriceController.text);
                        if (estimatedPrice == null ||
                            estimatedPrice < 100 ||
                            estimatedPrice > 2000) {
                          // Show an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Estimated price must be between PHP 100 and PHP 2000.'),
                            ),
                          );
                        } else {
                          // The estimated price is valid
                          // Do something with the estimated price, e.g. save it to a database or display it to the user
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryConfirmation(pabiliItems: pabiliItems, instructionController: _instructionController,),
                            ),
                          );
                        }
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
                        'Confirm',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(223, 255, 53, 53),
                        ),
                      ),
                    ),
                  ],
                ),
              
              ),
          ],
        ),
      ),
    );  
  }
}
