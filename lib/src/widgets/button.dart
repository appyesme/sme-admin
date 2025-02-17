import 'package:flutter/material.dart';

import '../core/constants/kcolors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double fontSize;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final FontWeight fontWeight;
  final bool isLoading;
  final Color? overlayColor;

  const AppButton({
    super.key,
    this.text,
    this.onTap,
    this.child,
    this.fontSize = 18,
    this.textColor = Colors.white,
    this.backgroundColor = KColors.blue,
    this.borderColor = Colors.transparent,
    this.borderRadius = 60,
    this.width = double.infinity,
    this.height = 60,
    this.elevation = 2.0,
    this.padding,
    this.fontWeight = FontWeight.w500,
    this.isLoading = false,
    this.overlayColor,
  }) : assert(text == null || child == null);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onTap,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(padding),
        elevation: WidgetStateProperty.all(onTap == null ? 0 : elevation),
        animationDuration: const Duration(milliseconds: 100),
        minimumSize: WidgetStateProperty.all(Size(width, height)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            side: BorderSide(color: borderColor!, width: 1),
          ),
        ),
        mouseCursor: WidgetStateMouseCursor.clickable,
        overlayColor: WidgetStatePropertyAll(overlayColor ?? Colors.black12),
        backgroundColor: WidgetStateProperty.all(onTap == null ? Colors.grey : backgroundColor),
      ),
      child: Builder(
        builder: (context) {
          if (isLoading) {
            return const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5),
            );
          } else if (child != null) {
            return child!;
          } else {
            return AppText(
              text!,
              textAlign: TextAlign.center,
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            );
          }
        },
      ),
    );
  }
}
