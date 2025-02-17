import 'package:flutter/foundation.dart';

import '../../core/api/api_helper.dart';
import '../../utils/custom_toast.dart';

@immutable
abstract class AuthApi {
  static Future<Map<String, dynamic>?> signIn(String phoneNumber) async {
    String path = "/admin/signin";
    final response = await ApiHelper.post(path, body: {"phone_number": phoneNumber});
    return response.fold((l) => Toast.failure(l.message), (r) => r.data);
  }

  static Future<Map<String, dynamic>?> verifyOtp(String phoneNumber, String otp) async {
    String path = "/auth/phone/verify";
    final response = await ApiHelper.post(
      path,
      body: {"phone_number": phoneNumber, "otp": otp},
    );
    return response.fold<Map<String, dynamic>?>((l) => Toast.failure(l.message), (r) => r.data);
  }
}
