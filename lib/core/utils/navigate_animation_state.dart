import 'package:flutter/material.dart';

enum NavigateAnimationState {
  nonAnimation(
    NavigateAnimations.nonAnimation,
    Duration.zero,
  ),
  slideBottomToTop(
    NavigateAnimations.slideBottomToTop,
    Duration(milliseconds: 300),
  ),
  slideRightToLeft(
    NavigateAnimations.slideRightToLeft,
    Duration(milliseconds: 300),
  );

  final Widget Function(
    BuildContext,
    Animation<double>,
    Animation<double>,
    Widget,
  ) animation;

  final Duration duration;

  const NavigateAnimationState(this.animation, this.duration);
}

class NavigateAnimations {
  static Widget nonAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }

  static Widget slideBottomToTop(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const Offset begin = Offset(0.0, 1.0);
    const Offset end = Offset.zero;
    const Curve curve = Curves.ease;

    Animatable<Offset> tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget slideRightToLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const Offset begin = Offset(1.0, 0.0);
    const Offset end = Offset.zero;
    const Curve curve = Curves.ease;

    Animatable<Offset> tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: curve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
