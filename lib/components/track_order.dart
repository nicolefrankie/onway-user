import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  final String apiKey = '';

  static const LatLng userloc = LatLng(15.1446188, 120.5953471);
  static const LatLng storeloc = LatLng(15.1436398, 120.5963607);
  static const CameraPosition cameraPosition = CameraPosition(
    target: userloc,
    zoom: 15,
  );

  final Completer<GoogleMapController> _mapController = Completer();

  final Set<Marker> _markers = {};
  final List<LatLng> polylineCoordinates = [];

  Future<void> getPolyline() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(userloc.latitude, userloc.longitude),
        PointLatLng(storeloc.latitude, storeloc.longitude),
      );

      if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        // Update the polyline
      });
    }
    } catch (e) {
      // Handle the error - for example, print the error message
      print("HandshakeException occurred: $e");
      // You could also display an error message to the user
      // setState(() {
      //   errorMessage = "Failed to fetch route. Please check your connection.";
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('userloc'),
      position: userloc,
    ));
    _markers.add(Marker(
      markerId: MarkerId('storeloc'),
      position: storeloc,
    ));

    getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 104, 104),
        title: Text(
          "Track Order",
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: Column(
        children: [
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     "Delivery Driver:",
          //     style: GoogleFonts.notoSans(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w700,
          //       color: const Color.fromARGB(255, 255, 126, 126),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          //   child: Container(
          //     height: 70,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Padding(
          //       padding: EdgeInsets.all(12.0),
          //       child: Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 25, // Adjust the radius as needed
          //             backgroundImage: AssetImage(
          //                 'assets/profile_image.png'), // Replace with your image path
          //           ),
          //           SizedBox(
          //               width:
          //                   10), // Add some spacing between the image and text
          //           Expanded(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "Nicole Frankie D. Capuno",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.normal,
          //                   ),
          //                 ),
          //                 SizedBox(height: 5),
          //                 Text(
          //                   "+639163301894",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.normal,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          //km info
          // Google Maps
          Expanded(
            child: Container(
              child: GoogleMap(
                initialCameraPosition: cameraPosition,
                mapType: MapType.normal,
                markers: _markers,
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    color: Colors.blue,
                    points: polylineCoordinates,
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
