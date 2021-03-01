import 'package:flutter/material.dart';

import 'constants.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  void onNavTap(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Text('Home'),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTap,
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}
