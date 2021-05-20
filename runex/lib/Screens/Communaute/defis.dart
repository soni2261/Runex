import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/models/user.dart';
import 'package:runex/services/database.dart';

class Defis extends StatefulWidget {
  @override
  _DefisState createState() => _DefisState();
}

class _DefisState extends State<Defis> {
  List defis = [];
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 0,
        ),
        title: Text('Défis'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              DatabaseService(uid: utilisateur.uid).defiCollection.snapshots(),
          builder: (context, defiSnapshot) {
            if (defiSnapshot.hasData) {
              return SingleChildScrollView(
                child: StreamBuilder<Utilisateur>(
                    stream: DatabaseService(uid: utilisateur.uid).userData,
                    builder: (context, snapshot) {
                      utilisateur = snapshot.data;
                      if (defiSnapshot.hasData) {
                        return Column(
                          children: defiSnapshot.data.docs
                              .map<Widget>((element) => creeCarteDeDefi(
                                  element: element, utilisateur: utilisateur))
                              .toList(),
                        );
                      } else {
                        return Loading();
                      }
                    }),
              );
            } else {
              return Loading();
            }
          }),
    );
  }

  Widget creeCarteDeDefi({
    @required QueryDocumentSnapshot element,
    @required Utilisateur utilisateur,
  }) {
    String imageName = element.data()['imageName'];
    String titre = element.data()['title'];
    String description = element.data()['description'];
    bool joint = utilisateur.defis.contains(element.id);
    bool complete = false;

    if (element.data()['typeDefi'] == 'distance') {
      if (utilisateur.statistiques['statsDistance'][element.id]['totale'] >=
          element.data()['condition']) complete = true;
    } else if (element.data()['typeDefi'] == 'temps') {
      if (utilisateur.statistiques['statsTemps'][element.id]['totale'] >=
          element.data()['condition']) complete = true;
    }

    Color couleurBouton;
    String textBouton;
    Color couleurText;

    if (complete) {
      couleurBouton = Colors.lightGreen[800];
      textBouton = 'COMPLÉTÉ';
      couleurText = Colors.white;
    } else if (joint) {
      couleurBouton = Colors.blueGrey[800];
      textBouton = 'JOINT';
      couleurText = Colors.white;
    } else {
      couleurBouton = Colors.amber[300];
      textBouton = 'JOINDRE LE DÉFI';
      couleurText = Colors.black;
    }

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            utilisateur = snapshot.data;
            return Card(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 2),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Ink.image(
                        image: AssetImage('assets/images/$imageName.jpg'),
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          titre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16).copyWith(bottom: 5),
                    child: Text(
                      description,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      textBouton,
                      style: TextStyle(
                          color: couleurText, fontWeight: FontWeight.w700),
                    ),
                    color: couleurBouton,
                    onPressed: () {
                      if (!joint && !complete) {
                        DatabaseService(uid: utilisateur.uid).addDefi(
                            defiId: element.id, utilisateur: utilisateur);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
        });
  }
}
