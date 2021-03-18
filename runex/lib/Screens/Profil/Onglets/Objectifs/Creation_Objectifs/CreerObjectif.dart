import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreerObjectif extends StatefulWidget {
  @override
  _CreerObjectifState createState() => _CreerObjectifState();
}

class _CreerObjectifState extends State<CreerObjectif> {
  bool _veutObjectifTemps = false;
  bool _veutObjectifDistance = false;
  String _typeObjectif = "";

  bool premiereCarte = true;
  int _numeroBouton = 0;

  //initialisation du data a 0
  List<double> _timeValues = [0.0, 0.0, 0.0];
  List<double> _distanceValues = [0.0, 0.0, 0.0];


  NumberPicker decimalNumberPicker;

  Widget build(BuildContext context) {
    _initializeNumberPickers(_typeObjectif, _numeroBouton);
    return Scaffold(
        appBar: AppBar(title: Text('Modification des objectifs')),
        body: Container(
          child: Column(
            children: [
              _buildCarteObjectif("temps"),
              _buildCarteObjectif("distance"),
            ],
          ),
        ));
  }

  void _initializeNumberPickers(String _typeObjectif, int _numeroBouton) {
    decimalNumberPicker = new NumberPicker.decimal(
        initialValue: 0.0,
        minValue: 0,
        maxValue: 12,
        decimalPlaces: 2,
        onChanged: (value) {
          if (_typeObjectif == "temps") {
            setState(() => _timeValues[_numeroBouton] = value);
          } else if (_typeObjectif == "distance") {
            setState(() => _distanceValues[_numeroBouton] = value);
          }
        });
  }

  Future _showDoubleDialog(String _typeObjectif, int _numeroBouton) async {
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 0,
          maxValue: 12,
          decimalPlaces: 2,
          initialDoubleValue: 0.0,
          title: new Text("$_typeObjectif de l'entrainement"),
        );
      },
    ).then((num value) {
      if (value != null) {
        if (_typeObjectif == "temps") {
          setState(() => _timeValues[_numeroBouton] = value);
        } else if (_typeObjectif == "distance") {
          setState(() => _distanceValues[_numeroBouton] = value);
        }
      }
    });
  }

  Widget _buildCarteObjectif(String _typeObjectif) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: veutObjectif(_typeObjectif),
                onChanged: (bool value) {
                  setState(() {
                    if (_typeObjectif == "temps") {
                      _veutObjectifTemps = value;
                    } else if (_typeObjectif == "distance") {
                      _veutObjectifDistance = value;
                    }
                  });
                },
              ),
              Text('objectif de $_typeObjectif'),
            ],
          ),
          Visibility(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_bike),
                    Text("$_typeObjectif de l'entrainement: "),
                    RaisedButton(
                      onPressed: () {
                        _numeroBouton = 0;
                        _showDoubleDialog(_typeObjectif, _numeroBouton);
                      },
                      child: Visibility(
                        child: Text(_timeValues.elementAt(0).toString()),
                        visible:
                            premiereCarte, //seul probleme: l'affichage des textes car j'utilise la liste timeValues seulement
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_run),
                    Text("$_typeObjectif de l'entrainement: "),
                    RaisedButton(
                      onPressed: () {
                        _numeroBouton = 1;
                        _showDoubleDialog(_typeObjectif, _numeroBouton);
                      },
                      child: Text(_timeValues.elementAt(1).toString()),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_walk),
                    Text("$_typeObjectif de l'entrainement: "),
                    RaisedButton(
                      onPressed: () {
                        _numeroBouton = 2;
                        _showDoubleDialog(_typeObjectif, _numeroBouton);
                      },
                      child: Text(_timeValues.elementAt(2).toString()),
                    ),
                  ],
                ),
              ],
            ),
            visible: veutObjectif(_typeObjectif), //_veutObjectifTemps,
          ),
        ],
      ),
    );
  }

  bool veutObjectif(String _typeObjectif) {
    if (_typeObjectif == "temps") {
      return _veutObjectifTemps;
    } else if (_typeObjectif == "distance") {
      return _veutObjectifDistance;
    } else {
      return false;
    }
  }
}
