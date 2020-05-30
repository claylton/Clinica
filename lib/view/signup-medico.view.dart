import 'package:clinica/models/consulta.model.dart';
import 'package:clinica/models/medico.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupMedicoView extends StatefulWidget {
  @override
  _SignupMedicoViewState createState() => _SignupMedicoViewState();
}

class _SignupMedicoViewState extends State<SignupMedicoView> {
  Medico medico = new Medico();
  Consulta consulta = new Consulta();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  Future loadPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> register(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      medico.createMedico(context);
      //consulta.createConsulta(context);
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
                          onSaved: (value) => medico.setNome(value),
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
                          onSaved: (value) => medico.setEmail(value),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "CRM",
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
                              return 'CRM Inválido';
                            }
                            return null;
                          },
                          onSaved: (value) => medico.setCRM(value),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Especialidade",
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
                              return 'Especialidade Inválida';
                            }
                            return null;
                          },
                          onSaved: (value) => medico.setEspecialidade(value),
                        ),
                        SizedBox(
                          height: 15,
                        ),
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
                          onSaved: (value) => medico.setSenha(value),
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
