import 'package:flutter/material.dart';
import 'package:runex/constants.dart';
import 'package:runex/Screens/Communaute/components/event_card.dart';

class Communaute extends StatefulWidget {
  Communaute({Key key}) : super(key: key);

  @override
  _CommunauteState createState() => _CommunauteState();
}

class _CommunauteState extends State<Communaute> {
  Widget idToCard(map) {
    return EventCard(map);
  }

  @override
  Widget build(BuildContext context) {
    List<Map> listeMap = [
      {
        'id': '123456',
        'name': 'Evenement #1',
        'isFinished': false,
        'sport': 'walk',
        'nbPersonnes': 5,
        'time': 3.78
      },
      {
        'id': '123456',
        'name': 'Evenement #2',
        'isFinished': false,
        'sport': 'bike',
        'nbPersonnes': 3,
        'time': 6.28
      },
      {
        'id': '123456',
        'name': 'Evenement #3',
        'isFinished': false,
        'sport': 'run',
        'nbPersonnes': 6,
        'time': 4.25
      },
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home:Scaffold(
          appBar: AppBar( 
            title: Text('Communaute'),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: listeMap.map((id) => idToCard(id)).toList(),
            ),
          ),
        ),
        ));
  }
}
