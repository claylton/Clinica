import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Paciente {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  String _userId;
  String _nome;
  String _tipo = "Paciente";
  String _nascimento;
  String _telefone;
  String _rg;
  String _cpf;
  String _email;
  String _senha;

  Future<void> createPaciente(BuildContext context) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: _email, password: _senha);
      user = result.user;

      await FirebaseDatabase.instance
          .reference()
          .child('Pacientes')
          .child(user.uid)
          .set(
        {
          "Nome": _nome,
          "Email": _email,
          "Senha": _senha,
          "Usuário": "Paciente",
          "Nascimento": _nascimento,
          "Telefone": _telefone,
          "Rg": _rg,
          "Cpf": _cpf,
        },
      );

      await FirebaseDatabase.instance
          .reference()
          .child('Usuários')
          .child(user.uid)
          .set(
        {
          "Nome": _nome,
          "Usuário": "Paciente",
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

  void setKey(String key) {
    this._userId = key;
  }

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

  String getNascimento() {
    return _nascimento;
  }

  void setNascimento(String nascimento) {
    this._nascimento = nascimento;
  }

  String getCPF() {
    return _cpf;
  }

  void setCPF(String cpf) {
    this._cpf = cpf;
  }

  String getRg() {
    return _rg;
  }

  void setRG(String rg) {
    this._rg = rg;
  }

  String getTipo() {
    return _tipo;
  }

  String getTelefone() {
    return _telefone;
  }

  void setTelefone(String telefone) {
    this._telefone = telefone;
  }

  void setTipo(String tipo) {
    this._tipo = tipo;
  }
}
