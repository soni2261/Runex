// import 'package:flutter/material.dart';

// class MapTextField extends StatefulWidget {
//   MapTextField({Key key}) : super(key: key);

//   @override
//   _MapTextFieldState createState() => _MapTextFieldState();
// }

// class _MapTextFieldState extends State<MapTextField> {
//   TextEditingController controller;
//   String label = '';
//   String hint;
//   String initialValue;
//   double width;
//   Icon prefixIcon;
//   Widget suffixIcon;
//   Function(String) locationCallback;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     width: width * 0.8,
//     child: TextField(
//       onChanged: (value) {
//         locationCallback(value);
//       },
//       controller: controller,
//       // initialValue: initialValue,
//       decoration: new InputDecoration(
//         prefixIcon: prefixIcon,
//         suffixIcon: suffixIcon,
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10.0),
//           ),
//           borderSide: BorderSide(
//             color: Colors.grey[400],
//             width: 2,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(10.0),
//           ),
//           borderSide: BorderSide(
//             color: Colors.blue[300],
//             width: 2,
//           ),
//         ),
//         contentPadding: EdgeInsets.all(15),
//         hintText: hint,
//       ),
//     ),
//     );
//   }
// }
