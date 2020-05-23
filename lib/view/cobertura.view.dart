import 'package:clinica/view/home.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cobertura extends StatefulWidget {
  @override
  _CoberturaState createState() => _CoberturaState();
}

class _CoberturaState extends State<Cobertura> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  String _nomeCobertura;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future loadPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

        await FirebaseDatabase.instance
            .reference()
            .child('cobertura')
            .set({
          "nome": _nomeCobertura,
        });

        FirebaseAuth.instance.signOut();

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeView(),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadPref().then((value) {
      prefs = value;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
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
                        Text(
                          "Médico",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Nome",
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
                          onSaved: (input) => _nomeCobertura = input,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Nome Cobertura",
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
                              return 'Cobertura Inválida';
                            }
                            return null;
                          },
                          onSaved: (value) => _nomeCobertura = value,
                        ),
                        SizedBox(
                          height: 10,
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
                              "adicionar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              register(context);
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
