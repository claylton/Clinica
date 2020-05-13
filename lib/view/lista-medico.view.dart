import 'dart:async';

import 'package:clinica/models/medico.model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaMedico extends StatefulWidget {
  @override
  _ListaMedicoState createState() => _ListaMedicoState();
}

class _ListaMedicoState extends State<ListaMedico> {
  final _formKey = GlobalKey<FormState>();

  String nomeMedico;
  SharedPreferences prefs;
  DatabaseReference refMed =
      FirebaseDatabase.instance.reference().child("usuarios");

  var medicoList = [];
  Medico medico;
  final FirebaseDatabase db = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    medico = new Medico("");
    refMed = db.reference().child('usuarios');
    var userMedico = FirebaseDatabase.instance
        .reference()
        .child('usuarios')
        .child('Médico')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach(
        (key, value) {
          medicoList.add(value);

          print(value);
        },
      );
    });
  }

  Future loadUserType() async {
    StreamSubscription<Event> user = db
        .reference()
        .child("usuarios")
        .child(prefs.getString("currentUserId"))
        .onValue
        .listen((Event event) {
      Map currentUser = event.snapshot.value;
      //prefs.setString("currentUserName", currentUser['nome']);
      prefs.setString("currentUserType", currentUser['usuario']);
      setState(() {});
    });
  }

  Future loadUserInfo() async {
    StreamSubscription<Event> user = db
        .reference()
        .child("usuarios")
        .child("${prefs.getString("currentUserType")}")
        .child(prefs.getString("currentUserId"))
        .onValue
        .listen((Event event) {
      Map currentUser = event.snapshot.value;
      prefs.setString("currentUserName", currentUser['nome']);
      //prefs.setString("currentUserType", currentUser['usuario']);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clínica Saitama",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Form(
          child: Column(
            children: [
              Flexible(
                flex: 0,
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        // ListView.builder(
                        //   itemCount: medicoList.length,
                        //   itemBuilder: (context, index) {
                        //     var medico = medicoList[index];

                        //     // return ListTile(
                        //     //   title: Text(
                        //     //     medico.toString(),
                        //     //   ),
                        //     // );
                        //   },
                        // ),
                        // Column(children: [
                        //     medicoList[0],

                        //   Container(
                        //     child: Text(),
                        //   ),
                        // ],)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
