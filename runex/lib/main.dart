import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';
import 'package:runex/services/auth.dart';
import 'package:runex/wrapper.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//s
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: MaterialAppWithTheme(),
    );
    //home: Profil()); //DECOMMENTER QUAND ON VEUT TESTER PROFIL SEULEMENT
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return StreamProvider<Utilisateur>.value(
      value: AuthService().utilisateur,
      child: MaterialApp(
        title: 'Runex Login',
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: Wrapper(),
      ),
    );
  }
}
