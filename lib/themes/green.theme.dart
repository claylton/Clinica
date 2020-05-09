import 'package:flutter/material.dart';

const brightness = Brightness.light;
const primaryColor = Colors.green;

ThemeData greenTheme() {
  return ThemeData(
    primaryColor: primaryColor,
    accentColor: Colors.white,
    backgroundColor: Colors.green,

    //Para tirar efeito do flatButton
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
