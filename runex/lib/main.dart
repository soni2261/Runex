import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return StreamProvider<Utilisateur>.value(
      value: AuthService().utilisateur,
      child: MaterialApp(
        title: 'Runex Login',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primaryColor: kPrimaryColor,
        //   scaffoldBackgroundColor: Colors.white,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: Wrapper(),
      ),
    );
    //home: Profil()); //DECOMMENTER QUAND ON VEUT TESTER PROFIL SEULEMENT
  }
}

