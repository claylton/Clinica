import 'package:clinica/view/signup-medico.view.dart';
import 'package:clinica/view/signup-paciente.view.dart';
import 'package:flutter/material.dart';

class OpcaoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Escolha uma Opção:",
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupMedicoView(),
                      ),
                    );
                  },
                  child: Text(
                    "Médico",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPacienteView(),
                      ),
                    );
                  },
                  child: Text(
                    "Paciente",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
