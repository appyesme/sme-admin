import 'package:flutter/material.dart';

import '../core/constants/kcolors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? height;
  final FontStyle? fontStyle;
  final TextStyle? style;
  final String? fontFamily;

  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.decoration,
    this.height,
    this.fontStyle,
    this.style,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: style ??
          TextStyle(
            fontFamily: fontFamily ?? "Poppins",
            fontSize: fontSize ?? 18,
            fontStyle: fontStyle,
            decoration: decoration,
            height: height,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? KColors.white,
          ),
    );
  }
}
