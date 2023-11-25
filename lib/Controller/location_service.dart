import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String text) async {
  try {
    final response = await http.get(
      Uri.parse('http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return response;
    } else {
      // Handle non-200 status code, e.g., log or throw an exception
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  } catch (error) {
    // Handle other errors that might occur during the request
    print('Error during HTTP request: $error');
    throw error; // Rethrow the error if needed
  }
}