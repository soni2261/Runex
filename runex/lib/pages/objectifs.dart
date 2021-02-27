import 'package:flutter/material.dart';
import 'package:runex/pages/Profil/Onglets/Objectifs/Creation_Objectifs/CreerObjectif.dart';

class Objectifs extends StatefulWidget {
  Objectifs({Key key}) : super(key: key);

  @override
  _ObjectifsState createState() => _ObjectifsState();
}

class _ObjectifsState extends State<Objectifs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreerObjectif(),
          ));
        },
        child: Text('Créer un objectif'),
      ),
    );
  }
}
