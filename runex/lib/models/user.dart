import 'package:flutter/widgets.dart';

class Utilisateur with ChangeNotifier {

  final String uid;
  final String name;
  final String email;
  final String password;

  Utilisateur({this.email, this.password, this.uid, this.name});
}
