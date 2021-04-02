import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

import 'form_objectif_temps.dart';

class CarteObjectifTemps extends StatefulWidget {
  @override
  _CarteObjectifTempsState createState() => _CarteObjectifTempsState();
}

class _CarteObjectifTempsState extends State<CarteObjectifTemps> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Color buttonColor = theme.isDark() ? kPrimaryColor : kPrimaryLightColor;
    Color activeCheckBoxColor =
        theme.isDark() ? kPrimaryLightColor : kPrimaryColor;
    Color checkColor = theme.isDark() ? kPrimaryColor : kPrimaryLightColor;

    Utilisateur utilisateur = Provider.of<Utilisateur>(context);

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;
            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: activeCheckBoxColor,
                        checkColor: checkColor,
                        value: utilisateur.objectifs['hasobjTemps'],
                        onChanged: (val) {
                          setState(() {
                            DatabaseService(uid: utilisateur.uid).updateUser(
                              email: utilisateur.email,
                              name: utilisateur.name,
                              objectifs: {
                                'hasobjDistance':
                                    utilisateur.objectifs['hasobjDistance'],
                                'hasobjTemps': val,
                                'objDistance':
                                    utilisateur.objectifs['objDistance'],
                                'objTemps': utilisateur.objectifs['objTemps'],
                              },
                            );
                          });
                        },
                      ),
                      Text("Objectifs de temps"),
                    ],
                  ),
                  Visibility(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_bike),
                            Text("Temps de l'entrainement: "),
                            ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                  color: buttonColor,
                                  onPressed: () =>
                                      _creePaneauxObjectifs('velo'),
                                  child: Text(
                                    "${(utilisateur.objectifs['objTemps']['velo'] / 60).floor()} h ${(utilisateur.objectifs['objTemps']['velo'] % 60)} m",
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_run),
                            Text("Temps de l'entrainement: "),
                            ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                  color: buttonColor,
                                  onPressed: () =>
                                      _creePaneauxObjectifs('course'),
                                  child: Text(
                                    "${(utilisateur.objectifs['objTemps']['course'] / 60).floor()} h ${(utilisateur.objectifs['objTemps']['course'] % 60)} m",
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_walk),
                            Text("Temps de l'entrainement: "),
                            ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                  color: buttonColor,
                                  onPressed: () =>
                                      _creePaneauxObjectifs('marche'),
                                  child: Text(
                                    "${(utilisateur.objectifs['objTemps']['marche'] / 60).floor()} h ${(utilisateur.objectifs['objTemps']['marche'] % 60)} m",
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    visible: utilisateur.objectifs['hasobjTemps'],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  void _creePaneauxObjectifs(String sport) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
            child: FormObjectifTemps(sport),
          );
        });
  }
}
