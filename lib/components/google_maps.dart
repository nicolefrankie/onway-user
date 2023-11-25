import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onway_user/Controller/location_controller.dart';
import 'package:onway_user/Controller/location_search_dialog.dart';

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
        .defaultMarker, 
  );

  @override
  void initState() {
    super.initState();
    // _addCenterMarker();
    // _draggedAddress = _angeles;
    _userCurrentLocation();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
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
        body: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: cameraPosition,
                mapType: MapType.normal,
                onCameraIdle: () {
                  // _getAddress(_draggedLatlng);
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
            Positioned(
              top: 100,
              left: 10, 
              right: 20,
              child: GestureDetector(
                 onTap: () {
                  Completer<GoogleMapController> mapControllerCompleter = Completer();
                  Get.dialog(LocationSearchDialog(mapController: mapControllerCompleter));

                  // Now, use mapControllerCompleter to access the GoogleMapController when available
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 25, color:Colors.red,),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${locationController.pickPlaceMark.name ?? ''} ${locationController.pickPlaceMark.locality ?? ''}'
                          '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.search, size: 25),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _userCurrentLocation();
          },
          child: const Icon(Icons.location_on),
        ),
      );
    });   
  }

  // Future<void> _getAddress(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark address = placemarks[0];
  //     String addressStr =
  //         "${address.street}, ${address.locality}, ${address.subAdministrativeArea}";
  //     setState(() {
  //       _draggedAddress = addressStr;
  //     });
  //   } catch (e) {
  //     print("Error getting address: $e");
  //     // Handle the error accordingly, such as setting a default address or displaying an error message
  //   }
  // }

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
    // await _getAddress(position);
    // _draggedLatlng = position;
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