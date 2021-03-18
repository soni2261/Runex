import 'package:flutter/material.dart';
import 'package:runex/Screens/Profil/Onglets/Objectifs/Creation_Objectifs/CreerObjectif.dart';
import 'package:runex/constants.dart';

class Objectifs extends StatefulWidget {
  Objectifs({Key key}) : super(key: key);

  @override
  _ObjectifsState createState() => _ObjectifsState();
}

class _ObjectifsState extends State<Objectifs> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            //builder: (context) => CreerObjectif(),
            builder: (context) => CreerObjectif(),
          ));
        },
        child: Text('Créer un objectif'),
=======
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Ink(
            decoration: const ShapeDecoration(
              color: kPrimaryColor,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.mode_outlined),
              color: kPrimaryLightColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  //builder: (context) => CreerObjectif(),
                  builder: (context) => CreerObjectif(),
                ));
              },
            ),
          ),
        ),
>>>>>>> parent of 8a64055 (Revert "Merge branch 'main' of https://github.com/soni2261/Runex into main")
      ),
    ]);
  }
}
