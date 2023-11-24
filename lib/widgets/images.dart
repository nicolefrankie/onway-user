import 'package:flutter/material.dart';

Image imageWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

Image menuWidget(String menuName) {
  return Image.asset(
    menuName,
    fit: BoxFit.cover,
    width: 300,
    height: 300,
  );
}
