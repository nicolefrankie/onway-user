import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onway_user/pages/UserPages/PabiliPages/pabili_page.dart';
import 'package:onway_user/pages/UserPages/home_page.dart';

class PabiliTrackBookingPage extends StatefulWidget {
  const PabiliTrackBookingPage({super.key});

  @override
  State<PabiliTrackBookingPage> createState() => _PabiliTrackBookingPageState();
}

class _PabiliTrackBookingPageState extends State<PabiliTrackBookingPage> {
  final Completer<GoogleMapController> _mapController = Completer();

  static const LatLng driverLocation = LatLng(16.043493,120.3301977);
  static const LatLng userLocation = LatLng(16.043067,120.336524);
  static const CameraPosition cameraPosition = CameraPosition(
    target: driverLocation,
    zoom: 15.5,
  );

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    'AIzaSyD9botu4RRAG4Z8Sob0yti5OQY6ZCKnqMU',
    PointLatLng(driverLocation.latitude, driverLocation.longitude),
    PointLatLng(userLocation.latitude, userLocation.longitude),
  );

  if (result.points.isNotEmpty) {
    result.points.forEach(
      (PointLatLng point) => polylineCoordinates.add(
        LatLng(point.latitude, point.longitude),
      ),
    );
    setState(() {

    });
  } else {
    // Handle the case where no route is found (ZERO_RESULTS)
    print("No route found between the specified locations.");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Maps Widget as the background
          GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              markers: {
                const Marker(
                  markerId: MarkerId("driverLocation"),
                  position: driverLocation,
                ),
                const Marker(
                  markerId: MarkerId("userLocation"),
                  position: userLocation,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
              initialCameraPosition: cameraPosition,
              zoomControlsEnabled: false,
            ),

          // Other Widgets Overlaying the Map
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The user and store location should be placed here
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(20),
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
                      Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Driver Name: ",
                              style: GoogleFonts.notoSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                              child: Text(
                                "Contact Number: ",
                                style: GoogleFonts.notoSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                              child: Text(
                                "Km: ",
                                style: GoogleFonts.notoSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                              child: Text(
                                "Delivery Fee: ",
                                style: GoogleFonts.notoSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
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
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delivery Received'),
                                        content: const Text('The delivery driver has delivered your items!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PabiliHomePage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Book Deliver'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Go Home'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEDEDED),
                                  foregroundColor: const Color.fromARGB(223, 255, 53, 53),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                ),
                                child: Text(
                                  'Delivery Received',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}