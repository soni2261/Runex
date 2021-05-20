import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/pages/changeAvatar.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/pages/changePassword.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/pages/changeTheme.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/parametreItem.dart';
import 'package:runex/Screens/MonEspace/Onglets/Statistiques/stats_complet.dart';
import 'package:runex/Screens/Welcome/welcome_screen.dart';
import 'package:runex/constants.dart';
import 'package:runex/services/auth.dart';
import 'package:runex/services/database.dart';

class Parametres extends StatefulWidget {
  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    List elements = [
      ParametreItem(
          title: "Changer l'image du profil",
          icon: Icon(Icons.image_outlined),
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeAvatar()),
            );
          }),
      ParametreItem(
          title: "Changer le mot de passe",
          icon: Icon(Icons.lock),
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePassword()),
            );
          }),
      ParametreItem(
          title: "Changer le theme",
          icon: Icon(Icons.wb_sunny_outlined),
          press: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChangeTheme()));
          }),
      ParametreItem(
          title: "Déconnexion",
          icon: Icon(Icons.logout),
          press: () async {
            await _auth.signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WelcomeScreen()));
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: ListTile(
              onTap: elements[index].press,
              title: Text(elements[index].title),
              leading: elements[index].icon,
            ),
          );
        },
      ),
    );
  }
}
