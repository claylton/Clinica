import 'package:clinica/themes/green.theme.dart';
import 'package:clinica/view/login.view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Saitama',
      debugShowCheckedModeBanner: false,
      theme: greenTheme(),
      home: LoginView(),
    );
  }
}
