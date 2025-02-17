// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../core/constants/kcolors.dart';
import 'app_text.dart';

class DropDownItem<T extends Object?> {
  final String id;
  final String? title;
  final T? value;
  const DropDownItem({required this.id, this.title, this.value});

  @override
  bool operator ==(covariant DropDownItem<T> other) {
    if (identical(this, other)) return true;
    return other.id == id && other.title == title && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ value.hashCode;
}

class AppDropDown<T> extends StatefulWidget {
  final DropDownItem<T>? Function() value;
  final String hinttext;
  final List<DropDownItem<T>> items;
  final ValueChanged<DropDownItem<T>?>? onChanged;
  final bool showSearchBar;
  final double height;
  final FormFieldValidator<DropDownItem<T>?>? validator;

  const AppDropDown({
    super.key,
    required this.value,
    required this.hinttext,
    this.items = const [],
    this.onChanged,
    this.showSearchBar = true,
    this.height = 40,
    this.validator,
  });

  @override
  State<AppDropDown<T>> createState() => _DropDAppownWithI<T>();
}

class _DropDAppownWithI<T> extends State<AppDropDown<T>> {
  bool _isOpened = false;

  DropDownItem<T>? get value => widget.value();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(highlightColor: Colors.transparent, splashColor: Colors.transparent),
      child: DropdownButtonFormField2<DropDownItem<T>>(
        onChanged: widget.onChanged,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 12),
          errorStyle: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Colors.red,
            fontSize: 16,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KColors.white10, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KColors.white10, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: KColors.white10, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          isDense: true,
          filled: true,
          fillColor: KColors.filled,
        ),
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.zero,
          offset: const Offset(0, -5),
          maxHeight: 250,
          elevation: 2,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: KColors.white54),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        buttonStyleData: const ButtonStyleData(elevation: 10, decoration: BoxDecoration()),
        customButton: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              if (value != null) ...[
                Expanded(
                  child: AppText(
                    value!.title ?? value!.id,
                    maxLines: 1,
                    height: 0,
                    fontWeight: FontWeight.w400,
                    color: KColors.white,
                  ),
                ),
              ] else ...[
                Expanded(
                  child: AppText(
                    widget.hinttext,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    maxLines: 1,
                    color: KColors.grey,
                  ),
                ),
              ],
              const SizedBox(width: 5),
              Transform.rotate(
                angle: _isOpened ? 0 : pi,
                child: const Icon(
                  Icons.arrow_drop_up,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        onMenuStateChange: (isOpen) => setState(() => _isOpened = isOpen),
        items: [
          ...widget.items.map(
            (item) {
              return DropdownMenuItem<DropDownItem<T>>(
                value: item,
                child: AppText(
                  item.title ?? item.id,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
