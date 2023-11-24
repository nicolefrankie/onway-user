import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:onway_user/models/location.dart';

class GoogleMapsLocator extends StatefulWidget {
  const GoogleMapsLocator({super.key});

  @override
  State<GoogleMapsLocator> createState() => _GoogleMapsLocatorState();
}

class _GoogleMapsLocatorState extends State<GoogleMapsLocator> {
  // void navigateToOtherPage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PabiliHomePage(userLocation: _draggedAddress),
  //     ),
  //   );
  // }

  // final TextEditingController _shopLocationController = TextEditingController();
  late TextEditingController _searchLocationController;

  static const LatLng _angeles = LatLng(15.1441, 120.5888);
  static const CameraPosition cameraPosition = CameraPosition(
    target: _angeles,
    zoom: 15.5,
  );

  Set<Marker> markers = {};

  final Completer<GoogleMapController> _mapController = Completer();
  String _draggedAddress = "";
  late LatLng _draggedLatlng;

  Marker _userMarker = Marker(
    markerId: MarkerId('userMarker'),
    position: _angeles,
    icon: BitmapDescriptor
        .defaultMarker, // You can customize the marker icon here
  );

  @override
  void initState() {
    super.initState();
    // _addCenterMarker();
    // _draggedAddress = _angeles;
    _userCurrentLocation();
    _searchLocationController = TextEditingController(text: _draggedAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      backgroundColor: const Color.fromARGB(255, 229, 104, 104),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                  child: TextFormField(
                    controller: _searchLocationController,
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () async {
              //     // Call the search function here
              //     var place = await LocationService()
              //         .getPlace(_searchLocationController.text);
              //     _goToPlace(place);
              //   },
              //   icon: const Icon(Icons.search),
              // ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _draggedAddress,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: cameraPosition,
                    mapType: MapType.hybrid,
                    onCameraIdle: () {
                      _getAddress(_draggedLatlng);
                    },
                    onCameraMove: (position) {
                      setState(() {
                        _draggedLatlng = position.target;
                        _userMarker =
                            _userMarker.copyWith(positionParam: _draggedLatlng);
                      });
                    },
                    markers: {_userMarker},
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                    zoomControlsEnabled: false,
                  ),
                ),
                // ElevatedButton(
                //     onPressed: navigateToOtherPage,
                //     child: Text(
                //       "Done",
                //       style: TextStyle(fontSize: 14),
                //     ))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _userCurrentLocation();
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }

  Future<void> _getAddress(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark address = placemarks[0];
      String addressStr =
          "${address.street}, ${address.locality}, ${address.subAdministrativeArea}";
      setState(() {
        _draggedAddress = addressStr;
      });
    } catch (e) {
      print("Error getting address: $e");
      // Handle the error accordingly, such as setting a default address or displaying an error message
    }
  }

  Future _userCurrentLocation() async {
    Position currentPosition = await _determinePosition();
    _specificPosition(
      LatLng(currentPosition.latitude, currentPosition.longitude),
    );
  }

  Future _specificPosition(LatLng position) async {
    GoogleMapController mapController = await _mapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: 14.5,
        ),
      ),
    );
    await _getAddress(position);
    _draggedLatlng = position;
  }

  Future _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    //Check if the user enable service for location permission
    if (!serviceEnabled) {
      return Future.error("Location Service are disabled");
    }
    locationPermission = await Geolocator.checkPermission();

    //Chech if user denied location
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission denied");
      }
    }

    //Check if location permission denied forever
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission denied forever");
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
