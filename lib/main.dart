import 'package:clinica/themes/green.theme.dart';
import 'package:clinica/view/consulta.view.dart';
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
      initialRoute: './',
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginView(),
        '/consultas': (context) => ConsultaView(),
        //    '/set_up': (context) => SetUpData(),
        //    '/picture': (context) => Picture(),
        //    '/homepage': (context) => HomePage(),
        //    '/slides': (context) => FirestoreSlideShow(),
        //    '/classes': (context) => Classes(),
        //    '/croom': (context) => Classroom(),
        //    '/chat_screen': (context) => ChatScreen(),
        //    '/calendar': (context) => CalendarPage(),
        //    '/studentProfile': (context) => StudentProfile(),
      },
    );
  }
}
