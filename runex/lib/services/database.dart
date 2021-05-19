import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:runex/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference defiCollection =
      FirebaseFirestore.instance.collection('defis');

  void supprimerUtilisateur() {
    try {
      userCollection.doc(uid).delete();
    } catch (e) {}
  }

  Future updateUser({
    @required Utilisateur utilisateur,
    String email,
    String name,
    Map objectifs,
    Map statistiques,
    List historique,
    bool usesDarkTheme,
    String profilePicURL,
    List defis,
  }) async {
    print(historique);
    if (utilisateur != null) {
      if (email == null || email == "") {
        email = utilisateur.email;
      }
      if (name == null || name == "") {
        name = utilisateur.name;
      }

      if (objectifs == null) {
        objectifs = utilisateur.objectifs;
      }

      if (statistiques == null) {
        statistiques = utilisateur.statistiques;
      }

      if (historique == null) {
        historique = utilisateur.historique;
      }

      if (usesDarkTheme == null) {
        usesDarkTheme = utilisateur.usesDarkTheme;
      }

      if (profilePicURL == null || profilePicURL == '') {
        profilePicURL = utilisateur.profilePicURL;
      }

      if (defis == null) {
        defis = utilisateur.defis;
      }
    }

    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'objectifs': objectifs,
      'statistiques': statistiques,
      'historique': historique,
      'usesDarkTheme': usesDarkTheme,
      'profilePicURL': profilePicURL,
      'defis': defis,
    });
  }

  Future addHistoriqueEtStats({
    @required Map historiqueItem,
    @required Utilisateur utilisateur,
  }) async {
    if (utilisateur == null) return;
    List historique = [];
    if (utilisateur.historique != null && utilisateur.historique != []) {
      utilisateur.historique.forEach((element) {
        historique.add(element);
      });
    }
    historique.add(historiqueItem);

    // await addStat(historiqueItem: historiqueItem, utilisateur: utilisateur);
    Map statistiques = utilisateur.statistiques;

    if (historiqueItem['duree'] != 0) {
      statistiques['hasStatistiquesTemps'] = true;
      statistiques['statsTemps'][historiqueItem['sport']]['totale'] +=
          historiqueItem['duree'];
      DateTime maintenant = DateTime.now();
      statistiques['statsTemps'][historiqueItem['sport']]['statsSemaine']
          [maintenant.weekday - 1] += historiqueItem['duree'];
    }

    if (historiqueItem['distance'] != 0) {
      statistiques['hasStatistiquesDistance'] = true;
      statistiques['statsDistance'][historiqueItem['sport']]['totale'] +=
          historiqueItem['distance'];
      DateTime maintenant = DateTime.now();
      statistiques['statsDistance'][historiqueItem['sport']]['statsSemaine']
          [maintenant.weekday - 1] += historiqueItem['distance'];
    }

    await updateUser(
        utilisateur: utilisateur,
        historique: historique,
        statistiques: statistiques);
  }

  Future addStat({
    @required Map historiqueItem,
    @required Utilisateur utilisateur,
  }) async {
    if (utilisateur == null) return;
    Map statistiques = utilisateur.statistiques;

    if (historiqueItem['duree'] != 0) {
      statistiques['hasStatistiquesTemps'] = true;
      statistiques['statsTemps'][historiqueItem['sport']]['totale'] +=
          historiqueItem['duree'];
      DateTime maintenant = DateTime.now();
      statistiques['statsTemps'][historiqueItem['sport']]['statsSemaine']
          [maintenant.weekday - 1] += historiqueItem['duree'];
    }

    if (historiqueItem['distance'] != 0) {
      statistiques['hasStatistiquesDistance'] = true;
      statistiques['statsDistance'][historiqueItem['sport']]['totale'] +=
          historiqueItem['distance'];
      DateTime maintenant = DateTime.now();
      statistiques['statsDistance'][historiqueItem['sport']]['statsSemaine']
          [maintenant.weekday - 1] += historiqueItem['distance'];
    }

    await updateUser(utilisateur: utilisateur, statistiques: statistiques);
  }

  Future addDefi({
    @required String defiId,
    @required Utilisateur utilisateur,
  }) async {
    if (utilisateur == null) return;
    List defis = [];
    if (utilisateur.defis != null && utilisateur.defis != []) {
      utilisateur.defis.forEach((element) {
        defis.add(element);
      });
    }
    if (!defis.contains(defiId))
      defis.add(defiId);
    else
      return;
    await updateUser(utilisateur: utilisateur, defis: defis);
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

    if (currentDebut.isAtSameMomentAs(databaseDebut)) return;

    DateTime end = currentDebut.add(Duration(days: 6));

    Map newStats = {
      'debut': currentDebut,
      'end': end,
      'hasStatistiquesDistance': false,
      'hasStatistiquesTemps': false,
      'statsDistance': {
        'marche': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
        'course': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
        'velo': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
      },
      'statsTemps': {
        'marche': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
        'course': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
        'velo': {
          'totale': 0,
          'statsSemaine': [0, 0, 0, 0, 0, 0, 0]
        },
      },
    };
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
      defis: snapshot.data()['defis'],
    );
  }

  Stream<Utilisateur> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
