import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';
import 'form_objectif_distance.dart';

class CarteObjectifDistance extends StatefulWidget {
  @override
  _CarteObjectifDistanceState createState() => _CarteObjectifDistanceState();
}

class _CarteObjectifDistanceState extends State<CarteObjectifDistance> {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;
            return Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: kPrimaryColor,
                        value: utilisateur.objectifs['hasobjDistance'],
                        onChanged: (val) {
                          setState(() {
                            DatabaseService(uid: utilisateur.uid).updateUser(
                              email: utilisateur.email,
                              name: utilisateur.name,
                              objectifs: {
                                'hasobjDistance': val,
                                'hasobjTemps':
                                    utilisateur.objectifs['hasobjTemps'],
                                'objDistance':
                                    utilisateur.objectifs['objDistance'],
                                'objTemps': utilisateur.objectifs['objTemps'],
                              },
                            );
                          });
                        },
                      ),
                      Text("Objectifs de distance"),
                    ],
                  ),
                  Visibility(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_bike),
                            Text("Distance de l'entrainement: "),
                            ButtonTheme(
                              minWidth: 100,
                              child: RaisedButton(
                                color: kPrimaryLightColor,
                                onPressed: () => _creePaneauxObjectifs('velo'),
                                child: Text(
                                    "${utilisateur.objectifs['objDistance']['velo']} km"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_run),
                            Text("Distance de l'entrainement: "),
                            ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                  color: kPrimaryLightColor,
                                  onPressed: () =>
                                      _creePaneauxObjectifs('course'),
                                  child: Text(
                                    "${utilisateur.objectifs['objDistance']['course']} km",
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.directions_walk),
                            Text("Distance de l'entrainement: "),
                            ButtonTheme(
                                minWidth: 100,
                                child: RaisedButton(
                                  color: kPrimaryLightColor,
                                  onPressed: () =>
                                      _creePaneauxObjectifs('marche'),
                                  child: Text(
                                      "${utilisateur.objectifs['objDistance']['marche']} km"),
                                )),
                          ],
                        ),
                      ],
                    ),
                    visible: utilisateur.objectifs['hasobjDistance'],
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
            child: FormObjectifDistance(sport),
          );
        });
  }
}