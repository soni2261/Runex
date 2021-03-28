import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NumberPicker Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'NumberPicker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentDoubleValue = 3.0;

  NumberPicker decimalNumberPicker;

  @override
  Widget build(BuildContext context) {
    _initializeNumberPickers();
    return Container(
      child: Column(
        children: <Widget>[
          new RaisedButton(
            onPressed: () => _showDoubleDialog(),
            child: new Text("Current double value: $_currentDoubleValue"),
          ),
        ],
      ),
    );
  }

  void _initializeNumberPickers() {
    decimalNumberPicker = new NumberPicker.decimal(
      initialValue: _currentDoubleValue,
      minValue: 1,
      maxValue: 5,
      decimalPlaces: 2,
      onChanged: (value) => setState(() => _currentDoubleValue = value),
    );
  }

 
  Future _showDoubleDialog() async {
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 5,
          decimalPlaces: 2,
          initialDoubleValue: _currentDoubleValue,
          title: new Text("Pick a decimal number"),
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentDoubleValue = value);
      }
    });
  }
}