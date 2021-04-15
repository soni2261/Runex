import 'package:flutter/material.dart';
import 'package:runex/components/text_field_container.dart';
import 'package:runex/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String validationText;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.validationText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Color.fromRGBO(96, 92, 102, 1);
    return TextFieldContainer(
      child: TextFormField(
        validator: (val) => val.isEmpty ? validationText : null,
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintStyle: TextStyle(color: textColor),
            hintText: hintText,
            border: InputBorder.none),
      ),
    );
  }
}
