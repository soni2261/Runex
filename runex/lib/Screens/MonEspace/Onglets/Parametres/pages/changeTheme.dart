import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    Size size = MediaQuery.of(context).size;
    ThemeChanger theme = Provider.of<ThemeChanger>(context);

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text("Changer le theme"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          await DatabaseService(uid: utilisateur.uid)
                              .updateUser(
                                  utilisateur: utilisateur,
                                  name: utilisateur.name,
                                  email: utilisateur.email,
                                  objectifs: utilisateur.objectifs,
                                  profilePicURL: utilisateur.profilePicURL,
                                  usesDarkTheme: !utilisateur.usesDarkTheme);
                          theme.setTheme(theme.isDark()
                              ? theme.lightTheme
                              : theme.darkTheme);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 0,
                                  color: Color.fromRGBO(217, 205, 0, 1),
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/daynight.svg",
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Changer le theme",
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
