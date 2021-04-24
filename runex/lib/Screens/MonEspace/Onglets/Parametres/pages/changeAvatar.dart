import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:runex/services/database.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:provider/provider.dart';
import 'package:runex/models/user.dart';
import 'package:runex/components/loading.dart';

dynamic image = AssetImage("assets/images/default-avatar.jpg");

class ChangeAvatar extends StatefulWidget {
  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  @override
  Widget build(BuildContext context) {
    Utilisateur utilisateur = Provider.of<Utilisateur>(context);
    Size size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImage(utilisateur);
    });

    return StreamBuilder<Utilisateur>(
        stream: DatabaseService(uid: utilisateur.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            utilisateur = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text("Changer l'image du profil"),
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.6,
                      height: size.height * 0.6,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: image,
                        ),
                      ),
                    ),
                    RoundedButton(
                      text: "CHANGE AVATAR",
                      press: () {
                        uploadImage(utilisateur: utilisateur);
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Future getImage(Utilisateur utilisateur) async {
    final _storage = FirebaseStorage.instance;
    String url;
    try {
      url = await _storage
          .ref()
          .child('Profile pictures/${utilisateur.uid}')
          .getDownloadURL();
    } catch (e) {
      return;
    }
    setState(() {
      image = NetworkImage(url);
    });
  }

  void uploadImage({Utilisateur utilisateur}) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);

      var file = File(image.path);

      if (image != null) {
        // Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('Profile pictures/${utilisateur.uid}')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() async {
          await DatabaseService(uid: utilisateur.uid).updateUser(
            name: utilisateur.name,
            email: utilisateur.email,
            objectifs: utilisateur.objectifs,
            usesDarkTheme: utilisateur.usesDarkTheme,
            profilePicURL: downloadUrl.toString(),
          );
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
