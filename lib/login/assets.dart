import 'package:flutter/material.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/login.jpg'),
  fit: BoxFit.cover,
);

DecorationImage logo = new DecorationImage(
  image: new ExactAssetImage('assets/rsz_tick.png'),
  fit: BoxFit.cover,
);

class TextAssets {
  static String signIn = "Sign In";
  static TextStyle signInStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.3,
  );

  static void load(loginConfig) {
    // TODO implement load from a config file
  }
}
