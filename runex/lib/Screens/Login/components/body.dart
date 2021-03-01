import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runex/Screens/Login/components/background.dart';
import 'package:runex/Screens/Login/components/social_icon.dart';
import 'package:runex/Screens/SignUp/signup_screen.dart';
import 'package:runex/components/already_have_an_account_check.dart';
import 'package:runex/components/rounded_button.dart';
import 'package:runex/components/rounded_input_field.dart';
import 'package:runex/components/rounded_password_field.dart';
import 'package:runex/navigation_bar.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * .3,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  imageSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                SocialIcon(
                  imageSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
              ],
            ),
            OrDivider(),
            RoundedInputField(
              hintText: "Enter your email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Nav();
                  },
                ));
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
