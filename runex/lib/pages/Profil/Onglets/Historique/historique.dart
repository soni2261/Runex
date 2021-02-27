import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  Historique({Key key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Historique',
        style: TextStyle(fontSize: 48.0),
      ),
    );
  }
}
