import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PerfilView extends StatefulWidget {
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  String _nome;

  FirebaseUser user;
  FirebaseDatabase db = FirebaseDatabase.instance;

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

  Future<void> change(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      user = await FirebaseAuth.instance.currentUser();

      await db
          .reference()
          .child('usuarios')
          .child("${prefs.getString("currentUserType")}")
          .child(user.uid)
          .update({
        "nome": _nome,
      });
      Navigator.pop(context);
    }
  }

  Future<void> delete(BuildContext context) async {
    //Fazer um if nos métodos se paciente faz pra paciente se for médico faz pra médico
    //Testar se delata tambem a autenticação
    user = await FirebaseAuth.instance.currentUser();

    await db.reference().child('usuarios').child(user.uid).remove();
    user.delete();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginView(),
    ));
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
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 20,
            right: 20,
            bottom: 40,
          ),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      offset: new Offset(1, 2.0),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Clínica Saitama",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Perfil",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: prefs != null
                                ? "Nome: ${prefs.getString("currentUserName")}"
                                : "Nome: ",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nome Inválido';
                            }
                            return null;
                          },
                          onSaved: (input) => _nome = input,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: FlatButton(
                            child: Text(
                              "Alterar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print("Name $_nome");

                                change(context);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: FlatButton(
                            child: Text(
                              "Excluir",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              delete(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
