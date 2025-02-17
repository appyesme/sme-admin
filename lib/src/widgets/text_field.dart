// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants/kcolors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final FormFieldValidator<String>? validator;
  final double radius;
  final bool isPassword;
  final String? initialValue;
  final List<TextInputFormatter> inputFormatters;
  final Widget? icon;
  final Widget? trailing;
  final Color? filledColor;
  final Color? borderColor;
  final bool unfocusOnTapOutside;
  final bool enabled;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.validator,
    this.radius = 60,
    this.isPassword = false,
    this.initialValue,
    this.inputFormatters = const [],
    this.icon,
    this.trailing,
    this.filledColor,
    this.borderColor,
    this.unfocusOnTapOutside = false,
    this.enabled = true,
    this.autofocus = false,
    this.contentPadding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      onChanged: (value) => widget.onChanged?.call(value.trim().isEmpty ? null : value),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: (value) => widget.validator?.call(value == null || value.trim().isEmpty ? null : value),
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        color: KColors.white,
        fontWeight: FontWeight.w500,
      ),
      onTapOutside: (event) => !widget.unfocusOnTapOutside ? null : FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: widget.enabled ? KColors.filled : KColors.disabled,
        contentPadding: widget.contentPadding ?? const EdgeInsets.all(18),
        hintText: widget.hintText,
        hintMaxLines: 1,
        hintStyle: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: KColors.white54,
        ),
        prefixIcon: widget.icon,
        prefixIconConstraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
        suffixIcon: widget.trailing,
        errorStyle: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.red,
          fontSize: 16,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: widget.borderColor ?? KColors.white10, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: widget.borderColor ?? KColors.white10, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: widget.borderColor ?? KColors.white10, width: 0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.red, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
