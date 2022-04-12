import 'package:flutter/material.dart';
import 'package:food4u/screen/SingUp.dart';
import 'package:food4u/screen/home.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => Home(),
  '/signup': (BuildContext context) => SignUp(),
};
