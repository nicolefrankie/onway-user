import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PabiliCheckoutPage extends StatefulWidget {
  const PabiliCheckoutPage({super.key});

  @override
  State<PabiliCheckoutPage> createState() => _PabiliCheckoutPageState();
}

class _PabiliCheckoutPageState extends State<PabiliCheckoutPage> {
  String? selectedPayment = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Checkout',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/summary.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Order Summary",
                          style: GoogleFonts.notoSans(
                            color: const Color(0xFFF87D7D),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //Code for order summary...
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          "Subtotal:",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        //Code for subtotal...
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Delivery Fee:",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        //Code for delivery fee..
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        //Code for Total amount...
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Payment Method",
              style: GoogleFonts.notoSans(
                color: const Color(0xFFF87D7D),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RadioListTile(
              title: const Text(
                'Cash On Delivery',
                style: TextStyle(
                  color: Color(0xFF070707),
                  fontSize: 20,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "(Limited to only P500)",
                style: GoogleFonts.montserrat(
                  color: const Color(0xFFFF0000),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              value: 'Cash On Delivery',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value;
                });
                // Handle payment method change
              },
              secondary: Image.asset(
                'assets/images/cod.png',
                width: 30,
                height: 30,
              ),
            ),
            RadioListTile(
              title: const Text(
                'GCash',
                style: TextStyle(
                  color: Color(0xFF070707),
                  fontSize: 20,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: 'GCash',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value;
                });
                // Handle payment method change
              },
              secondary: Image.asset(
                'assets/images/gcash.png',
                width: 30,
                height: 30,
              ),
            ),
            RadioListTile(
              title: const Text(
                'PayPal',
                style: TextStyle(
                  color: Color(0xFF070707),
                  fontSize: 20,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: 'PayPal',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value;
                });
                // Handle payment method change
              },
              secondary: Image.asset(
                'assets/images/paypal.png',
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 200,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(223, 255, 53, 53),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            'Order Confirmation',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          content: Text(
                            'Your order has been placed.',
                            style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(223, 255, 53, 53);
                        }
                        return const Color.fromARGB(223, 255, 53, 53);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    'Book Delivery',
                    style: GoogleFonts.notoSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFEDEDED),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
