import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class FormObjectifDistance extends StatefulWidget {
  final String sport;
  const FormObjectifDistance(this.sport);
  @override
  _FormObjectifDistanceState createState() => _FormObjectifDistanceState();
}

class _FormObjectifDistanceState extends State<FormObjectifDistance> {
  int _currentDistance;
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
                Text('Distance en km: '),
                SizedBox(height: 20),
                Slider(
                  value: (_currentDistance ??
                          utilisateur.objectifs['objDistance'][widget.sport])
                      .toDouble(),
                  activeColor: kPrimaryColor,
                  inactiveColor: kPrimaryLightColor,
                  min: 0.0,
                  max: 25.0,
                  divisions: 24,
                  onChanged: (val) => setState(() {
                    _currentDistance = val.round();
                  }),
                ),
                Expanded(
                    child: Text(
                        '${_currentDistance ?? utilisateur.objectifs['objDistance'][widget.sport]} km')),
                RaisedButton(
                    color: kPrimaryColor,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Map newObj = utilisateur.objectifs;
                      newObj['objDistance'][widget.sport] = _currentDistance;
                      await DatabaseService(uid: utilisateur.uid).updateUser(
                          email: utilisateur.email,
                          name: utilisateur.name,
                          objectifs: newObj);
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
