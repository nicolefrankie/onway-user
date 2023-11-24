import 'package:flutter/material.dart';
// import 'package:onway_user/components/track_order.dart';
import 'package:onway_user/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnWay',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

