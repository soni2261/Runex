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

  ListView _buildListView() {
    return ListView.builder(
      itemCount: nbListeSport,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('The list item #$index'),
          leading: Icon(Icons.delete_outline),
        );
      }, //context, which we dont need to specify, and index
    );
  }

  // Widget _buildDropDownList(){
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
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
                Text('ajouter un sport'),
              ],
            ),
            visible: veutObjectifTemps, //veutObjectifTemps,
          ),
          Visibility(
            child: Container(
              height: 200,
              child: _buildListView(),
            ),
            visible: veutObjectifTemps,
          ),
        ],
      ),
    );
  }
}
