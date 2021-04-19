import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:runex/constants.dart';
import 'package:runex/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:runex/components/theme.dart';

class ChangeAvatar extends StatefulWidget {
  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  String imageUrl = "https://flutter.dev/images/cookbook/network-image.png";
  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeChanger>(context);
    Size size = MediaQuery.of(context).size;

    // double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(
        title: Text("Changer l'image du profil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(bottom: defaultSize),
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
                  image: NetworkImage(imageUrl),
                  // AssetImage("assets/images/vangogh.png"),
                ),
              ),
            ),
            FlatButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text("press me plz"))
          ],
        ),
      ),
    );
  }

  void uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();
    print("hey yo");

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        // Upload to Firebase
        var snapshot = await _storage
            .ref()
            .child('Profile pictures/default-avatar')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl.toString();
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
