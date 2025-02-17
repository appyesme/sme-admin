// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;

  const SvgIcon({super.key, required this.icon, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size,
      // ignore: deprecated_member_use
      color: color,
    );
  }
}
