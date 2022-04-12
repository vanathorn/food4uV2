import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final bool isMount;
  final double initialRadius;
  final double radiusCenter;
  final double radiusSmall;

  Loader(
      {Key key,
      this.isMount: true,
      this.initialRadius: 5.0,
      this.radiusCenter: 28.0,
      this.radiusSmall: 5.0})
      : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> aniRotation;
  Animation<double> aniRadiusIn;
  Animation<double> aniRadiusOut;

  double radius = 0.0,
      initialRadius = 0.0,
      radiusCenter = 0.0,
      radiusSmall = 0.0;
  bool isMount;

  @override
  void dispose() {
    try {
      isMount = false;
      controller.dispose();
      super.dispose();
    } catch (ex) {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    isMount = widget.isMount;
    initialRadius = widget.initialRadius;
    radiusCenter = widget.radiusCenter;
    radiusSmall = widget.radiusSmall;

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    aniRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        )));

    aniRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.75,
          1.0,
          curve: Curves.elasticIn,
        )));

    aniRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {      
      if (isMount) {
        try {
          setState(() {
            if (controller.value >= 0.75 && controller.value <= 1.0) {
              radius = aniRadiusIn.value * initialRadius;
            } else if (controller.value >= 0.0 && controller.value <= 0.25) {
              radius = aniRadiusOut.value * initialRadius;
            }
          });
        } catch (ex) {
          //
        }
      }
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        child: Center(
          child: RotationTransition(
            turns: aniRotation,
            child: Stack(
              children: <Widget>[
                Dot(radius: radiusCenter, color: Colors.transparent),
                Transform.translate(
                    offset: Offset(radius * cos(pi / 5), radius * sin(pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 6, 47, 119))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(2 * pi / 5), radius * sin(2 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 5, 68, 175))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(3 * pi / 5), radius * sin(3 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 175, 5, 5))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(4 * pi / 5), radius * sin(4 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 233, 89, 5))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(5 * pi / 5), radius * sin(5 * pi / 5)),
                    child: Dot(radius: radiusSmall, color: Colors.amber)),
                Transform.translate(
                    offset: Offset(
                        radius * cos(6 * pi / 5), radius * sin(6 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 133, 247, 4))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(7 * pi / 5), radius * sin(7 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 4, 247, 4))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(8 * pi / 5), radius * sin(8 * pi / 5)),
                    child: Dot(radius: radiusSmall, color: Colors.yellow)),
                Transform.translate(
                    offset: Offset(
                        radius * cos(9 * pi / 5), radius * sin(9 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 250, 17, 172))),
                Transform.translate(
                    offset: Offset(
                        radius * cos(10 * pi / 5), radius * sin(10 * pi / 5)),
                    child: Dot(
                        radius: radiusSmall,
                        color: Color.fromARGB(255, 175, 3, 206))),
              ],
            ),
          ),
        ));
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
