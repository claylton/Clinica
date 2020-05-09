import 'package:flutter/material.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:mobx/mobx.dart';
//import 'package:provider/provider.dart';
//import 'package:todos/controllers/todo.controller.dart';
//import 'package:todos/stores/app.store.dart';

class ListaConsultas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final store = Provider.of<AppStore>(context);
    //final controller = new TodoController(store);
    return ListView(
      padding: EdgeInsets.only(
        left: 40,
      ),
      children: [
        ListTile(
          title: Text(
            "Doutor(a): Claylton \nEspecialidade: Clínico Geral",
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text("Data: 20/05/2020"),
        ),
        ListTile(
          title: Text(
            "Doutor(a): Claudia \nEspecialidade: Pediatra",
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text("Data: 21/05/2020"),
        ),
      ],
    );
  }
}

// Expanded(
//                 child: Container(
//                   child: ListView(
//                     padding: EdgeInsets.only(
//                       left: 40,
//                     ),
//                     children: <Widget>[
//                       ListTile(
//                         title: Text(
//                           "Doutor: Claylton",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

// ListView(
// padding: EdgeInsets.only(
//   left: 40,
// ),
//   children: <Widget>[
// ListTile(
//   title: Text(
//     "Doutor: Claylton",
//     style: TextStyle(fontSize: 18),
//   ),
// ),
//   ],
// ),
