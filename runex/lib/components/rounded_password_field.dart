import 'package:flutter/material.dart';
import 'package:runex/components/text_field_container.dart';
import 'package:runex/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String validationText;
  final String hintText;

  const RoundedPasswordField(
      {Key key, this.onChanged, this.validationText, this.hintText})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    String hintText = widget.hintText == "" || widget.hintText == null
        ? "Password"
        : widget.hintText;
    return TextFieldContainer(
      child: TextFormField(
        validator: (val) => val.length < 6 ? widget.validationText : null,
        onChanged: widget.onChanged,
        obscureText: isObscure,
        decoration: InputDecoration(
            errorMaxLines: 2,
            hintText: hintText,
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
