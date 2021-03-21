import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/Parametres/parametreItem.dart';
import 'package:runex/Screens/Welcome/welcome_screen.dart';
import 'package:runex/services/auth.dart';

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
          title: "Sign Out",
          icon: Icon(Icons.logout),
          press: () async {
            await _auth.signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WelcomeScreen()));
          })
    ];

    return Scaffold(
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
