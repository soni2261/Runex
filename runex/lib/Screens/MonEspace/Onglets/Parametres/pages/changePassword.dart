import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runex/components/rounded_password_field.dart';
import 'package:runex/components/rounded_text_button.dart';
import 'package:runex/components/showAlert.dart';
import 'package:runex/services/auth.dart';

class ChangePassword extends StatelessWidget {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String password = '';
  String passwordConfirm = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Changer le mot de passe")),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                "assets/images/change_password.svg",
                width: size.width * 0.6,
              ),
              SizedBox(
                height: 25,
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
                validationText: "Enter a password longer than 6 characters",
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  passwordConfirm = value;
                },
                validationText: "Enter a password longer than 6 characters",
                hintText: "Confirm Password",
              ),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                text: "SUBMIT",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    if (password != passwordConfirm) {
                      showMyDialog(
                          title: "Error",
                          context: context,
                          alertMessage: "Password do not match",
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("Discard");
                                },
                                child: Text("Close"))
                          ]);
                    } else {
                      bool passwordChanged =
                          await _authService.changePassword(password);
                      if (passwordChanged) {
                        showMyDialog(
                            title: "Le mot de passe est changé",
                            context: context,
                            alertMessage:
                                "Vous avez changé le mot de passe\navec succes",
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("Discard");
                                  Navigator.pop(context);
                                },
                                child: Text("Close"),
                              )
                            ]);
                      } else {
                        showMyDialog(
                            title: "Error",
                            context: context,
                            alertMessage:
                                "Il y avait une erreur.\nLe mot de passe n'est pas changé",
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop("Discard");
                                },
                                child: Text("Close"),
                              )
                            ]);
                      }
                    }
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
