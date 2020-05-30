import 'dart:async';

import 'package:clinica/view/consulta.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Consulta {
  FirebaseUser user;
  SharedPreferences prefs;
  FirebaseDatabase db = FirebaseDatabase.instance;
  ConsultaView date = new ConsultaView();

  String _key;
  String _dateConsulta;
  String _medicoName;
  String _medicoEspecia;
  String _nomePaciente;
  String _userId;

  Future loadPref() async {
    return await SharedPreferences.getInstance();
  }

  Future loadUserInfo() async {
    StreamSubscription<Event> user = db
        .reference()
        .child("Usuários")
        .child(prefs.getString("currentUserId"))
        .onValue
        .listen((Event event) {
      Map currentUser = event.snapshot.value;
      prefs.setString("currentUserName", currentUser['Nome']);
      prefs.setString("currentUserType", currentUser['Usuário']);
    });
  }

  Future loadMedInfo() async {
    StreamSubscription<Event> user = db
        .reference()
        .child("Médicos")
        .child(prefs.getString("currentMedId"))
        .onValue
        .listen((Event event) {
      Map currentUser = event.snapshot.value;
      prefs.setString("currentMedEspe", currentUser['Especialidade']);
      prefs.setString("currentMedName", currentUser['Nome']);
    });
  }

  Future<void> createConsulta(BuildContext contex, String nomeMedico,
      String especialidadeMedico, DateTime dataConsulta) async {
    //Mudar Caminho
    loadPref().then((value) {
      this.prefs = value;
    });
    await FirebaseDatabase.instance
        .reference()
        .child(prefs.getString("currentUserType"))
        //.child('Pacientes')
        .child(getUserId())
        .child('Consultas')
        .set(
      {
        "Médico": nomeMedico,
        "Especialidade": especialidadeMedico,
        "Data": dataConsulta,
      },
    );
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2099),
    );
    if (picked != null) {
      return picked;
    }
  }

  String getUserId() {
    var user = FirebaseAuth.instance.currentUser();
    user.then((current) {
      _userId = current.uid;
    });
    if (_userId == null) {
      return "";
    } else {
      return _userId;
    }
  }

  String get getKey => _key;

  set setKey(String value) => _key = value;

  String get getDateConsulta => _dateConsulta;

  set setDateConsulta(String value) => _dateConsulta = value;

  String get getMedicoName => _medicoName;

  set setMedicoName(String value) => _medicoName = value;

  String get getMedicoEspecia => _medicoEspecia;

  set setMedicoEspecia(String value) => _medicoEspecia = value;

  String get getNomePaciente => _nomePaciente;

  set setNomePaciente(String value) => _nomePaciente = value;
}
