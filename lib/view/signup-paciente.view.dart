import 'package:clinica/view/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class SignupPacienteView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _nome;
  String _tipo = "Paciente";
  String _nascimento;
  String _telefone;
  String _rg;
  String _cpf;
  String _rua;
  String _bairro;
  String _nEndereco;
  String _email;
  String _senha;

  SharedPreferences prefs;
  FirebaseUser user;
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
          await FirebaseDatabase.instance
              .reference()
              .child('usuarios')
              .child(user.uid)
              .set({
            "email": _email,
            "senha": _senha,
            "usuario": _tipo,
          });

          if (_tipo == "Paciente") {
            await FirebaseDatabase.instance
                .reference()
                .child('usuarios')
                .child('Paciente')
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            //top: 60,
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
                          "Paciente",
                          style: Theme.of(context).textTheme.display2,
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
                        SizedBox(
                          height: 10,
                        ),
                        // TextFormField(
                        //   // autofocus: true,
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     labelText: "Data de Nascimento",
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
                        //       return 'Data de nascimento Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _nascimento = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "Telefone",
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
                        //       return 'Telefone Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _telefone = input,
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "RG",
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
                        //       return 'RG Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _rg = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "CPF",
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
                        //       return 'CPF Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _cpf = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "Endereço",
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
                        //       return 'Endereço Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _rua = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "Bairro",
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
                        //       return 'Bairro Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _bairro = input,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     labelText: "Número Endereço",
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
                        //       return 'Número Inválido';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (input) => _nEndereco = input,
                        // ),
                        TextFormField(
                          // autofocus: true,
                          keyboardType: TextInputType.text,
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
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                print("Name $_nome");
                                print("Name $_tipo");
                                // print("Name $_nascimento");
                                // print("Name $_telefone");
                                // print("Password $_rg");
                                // print("Password $_cpf");
                                // print("Password $_rua");
                                // print("Password $_bairro");
                                // print("Password $_nEndereco");
                                print("Password $_email");
                                print("Password $_senha");

                                register(context);
                              }
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

// void register (BuildContext context) async {
//   try {
//     FirebaseUser
//   } catch (e) {
//     print(e);
//   }
// }
