import 'package:runex/Screens/Welcome/welcome_screen.dart';
import 'package:runex/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/navigation_bar.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);

    if (utilisateur == null) {
      return WelcomeScreen();
    } else {
      return Nav();
    }
  }
}
