import 'dart:ui';
import 'package:flutter/animation.dart';

class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin!.left, end!.left, elasticCurveValue) as double,
      lerpDouble(begin!.top, end!.top, elasticCurveValue) as double,
      lerpDouble(begin!.right, end!.right, elasticCurveValue) as double,
      lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue) as double,
    );
  }
}