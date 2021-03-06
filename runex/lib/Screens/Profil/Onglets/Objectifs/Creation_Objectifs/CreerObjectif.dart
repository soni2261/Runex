import 'package:flutter/material.dart';

class CreerObjectif extends StatefulWidget {
  @override
  _CreerObjectifState createState() => _CreerObjectifState();
}

class _CreerObjectifState extends State<CreerObjectif> {
  bool veutObjectifTemps = false;
  int nbListeSport = 10;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Modification des objectifs')),
        body: Container(
          child: Column(
            children: [
              _buildCarteObjectif(),
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

  Widget _buildCarteObjectif() {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: veutObjectifTemps,
                onChanged: (bool value) {
                  setState(() {
                    veutObjectifTemps = value;
                  });
                },
              ),
              Text('objectif de temps'),
            ],
          ),
          Visibility(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_bike),
                    Text('3h30'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.directions_run),
                    Text('2h40'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.directions_walk),
                    Text('2h40'),
                  ],
                ),
              ],
            ),
            visible: veutObjectifTemps, //veutObjectifTemps,
          ),
        ],
      ),
    );
  }
}
