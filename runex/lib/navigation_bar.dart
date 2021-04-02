import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/Communaute/communaute.dart';
import 'package:runex/Screens/MonEspace/profil.dart';

import 'components/theme.dart';
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
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Color selectedItemColor =
        theme.isDark() ? kPrimaryLightColor : kPrimaryColor;
    Color unSelectedItemColor = theme.isDark()
        ? Color.fromRGBO(191, 189, 195, 1)
        : Color.fromRGBO(115, 115, 115, 1);
    Color navBackgroundColor = theme.isDark()
        ? Color.fromRGBO(40, 35, 55, 1)
        : Color.fromRGBO(250, 250, 250, 1);

    List listePages = [Communaute(), Communaute(), Profil()];
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: listePages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: navBackgroundColor,
        onTap: onNavTap,
        currentIndex: _selectedIndex,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unSelectedItemColor,
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
