import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class FormObjectifTemps extends StatefulWidget {
  final String sport;
  const FormObjectifTemps(this.sport);
  @override
  _FormObjectifTempsState createState() => _FormObjectifTempsState();
}

class _FormObjectifTempsState extends State<FormObjectifTemps> {
  int _currentHour;
  int _currentMinutes;
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;

            return Column(
              children: <Widget>[
                Text('Heures: '),
                SizedBox(height: 20),
                Slider(
                  value: (_currentHour ??
                          utilisateur.objectifs['objTemps'][widget.sport] / 60)
                      .floor()
                      .toDouble(),
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryLightColor,
                  min: 0.0,
                  max: 20.0,
                  divisions: 19,
                  onChanged: (val) => setState(() {
                    _currentHour = val.round();
                  }),
                ),
                SizedBox(height: 20),
                Text('Minutes: '),
                SizedBox(height: 20),
                Slider(
                  value: (_currentMinutes ??
                          utilisateur.objectifs['objTemps'][widget.sport] % 60)
                      .toDouble(),
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryLightColor,
                  min: 0.0,
                  max: 59.0,
                  divisions: 58,
                  onChanged: (val) => setState(() {
                    _currentMinutes = val.round();
                  }),
                ),
                Expanded(
                    child: Text(
                        '${_currentHour ?? (utilisateur.objectifs['objTemps'][widget.sport] / 60).floor()} heures et ${_currentMinutes ?? (utilisateur.objectifs['objTemps'][widget.sport] % 60)} minutes')),
                RaisedButton(
                    color: kPrimaryColor,
                    child: Text(
                      'Sauvegarder',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Map newObj = utilisateur.objectifs;

                      newObj['objTemps'][widget.sport] = (_currentHour ??
                                  (utilisateur.objectifs['objTemps']
                                              [widget.sport] /
                                          60)
                                      .floor()) *
                              60 +
                          (_currentMinutes ??
                              (utilisateur.objectifs['objTemps'][widget.sport] %
                                  60));
                      await DatabaseService(uid: utilisateur.uid).updateUser(
                          utilisateur: utilisateur,
                          email: utilisateur.email,
                          name: utilisateur.name,
                          objectifs: newObj,
                          profilePicURL: utilisateur.profilePicURL,
                          usesDarkTheme: utilisateur.usesDarkTheme);
                      Navigator.pop(context);
                    }),
              ],
            );
          } else {
            return Scaffold();
          }
        });
  }
}
