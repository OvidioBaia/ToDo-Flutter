import 'dart:async';
import 'package:flutter/material.dart';
import 'package:listtodo/video/Home.dart';


class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}



class VideoState extends State<Splash> with SingleTickerProviderStateMixin{

  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 1));
    animation =
    CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Image.asset('lib/assets/powered_by.png',
                        height: 25.0,
                        fit: BoxFit.scaleDown,
                  )
              )
            ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/devs.jpg',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}