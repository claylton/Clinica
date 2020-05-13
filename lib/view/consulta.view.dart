import 'package:clinica/components/button.widget.dart';
import 'package:clinica/widgets/lista-consultas.widget.dart';
import 'package:clinica/view/lista-medico.view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultaView extends StatefulWidget {
  @override
  _ConsultaViewState createState() => _ConsultaViewState();
}

class _ConsultaViewState extends State<ConsultaView> {
  // String _nome;
  // DateTime _date;

  final _formKey = GlobalKey<FormState>();
  final _dateFormat = new DateFormat('dd/MM/yyyy');

  String nomeConsulta = "";
  DateTime date = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2099),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: SingleChildScrollView(
      //child:
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 40.0,
              right: 40.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //Container(
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaMedico(),
                        ),
                      );
                    },
                    child: Text(
                      "Médicos disponíveis",
                      style: TextStyle(color: Colors.white),
                    ),
                    // shape: new RoundedRectangleBorder(
                    //   borderRadius: new BorderRadius.circular(1.0),
                    // ),
                  ),
                  //),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      _dateFormat.format(date),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text('Escolher Data'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Minhas Consultas",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListaConsultas(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              right: 40,
              top: 20,
              bottom: 10,
            ),
            child: TDButton(
              text: "Marcar",
              width: double.infinity,
              callback: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }

                _formKey.currentState.save();
              },
            ),
          ),
          FlatButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomeView(),
              //   ),
              // );
            },
            child: Text("Cancelar"),
          ),
        ],
      ),
      // ),
    );
  }
}
