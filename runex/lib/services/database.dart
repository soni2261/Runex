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
      List historique,
      bool usesDarkTheme,
      String profilePicURL}) async {
    if (utilisateur != null) {
      if (email == null || email == "") email = utilisateur.email;
      if (name == null || name == "") name = utilisateur.name;
      if (objectifs == null || objectifs == {})
        objectifs = utilisateur.objectifs;
      if (statistiques == null || statistiques == {})
        statistiques = utilisateur.statistiques;
      if (historique == null || historique == [])
        historique = utilisateur.historique;
      if (usesDarkTheme == null) usesDarkTheme = utilisateur.usesDarkTheme;
      if (profilePicURL == null) profilePicURL = utilisateur.profilePicURL;
    }
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'objectifs': objectifs,
      'statistiques': statistiques,
      'historique': historique,
      'usesDarkTheme': usesDarkTheme,
      'profilePicURL': profilePicURL
    });
  }

  Future addHistorique({
    @required Map historiqueItem,
    @required Utilisateur utilisateur,
  }) async {
    List historique = utilisateur.historique;
    historique.add(historiqueItem);

    return await userCollection.doc(uid).set({
      'name': utilisateur.name,
      'email': utilisateur.email,
      'objectifs': utilisateur.objectifs,
      'statistiques': utilisateur.statistiques,
      'historique': historique,
      'usesDarkTheme': utilisateur.usesDarkTheme,
      'profilePicURL': utilisateur.profilePicURL
    });
  }

  Future checkStatsWeek(Utilisateur utilisateur) async {
    dynamic now = new DateTime.now();
    now = new DateTime(now.year, now.month, now.day, 0, 0, 0);
    dynamic currentDebut;

    if (now.weekday == DateTime.monday) {
      currentDebut = now;
    } else {
      int daysSinceMonday = now.weekday - 1;
      currentDebut = now.subtract(new Duration(days: daysSinceMonday));
    }
    dynamic databaseDebut = DateTime.fromMicrosecondsSinceEpoch(
        utilisateur.statistiques['debut'].microsecondsSinceEpoch);

    Map newStats;
    if (currentDebut.isAtSameMomentAs(databaseDebut)) {
      return;
    }
    newStats = utilisateur.statistiques;
    newStats['debut'] = currentDebut;
    await updateUser(
      utilisateur: utilisateur,
      statistiques: newStats,
    );
  }

  Utilisateur _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Utilisateur(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      password: snapshot.data()['password'],
      objectifs: snapshot.data()['objectifs'],
      statistiques: snapshot.data()['statistiques'],
      historique: snapshot.data()['historique'],
      usesDarkTheme: snapshot.data()['usesDarkTheme'],
      profilePicURL: snapshot.data()['profilePicURL'],
    );
  }

  Stream<Utilisateur> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
