import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:runex/Screens/Login/login_screen.dart';
import 'package:runex/Screens/SignUp/components/background.dart';
import 'package:runex/Screens/SignUp/components/social_icon.dart';
import 'package:runex/components/already_have_an_account_check.dart';
import 'package:runex/components/loading.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:runex/components/rounded_input_field.dart';
import 'package:runex/components/rounded_password_field.dart';
import 'package:runex/models/user.dart';
import 'package:runex/navigation_bar.dart';
import 'package:runex/services/auth.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  final Widget child;

  const Body({Key key, @required this.child}) : super(key: key);

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
    final utilisateur = Provider.of<Utilisateur>(context);

    return loading
        ? Loading()
        : utilisateur != null
            ? Nav()
            : Background(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "SIGN UP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        SvgPicture.asset(
                          "assets/icons/signup.svg",
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
                              press: () {
                                _authService.signInWithGoogle().then((user) {
                                  if (user != null) {}
                                });
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
                          text: "SIGN UP",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });

                              dynamic result = await _authService
                                  .registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                error =
                                    'Could not sign in with those credentials';
                              }
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
