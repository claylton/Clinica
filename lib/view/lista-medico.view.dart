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
            key: _formKey,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                margin: EdgeInsets.only(
                  bottom: 35,
                  left: 30,
                  right: 30,
                ),
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {},
                  // title: Text(
                  //   "Doutor(a): Claylton ",
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // subtitle: Text("Especialidade: Clínico Geral"),
                ),
                // color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
