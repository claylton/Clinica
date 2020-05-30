import 'package:clinica/components/button.widget.dart';
import 'package:clinica/models/consulta.model.dart';
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
  //DateTime _date;

  Consulta consulta = new Consulta();
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = new DateFormat('dd/MM/yyyy');

  String nomeConsulta = "";
  DateTime data = DateTime.now();

  // Future<Null> selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: date,
  //     firstDate: DateTime(2000, 1),
  //     lastDate: DateTime(2099),
  //   );
  //   if (picked != null && picked != date) {
  //     setState(() {
  //       date = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Clínica Saitama",
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              //top: 80,
              left: 40.0,
              right: 40.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(
                      _dateFormat.format(data),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      consulta.selectDate(context).then((dataParametro) {
                        setState(() {
                          this.data = dataParametro;
                        });
                      });
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
              text: "Médicos Disponiveis",
              width: double.infinity,
              callback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaMedico(),
                  ),
                );
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
