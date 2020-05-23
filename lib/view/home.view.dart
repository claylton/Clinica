import 'package:clinica/controllers/login.controller.dart';
import 'package:clinica/view/consulta.view.dart';
import 'package:clinica/view/login.view.dart';
import 'package:clinica/view/perfil.view.dart';
import 'package:clinica/widgets/botao_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String nome;
  String usuario;
  final controllerLogin = new LoginController();

  SharedPreferences prefs;
  FirebaseAuth auth = FirebaseAuth.instance;
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Text(""),
        title: Text(
          "Clínica Saitama",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              controllerLogin.logOut(prefs);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginView(),
                ),
              );
            },
            icon: Icon(Icons.person),
            label: Text("Sair"),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              prefs != null
                  ? "${prefs.getString("currentUserName")}"
                  : "Usuário",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              prefs != null
                  ? "${prefs.getString("currentUserType")}"
                  : "Médico ou Paciente",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Row(
                  children: <Widget>[
                    BotaoHome(
                      icon: Icons.add_circle_outline,
                      nome: "Meu Perfil",
                      color: Colors.amber,
                      proximo: PerfilView(),
                      context: context,
                    ),
                    BotaoHome(
                      icon: Icons.add_circle_outline,
                      nome: "Consultas",
                      color: Colors.blue,
                      context: context,
                      proximo: ConsultaView(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    BotaoHome(
                        icon: Icons.add,
                        nome: "Cobertura",
                        color: Colors.grey,
                        proximo: null,
                        context: context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
