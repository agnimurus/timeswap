import 'package:flutter/material.dart';
import 'dart:async';
import 'package:logging/logging.dart';
import 'assets.dart';

Logger _log = Logger('login_animation');

/// See https://github.com/GeekyAnts/flutter-login-home-animation
class StaggerAnimation extends StatelessWidget {
  final config;
  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;
  final Animation buttomZoomOut;
  final Function signInOnPressed;
  Color animationAreaColor() => Color.fromRGBO(
      config['areaColor']['red'],
      config['areaColor']['green'],
      config['areaColor']['blue'],
      config['areaColor']['alpha']);

  StaggerAnimation(
      {Key key,
      @required this.buttonController,
      @required this.signInOnPressed,
      @required this.config})
      : buttonSqueezeanimation = Tween(
          begin: config['button']['squeezeAnimation']['begin'],
          end: config['button']['squeezeAnimation']['end'],
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              config['button']['squeezeAnimation']['curve']['begin'],
              config['button']['squeezeAnimation']['curve']['end'],
            ),
          ),
        ),
        buttomZoomOut = Tween(
          begin: config['button']['zoom']['begin'],
          end: config['button']['zoom']['end'],
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              config['button']['zoom']['curve']['begin'],
              config['button']['zoom']['curve']['end'],
              curve: Curves.bounceOut,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: EdgeInsets.only(bottom: config['circle']['begin']),
          end: EdgeInsets.only(bottom: config['circle']['end']),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: Interval(
              config['circle']['curve']['begin'],
              config['circle']['curve']['end'],
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
      await buttonController.reverse();
    } on TickerCanceled {}
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    // Are we at the start of the zoom animation?
    bool isZoomStart = buttomZoomOut.value == config['button']['zoom']['begin'];
    return getAnimationContainer(isZoomStart);
  }

  /// non-private for easier testing
  Widget getAnimationContainer(bool isZoomStart) => Padding(
        padding: isZoomStart
            ? EdgeInsets.only(bottom: config['circle']['begin'])
            : containerCircleAnimation.value,
        child: InkWell(
          onTap: () {
            _playAnimation();
          },
          child: _getAnimationHero(isZoomStart),
        ),
      );

  Widget _getAnimationHero(bool isZoomStart) => Hero(
        tag: config['hero']['tag'],
        child: buttomZoomOut.value <= config['button']['zoom']['threshold']
            ? _earlyStageHeroContainer(isZoomStart)
            : _lateStageHeroContainer(),
      );

  /// before zoom threshold is passed
  Widget _earlyStageHeroContainer(bool isZoomStart) => Container(
      width: isZoomStart ? buttonSqueezeanimation.value : buttomZoomOut.value,
      height:
          isZoomStart ? config['hero']['init']['height'] : buttomZoomOut.value,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: animationAreaColor(),
        borderRadius:
            buttomZoomOut.value < config['hero']['radius']['threshold']
                ? BorderRadius.all(
                    Radius.circular(config['hero']['radius']['length']))
                : BorderRadius.all(const Radius.circular(0.0)),
      ),
      child: buttonSqueezeanimation.value >
              config['button']['squeezeAnimation']['threshold']
          ? Text(
              TextAssets.signIn,
              style: TextAssets.signInStyle,
            )
          : CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));

  /// after zoom threshold is passed
  Widget _lateStageHeroContainer() => Container(
        width: buttomZoomOut.value,
        height: buttomZoomOut.value,
        decoration: BoxDecoration(
          // circle before halfway stage, rectangle after
          shape: buttomZoomOut.value < config['button']['zoom']['end'] / 2.0
              ? BoxShape.circle
              : BoxShape.rectangle,
          color: animationAreaColor(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        signInOnPressed();
        // _log.info('pushing /home');
        // Navigator.pushNamed(context, "/home");
      }
    });
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
