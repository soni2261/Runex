import 'package:flutter/material.dart';
import 'package:runex/constants.dart';
import 'Creation_Objectifs/creer_objectif.dart';

class Objectifs extends StatefulWidget {
  Objectifs({Key key}) : super(key: key);

  @override
  _ObjectifsState createState() => _ObjectifsState();
}

class _ObjectifsState extends State<Objectifs> {
  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => CreerObjectif(),
                  //builder: (context) => CreerObjectif(),
                ));
              },
            ),
          ),
        ),
      ),
    ]);
  }
}
