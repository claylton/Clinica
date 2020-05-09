import 'package:clinica/view/home.view.dart';
import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isLoading = false;

  Future<void> login(BuildContext context, String _email, String _senha,
      SharedPreferences prefs) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: _email, password: _senha);
      user = result.user;

      if (user != null) {
        prefs.setString("currentUserId", user.uid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "Login inválido");
        isLoading = false;
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_USER_NOT_FOUND") {
        Fluttertoast.showToast(msg: "E-mail inválido!");
      } else if (e.code == "ERROR_WRONG_PASSWORD") {
        Fluttertoast.showToast(msg: "senha inválida!");
      } else {
        Fluttertoast.showToast(msg: "Dados inválidos");
      }
    }
  }

  Future<void> logOut(prefs) async {
    await auth.signOut();
    prefs.clear();
  }

  Future<void> create(
      BuildContext context, _email, _senha, _nome, _tipo) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: _email, password: _senha);
      user = result.user;

      if (user != null) {
        //Aqui vai um if se for médico cadastra os dados na tabela médico
        //se for paciente cadastra na tabela paciente
        await FirebaseDatabase.instance
            .reference()
            .child('usuarios')
            .child(user.uid)
            .set({
          "nome": _nome,
          "email": _email,
          "senha": _senha,
          "usuario": _tipo,
        });

        if (_tipo == "Médico") {
          await FirebaseDatabase.instance
              .reference()
              .child('usuarios')
              .child('Médico')
              .child(user.uid)
              .set({
            "nome": _nome,
          });
        }

        FirebaseAuth.instance.signOut();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginView(),
        ));
      } else {
        Fluttertoast.showToast(msg: "Cadastro inválido");
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        Fluttertoast.showToast(msg: "Esse email já existe!");
      } else if (e.code == "ERROR_WEAK_PASSWORD") {
        Fluttertoast.showToast(msg: "A senha deve ter no mínimo 6 caracteres");
      } else {
        Fluttertoast.showToast(msg: "Cadastro inválido");
      }
    }
  }
}
