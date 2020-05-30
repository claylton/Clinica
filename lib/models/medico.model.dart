import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Medico {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  //String _key;
  String _nome;
  String _email;
  String _senha;
  String _crm;
  String _especialidade;
  String _tipo;

  Future<void> createMedico(BuildContext context) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: _email, password: _senha);
      user = result.user;

      await FirebaseDatabase.instance
          .reference()
          .child('Médicos')
          .child(user.uid)
          .set(
        {
          "Nome": _nome,
          "Email": _email,
          "Senha": _senha,
          "Usuário": "Médico",
          "Especialidade": _especialidade,
        },
      );

      await FirebaseDatabase.instance
          .reference()
          .child('Usuários')
          .child(user.uid)
          .set(
        {
          "Nome": _nome,
          "Usuário": "Médico",
        },
      );

      FirebaseAuth.instance.signOut();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
      );
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

  String getKey() {
    return user.uid;
  }

  // void setKey(String key) {
  //   this.user.uid = key;
  // }

  String getNome() {
    return _nome;
  }

  void setNome(String nome) {
    this._nome = nome;
  }

  String getEmail() {
    return _email;
  }

  void setEmail(String email) {
    this._email = email;
  }

  String getSenha() {
    return _senha;
  }

  void setSenha(String senha) {
    this._senha = senha;
  }

  String getCRM() {
    return _crm;
  }

  void setCRM(String crm) {
    this._crm = crm;
  }

  String getEspecialidade() {
    return _especialidade;
  }

  void setEspecialidade(String especialidade) {
    this._especialidade = especialidade;
  }

  String getTipo() {
    return _tipo;
  }

  void setTipo(String tipo) {
    this._tipo = tipo;
  }
}
