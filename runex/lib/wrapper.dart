import 'package:runex/Screens/Welcome/welcome_screen.dart';
import 'package:runex/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/navigation_bar.dart';
import 'package:runex/services/database.dart';
import 'components/loading.dart';
import 'components/theme.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    final theme = Provider.of<ThemeChanger>(context);

    if (utilisateur == null) {
      return WelcomeScreen();
    } else {
      return StreamBuilder<Utilisateur>(
          stream: DatabaseService(uid: utilisateur.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              utilisateur = snapshot.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                utilisateur.usesDarkTheme
                    ? theme.setTheme(theme.darkTheme)
                    : theme.setTheme(theme.lightTheme);
              });


              return Nav();
            } else {
              print(utilisateur.uid);
              return Loading();
            }
          });
    }
  }
}
