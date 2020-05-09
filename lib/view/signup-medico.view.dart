import 'package:clinica/models/medico.model.dart';
import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupMedicoView extends StatefulWidget {
  @override
  _SignupMedicoViewState createState() => _SignupMedicoViewState();
}

class _SignupMedicoViewState extends State<SignupMedicoView> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  FirebaseUser user;

  String _nome;
  String _email;
  String _tipo = "Médico";
  String _crm;
  String _especialidade;
  String _senha;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future loadPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

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
          Fluttertoast.showToast(
              msg: "A senha deve ter no mínimo 6 caracteres");
        } else {
          Fluttertoast.showToast(msg: "Cadastro inválido");
        }
      }
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
                          onSaved: (input) => _nome = input,
                        ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "E-mail",
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
                              return 'E-mail Inválido';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value,
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   // autofocus: true,
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     labelText: "CRM",
                        //     labelStyle: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   validator: (value) {
                        //     if (value.isEmpty) {
                        //       return 'CRM Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _crm = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "Especialidade",
                        //     labelStyle: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        //   validator: (value) {
                        //     if (value.isEmpty) {
                        //       return 'Especialidade Inválida';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _especialidade = input,
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
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
                              return 'Senha Inválida';
                            }
                            return null;
                          },
                          onSaved: (value) => _senha = value,
                        ),
                        SizedBox(
                          height: 40,
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
                              "Signup",
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
