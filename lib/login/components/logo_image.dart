import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final DecorationImage image;
  LogoWidget({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 250.0,
      height: 250.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: image,
      ),
    ));
  }
}
