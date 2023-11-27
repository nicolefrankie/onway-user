import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class SearchPlacesPage extends StatefulWidget {
  final TextEditingController locationController;

  const SearchPlacesPage({
    required this.locationController,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPlacesPage> createState() => _SearchPlacesPageState();
}

class _SearchPlacesPageState extends State<SearchPlacesPage> {
  final TextEditingController _searchController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = 'xyz123';
  List<dynamic> _placeList = [];


  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
     onChange();
    });
  }

  void onChange() {
    if(_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion (_searchController.text);
  }

  void getSuggestion(String input) async {
    String placeApiKkey = 'AIzaSyD9botu4RRAG4Z8Sob0yti5OQY6ZCKnqMU';

    try{
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$placeApiKkey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
     // toastMessage('success');
    }
  }

  void getCoordinates(String input) async {
    String placeApiKkey = 'AIzaSyD9botu4RRAG4Z8Sob0yti5OQY6ZCKnqMU';

    try{
      String baseURL =
          'https://maps.googleapis.com/maps/api/geocode/json?key=API_KEY&place_id=PLACE_ID';
      String request = '$baseURL?key=$placeApiKkey&place_parameter->place_id';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
     // toastMessage('success');
    }
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
      backgroundColor: const Color(0xFFEDEDED),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 5, bottom: 10),
                    child: TextFormField(
                      controller: _searchController,
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
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]['description']),
                    onTap: () async {
                      List<Location> locations = await locationFromAddress(_placeList[index]['description']);

                      print(locations.last.longitude);
                      print(locations.last.latitude);
                      
                      getCoordinates(_placeList[index]['place_id']);

                      widget.locationController.text =
                          _placeList[index]['description'];
                      // Navigate back
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}