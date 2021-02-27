import 'package:flutter/material.dart';

class Statistiques extends StatefulWidget {
  Statistiques({Key key}) : super(key: key);

  @override
  _StatistiquesState createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Statistiques', style: TextStyle(fontSize: 48.0),),
    );
  }
}
