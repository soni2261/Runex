import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/MonEspace/Onglets/Objectifs/Creation_Objectifs/carte_objectif_temps.dart';
import 'package:runex/constants.dart';
import 'package:runex/models/user.dart';
import 'carte_objectif_distance.dart';

class CreerObjectif extends StatefulWidget {
  @override
  _CreerObjectifState createState() => _CreerObjectifState();
}

class _CreerObjectifState extends State<CreerObjectif> {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification des objectifs'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          CarteObjectifDistance(),
          CarteObjectifTemps(),
        ],
      ),
    );
  }
}

Widget _buildCarteObjectifTemps() {
  return Card();
}
// class CreerObjectif2 extends StatefulWidget {
//   @override
//   _CreerObjectif2State createState() => _CreerObjectif2State();
// }

// class _CreerObjectif2State extends State<CreerObjectif2> {
//   bool veutObjectifTemps = false;
//   bool veutObjectifDistance = false;
//   String typeObjectif;
//   String uniteObjectif;

//   double _firstCurrentDoubleValue = 0.0;
//   double _secondCurrentDoubleValue = 0.0;
//   double _thirdCurrentDoubleValue = 0.0;

//   int currentButton = 1;

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Modification des objectifs')),
//         body: Container(
//           child: Column(
//             children: [
//               _buildCarteObjectif("temps"),
//               _buildCarteObjectif("distance"),
//             ],
//           ),
//         ));
//   }

//   void _paneauModificationObjectif(String typeObj, String sport) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
//             child: typeObjectif == "objDistance"
//                 ? FormObjectifDistance(sport)
//                 : FormObjectifTemps(sport),
//           );
//         });
//   }

//   Widget _buildCarteObjectif(String typeObjectif) {
//     return Card(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Checkbox(
//                 value: veutObjectif(typeObjectif),
//                 onChanged: (bool value) {
//                   setState(() {
//                     if (typeObjectif == "temps") {
//                       veutObjectifTemps = value;
//                     } else if (typeObjectif == "distance") {
//                       veutObjectifDistance = value;
//                     }
//                   });
//                 },
//               ),
//               Text('objectif de $typeObjectif'),
//             ],
//           ),
//           Visibility(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Icon(Icons.directions_bike),
//                     Text("durée de l'entrainement: "),
//                     RaisedButton(
//                       onPressed: () => _paneauModificationObjectif(1),
//                       child: Text("$_firstCurrentDoubleValue h"),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Icon(Icons.directions_run),
//                     Text("durée de l'entrainement: "),
//                     RaisedButton(
//                       onPressed: () => _paneauModificationObjectif(2),
//                       child: Text("$_secondCurrentDoubleValue h"),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Icon(Icons.directions_walk),
//                     Text("durée de l'entrainement: "),
//                     RaisedButton(
//                       onPressed: () => _paneauModificationObjectif(3),
//                       child: Text("$_thirdCurrentDoubleValue h"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             visible: veutObjectif(typeObjectif), //veutObjectifTemps,
//           ),
//         ],
//       ),
//     );
//   }

//   bool veutObjectif(String typeObjectif) {
//     if (typeObjectif == "temps") {
//       return veutObjectifTemps;
//     } else if (typeObjectif == "distance") {
//       return veutObjectifDistance;
//     } else {
//       return false;
//     }
//   }

//   String uniteDeObjectif(String typeObjectif) {
//     if (typeObjectif == "temps") {
//       return "h";
//     } else if (typeObjectif == "distance") {
//       return "km";
//     } else {
//       return "h";
//     }
//   }
// }
