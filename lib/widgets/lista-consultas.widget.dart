import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:mobx/mobx.dart';
//import 'package:provider/provider.dart';
//import 'package:todos/controllers/todo.controller.dart';
//import 'package:todos/stores/app.store.dart';

class ListaConsultas extends StatefulWidget {
  @override
  _ListaConsultasState createState() => _ListaConsultasState();
}

class _ListaConsultasState extends State<ListaConsultas> {
  SharedPreferences prefs;
  FirebaseDatabase db = FirebaseDatabase.instance;
  bool eMed = false;

  // @override
  // void initState() {
  //   super.initState();
  //   loadUserTipo();
  //   consultarTipo();
  // }

  // Future consultarTipo() async {
  //   StreamSubscription<Event> user = db
  //       .reference()
  //       .child("Usuários")
  //       .child(prefs.getString("currentUserId"))
  //       .onValue
  //       .listen((Event event) {
  //     Map currentUser = event.snapshot.value;
  //     prefs.setString("currentUserType", currentUser['Usuário']);
  //     setState(() {
  //       String tipoUser = "${prefs.getString("currentUserType")}";
  //       if (tipoUser == "Médico") {
  //         eMed = true;
  //       } else {
  //         eMed = false;
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    loadPref().then((value) {
      setState(() {
        prefs = value;
      });
      loadUserInfo();
    });
    super.initState();
  }

  Future loadPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<Null> loadMedicos() async {
    await FirebaseDatabase.instance
        .reference()
        .child('Médicos')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach(
        (key, value) {
          setState(() {
            // medicoList.add(value);
          });
        },
      );
    });
  }

  // Future loadUser() async {
  //   StreamSubscription<Event> user = db
  //       .reference()
  //       .child((eMed == true) ? "Médicos" : "Pacientes")
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, value) {
  //       setState(() {});
  //     });
  //   });
  // }

  Future loadUserInfo() async {
    StreamSubscription<Event> user = db
        .reference()
        .child("Usuários")
        .child(prefs.getString("currentUserId"))
        .onValue
        .listen((Event event) {
      Map currentUser = event.snapshot.value;
      //prefs.setString("currentUserName", currentUser['nome']);
      prefs.setString("currentUserType", currentUser['Usuário']);
      setState(() {
        String tipoUser = "${prefs.getString("currentUserType")}";

        if (tipoUser == "Médico") {
          eMed = true;
        } else {
          eMed = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          height: 100,
          width: 30,
          child: Card(
            color: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0.0,
            child: ListTile(
              isThreeLine: true,
              title: Text('Doutor: Claylton',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Kanit',
                      fontSize: 25.0)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Especialidade: Clínico Geral)',
                      style: TextStyle(
                          color: Colors.blueGrey[50], fontFamily: 'Kanit')),
                  Text('Data: 01/10/2020',
                      style: TextStyle(
                          color: Colors.blueGrey[50], fontFamily: 'Kanit')),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: Colors.white,
              ),
              onTap: () => Navigator.pushNamed(context, '/croom'),
            ),
          ),
        ),
      ],
    );
  }
}
