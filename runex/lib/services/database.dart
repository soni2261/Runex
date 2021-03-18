import 'package:runex/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUser({String email, String password, String name}) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'email': email, 'password': password});
  }

  Utilisateur _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Utilisateur(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      password: snapshot.data()['password'],
    );
  }

  Stream<Utilisateur> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
