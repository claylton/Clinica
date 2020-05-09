import 'package:flutter/material.dart';

class BotaoHome extends StatefulWidget {
  IconData icon;
  String nome;
  Color color;
  Widget proximo;
  BuildContext context;

  BotaoHome({
    @required this.icon,
    @required this.nome,
    @required this.color,
    @required this.proximo,
    @required this.context,
  });

  @override
  _BotaoHomeState createState() => _BotaoHomeState();
}

class _BotaoHomeState extends State<BotaoHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          color: widget.color,
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => widget.proximo));
            },
            splashColor: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      widget.icon,
                      size: 100.0,
                      color: Colors.white,
                    ),
                    Text(
                      widget.nome.toUpperCase(),
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
