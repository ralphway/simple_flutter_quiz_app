import "package:flutter/material.dart";
import "./landing_page.dart";

class ScorePage extends StatelessWidget {

  final int score;
  final int totalQuestions;

  ScorePage(this.score, this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Your score: " + score.toString() + "/" + totalQuestions.toString(),
            style: new TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
          ),
          new IconButton(
            icon: new Icon(Icons.arrow_right),
            color: Colors.white,
            iconSize: 100.0,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage("Another try?")), (Route route) => route == null),
          ),
        ]
      ),
    );
  }
}