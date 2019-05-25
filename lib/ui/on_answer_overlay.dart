import "dart:math" show pi;
import "package:flutter/material.dart";

class OnAnswerOverlay extends StatefulWidget {

  final bool _isCorrect;
  final VoidCallback _onTap;

  OnAnswerOverlay(this._isCorrect, this._onTap);

  @override
  State createState() => OnAnswerOverlayState();
}

class OnAnswerOverlayState extends State<OnAnswerOverlay> with SingleTickerProviderStateMixin{

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _iconAnimation = new CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: new InkWell(
        onTap: () => widget._onTap(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(6.0),
              decoration: new BoxDecoration(
                border: new Border.all(width: 4.0, color: Colors.white),
                borderRadius: new BorderRadius.circular(100)
              ),
              child: Transform.rotate(
                angle: _iconAnimation.value * 2 * pi,
                child: new Icon(widget._isCorrect == true ? Icons.done : Icons.clear, size: _iconAnimation.value * 80.0, color: Colors.white,),
              ),
            ),
            new Padding (
              padding: new EdgeInsets.only(bottom: 10.0),
            ),
            new Text(widget._isCorrect == true ? "Correct!" : "Wrong!",
              style: new TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}