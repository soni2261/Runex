import 'package:flutter/material.dart';
import 'package:runex/Screens/Communaute/communaute.dart';
import 'package:runex/Screens/MonEspace/profil.dart';
import 'package:runex/Screens/Carte/carte.dart';

import 'constants.dart';

class Nav extends StatefulWidget {
  const Nav();
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 2;
  void onNavTap(index) {
    setState(() {
      if (index != 1) {
        _selectedIndex = index;
      } else {
       Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Carte(),
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List listePages = [Communaute(), Carte(), Profil()];
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: listePages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTap,
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Communauté'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Carte'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Mon Espace'),
        ],
      ),
    );
  }
}
