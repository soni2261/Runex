import 'package:flutter/material.dart';
import 'Profil/profil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Runex Login',
        debugShowCheckedModeBanner: false,
        home: Profil());
  }
}
