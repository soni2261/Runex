import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';
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
    final theme = Provider.of<ThemeChanger>(context);
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Ink(
            decoration: ShapeDecoration(
              color: theme.isDark()
                  ? Color.fromRGBO(40, 35, 55, 1)
                  : kPrimaryColor,
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
