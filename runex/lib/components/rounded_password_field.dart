import 'package:flutter/material.dart';
import 'package:runex/components/text_field_container.dart';
import 'package:runex/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String validationText;

  const RoundedPasswordField({Key key, this.onChanged, this.validationText})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (val) => val.length < 6 ? widget.validationText : null,
        onChanged: widget.onChanged,
        obscureText: isObscure,
        decoration: InputDecoration(
            hintText: "Password",
            border: InputBorder.none,
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              icon: Icon(Icons.visibility),
              color: kPrimaryColor,
            )),
      ),
    );
  }
}
