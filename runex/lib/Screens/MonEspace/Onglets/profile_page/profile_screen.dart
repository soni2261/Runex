import 'package:flutter/material.dart';
import 'package:runex/Screens/MonEspace/Onglets/profile_page/body.dart';
import 'package:runex/sizeconfig.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
