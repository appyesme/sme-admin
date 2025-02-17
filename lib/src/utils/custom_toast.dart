import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../core/constants/kcolors.dart';
import '../widgets/app_text.dart';

abstract class Toast {
  static void success(String message) {
    toastification.show(
      title: AppText(message),
      style: ToastificationStyle.fillColored,
      showIcon: false,
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static T? failure<T>(String message, [T? returnValue]) {
    toastification.show(
      title: AppText(message),
      style: ToastificationStyle.fillColored,
      showIcon: false,
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 3),
    );
    return returnValue;
  }

  static T? info<T>(String message) {
    toastification.show(
      title: AppText(message),
      backgroundColor: KColors.blue,
      showIcon: false,
      type: ToastificationType.info,
      borderSide: const BorderSide(color: Colors.transparent),
      autoCloseDuration: const Duration(seconds: 3),
    );
    return null;
  }
}
