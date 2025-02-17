import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isDeskTop => ResponsiveBreakpoints.of(this).isDesktop;
}
