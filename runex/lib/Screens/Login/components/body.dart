import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runex/Screens/Login/components/background.dart';
import 'package:runex/Screens/Login/components/social_icon.dart';
import 'package:runex/Screens/SignUp/signup_screen.dart';
import 'package:runex/components/already_have_an_account_check.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:runex/components/rounded_input_field.dart';
import 'package:runex/components/rounded_password_field.dart';
import 'package:runex/services/auth.dart';
import 'package:runex/navigation_bar.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // textfield state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                          imageSrc: "assets/icons/google.svg",
                          press: () async {
                            await _authService.signInWithGoogle().then((user) {
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Nav()));
                              } else {
                                print('What');
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SocialIcon(
                          imageSrc: "assets/icons/facebook.svg",
                          press: () {
                            print("Facebook pressed");
                          },
                        ),
                      ],
                    ),
                    OrDivider(),
                    RoundedInputField(
                      hintText: "Enter your email",
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validationText: 'Enter an email',
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validationText:
                          'Enter a password longer than 6 characters',
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _authService
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUpScreen();
                        }));
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red[700]),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
