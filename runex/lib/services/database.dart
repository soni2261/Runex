import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/MonEspace/Onglets/Objectifs/objectifs.dart';
import 'package:runex/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUser(
      {@required Utilisateur utilisateur,
      String email,
      String name,
      Map objectifs,
      Map statistiques,
      bool usesDarkTheme,
      String profilePicURL}) async {
    if (utilisateur != null) {
      if (email == null || email == "") email = utilisateur.email;
      if (name == null || name == "") name = utilisateur.name;
      if (objectifs == null || objectifs == {})
        objectifs = utilisateur.objectifs;
      if (statistiques == null || statistiques == {})
        statistiques = utilisateur.statistiques;
      if (usesDarkTheme == null) usesDarkTheme = utilisateur.usesDarkTheme;
      if (profilePicURL == null) profilePicURL = utilisateur.profilePicURL;
    }
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'objectifs': objectifs,
      'statistiques' : statistiques,
      'usesDarkTheme': usesDarkTheme,
      'profilePicURL': profilePicURL
    });
  }

  Utilisateur _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Utilisateur(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      password: snapshot.data()['password'],
      objectifs: snapshot.data()['objectifs'],
      statistiques: snapshot.data()['statistiques'],
      usesDarkTheme: snapshot.data()['usesDarkTheme'],
      profilePicURL: snapshot.data()['profilePicURL'],
    );
  }

  Stream<Utilisateur> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
