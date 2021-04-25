import 'package:flutter/material.dart';

class Challenges extends StatefulWidget {
  @override
  _ChallengesState createState() => _ChallengesState();
}

class _ChallengesState extends State<Challenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Challenges"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildChallengeCard(
                imageName: "BikeChallenge.jpg",
                title: "Cycling challenge",
                text:
                    "A very good cycling challenge. You better join it or PAPA NO KISS.",
              ),
              buildChallengeCard(
                imageName: "RunningChallenge.jpg",
                title: "Running challenge",
                text:
                    "Do u even run bro? You got nothing to lose but that THICC layer of fat on yo stomach.",
              ),
              buildChallengeCard(
                imageName: "WalkingChallenge.jpg",
                title: "Walking challenge",
                text:
                    'One of the noicest challenges ever bro. As Ali Taladar once said "Walking...is..cool!"',
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}

Widget buildChallengeCard({
  @required imageName,
  @required title,
  @required text,
}) =>
    Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 2),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: AssetImage('assets/images/$imageName'),
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 5),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'JOIN CHALLENGE',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            color: Colors.amber[300],
            onPressed: () {},
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
