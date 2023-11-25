import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onway_user/Controller/location_controller.dart';
import 'package:onway_user/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return GetMaterialApp(
      title: 'OnWay',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

