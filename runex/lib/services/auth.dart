import 'package:runex/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Utilisateur> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(currentUser.uid == user.uid);

    return _userFromFirebaseUser(user);
  }

  Future signOutGoogle() async {
    return await googleSignIn.signOut();
  }

  // create user obj based on FirebaseUser
  Utilisateur _userFromFirebaseUser(User user) {
    return user != null
        ? Utilisateur(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  // auth change user stream
  Stream<Utilisateur> get utilisateur {
    _auth.authStateChanges();
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      print(user.displayName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      int index = email.indexOf('@');
      String name = email.substring(0, index);

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUser(name: name, email: email, password: password);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signOutEmailAndPassword() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    if (_auth.currentUser == null) {
      await signOutGoogle();
    } else {
      await signOutEmailAndPassword();
    }
  }
}
