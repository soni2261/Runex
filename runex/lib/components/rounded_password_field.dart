import 'package:flutter/material.dart';
import 'package:runex/components/text_field_container.dart';
import 'package:runex/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String validationText;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.validationText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (val) => val.length < 6 ? validationText : null,
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Password",
            border: InputBorder.none,
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            )),
      ),
    );
  }
}
