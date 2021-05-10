import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
