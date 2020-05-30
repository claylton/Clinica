import 'dart:async';
import 'package:clinica/models/consulta.model.dart';
import 'package:clinica/models/medico.model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaMedico extends StatefulWidget {
  @override
  _ListaMedicoState createState() => _ListaMedicoState();
}

class _ListaMedicoState extends State<ListaMedico> {
  DateTime data;
  String nomeMedico = "";
  String espeMedico = "";
  SharedPreferences prefs;
  DatabaseReference refMed =
      FirebaseDatabase.instance.reference().child("Usuários");

  var medicoList = [];
  Medico medico;
  Consulta consulta = new Consulta();
  final FirebaseDatabase db = FirebaseDatabase.instance;

  @override
  void initState() {
    refMed = db.reference().child('Usuários');
    loadMedicos().then((value) {});
    super.initState();
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
            medicoList.add(value);
          });
        },
      );
    });
  }

  Future<void> newConsulta(context, nomeMedico, espeMedico, data) async {
    //medico.getKey();
    consulta.createConsulta(context, nomeMedico, espeMedico, data);
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
      body: ListView.builder(
        itemCount: medicoList.length,
        itemBuilder: (context, index) {
          var medico = medicoList[index];
          //print(medicoList);
          return Container(
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            height: 100,
            width: 30,
            child: Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0.0,
              child: ListTile(
                isThreeLine: true,
                title: Text("${medico['Nome']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kanit',
                        fontSize: 25.0)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(" - ${medico['Especialidade']}",
                        style: TextStyle(
                            color: Colors.blueGrey[50], fontFamily: 'Kanit')),
                    // Text(" - ${medico['CRM']}",
                    //     style: TextStyle(
                    //         color: Colors.blueGrey[50], fontFamily: 'Kanit')),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 30,
                  color: Colors.white,
                ),
                onTap: () => {
                  print("${medico['Nome']}"),
                  //var teste = [{}];
                  nomeMedico = medico['Nome'],
                  espeMedico = medico['Especialidade'],
                  // setState(() {
                  //   nomeMedico = "${medico['Nome']}";
                  //   espeMedico = "${medico['Especialidade']}";
                  // }),
                  consulta.selectDate(context).then((dataParametro) {
                    setState(() {
                      this.data = dataParametro;
                    });
                  }),
                  newConsulta(context, nomeMedico, espeMedico, data),
                  Navigator.pushNamed(context, '/consultas'),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
