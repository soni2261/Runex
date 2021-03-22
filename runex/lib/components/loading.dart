import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runex/components/loading_background.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingBackground(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(
          "assets/images/loading.svg",
          width: size.width * 0.8,
        ),
        SizedBox(
          height: 30,
        ),
        SpinKitPumpingHeart(
          color: Colors.pinkAccent[700],
          size: 70,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "LOADING...",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Caveat',
          ),
        )
      ]),
    );
  }
}
