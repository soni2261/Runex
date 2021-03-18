import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreerObjectif extends StatefulWidget {
  @override
  _CreerObjectifState createState() => _CreerObjectifState();
}

class _CreerObjectifState extends State<CreerObjectif> {
  bool veutObjectifTemps = false;
  bool veutObjectifDistance = false;
  String typeObjectif;
  String uniteObjectif;

  double _firstCurrentDoubleValue = 0.0;
  double _secondCurrentDoubleValue = 0.0;
  double _thirdCurrentDoubleValue = 0.0;

  int currentButton = 1;

  NumberPicker decimalNumberPicker;

  Widget build(BuildContext context) {
    _initializeNumberPickers();
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

  // Widget _buildDropDownList() {
  //   String dropdownValue = 'Three';

  //   return DropDownButton<String>(
  //     value
  //   );
  // }

  void _initializeNumberPickers() {
    decimalNumberPicker = new NumberPicker.decimal(
      initialValue: _firstCurrentDoubleValue,
      minValue: 0,
      maxValue: 12,
      decimalPlaces: 2,
      onChanged: (value) => setState(() => _firstCurrentDoubleValue = value),
    );
  }

  Future _showDoubleDialog(int currentButton) async {
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 0,
          maxValue: 12,
          decimalPlaces: 2,
          initialDoubleValue: _firstCurrentDoubleValue,
          title: new Text("Duree de l'entrainement"),
        );
      },
    ).then((num value) {
      if (value != null) {
        if (currentButton == 1) {
          setState(() => _firstCurrentDoubleValue = value);
        } else if (currentButton == 2) {
          setState(() => _secondCurrentDoubleValue = value);
        } else if (currentButton == 3) {
          setState(() => _thirdCurrentDoubleValue = value);
        }
      }
    });
  }

  Widget _buildCarteObjectif(String typeObjectif) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: veutObjectif(typeObjectif),
                onChanged: (bool value) {
                  setState(() {
                    if (typeObjectif == "temps") {
                      veutObjectifTemps = value;
                    } else if (typeObjectif == "distance") {
                      veutObjectifDistance = value;
                    }
                  });
                },
              ),
              Text('objectif de $typeObjectif'),
            ],
          ),
          Visibility(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_bike),
                    Text("durée de l'entrainement: "),
                    RaisedButton(
                      onPressed: () => _showDoubleDialog(1),
                      child: Text("$_firstCurrentDoubleValue h"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_run),
                    Text("durée de l'entrainement: "),
                    RaisedButton(
                      onPressed: () => _showDoubleDialog(2),
                      child: Text("$_secondCurrentDoubleValue h"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.directions_walk),
                    Text("durée de l'entrainement: "),
                    RaisedButton(
                      onPressed: () => _showDoubleDialog(3),
                      child: Text("$_thirdCurrentDoubleValue h"),
                    ),
                  ],
                ),
              ],
            ),
            visible: veutObjectif(typeObjectif), //veutObjectifTemps,
          ),
        ],
      ),
    );
  }

  bool veutObjectif(String typeObjectif) {
    if (typeObjectif == "temps") {
      return veutObjectifTemps;
    } else if (typeObjectif == "distance") {
      return veutObjectifDistance;
    } else {
      return false;
    }
  }

  String uniteDeObjectif(String typeObjectif){
    if (typeObjectif == "temps") {
      return "h";
    } else if (typeObjectif == "distance") {
      return "km";
    } else {
      return "h";
    }
  }
}
