import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/shared/auth_handler.dart';
import '../../../../services/api_services/auth_apis.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/dialog/dailog_helper.dart';
import '../../../../utils/string_extension.dart';
import 'state.dart';

final authProvider = StateNotifierProvider.autoDispose<LoginNotifier, AuthState>(
  (ref) {
    final notifier = LoginNotifier(ref);
    return notifier;
  },
);

class LoginNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  LoginNotifier(this.ref) : super(const AuthState());

  void _setState(AuthState value) => state = value;
  final authFormKey = GlobalKey<FormState>();

  void update(AuthState Function(AuthState) value) {
    final updated = value(state);
    _setState(updated);
  }

  OtpTimerButtonController controller = OtpTimerButtonController();

  String get phone => "+91${state.phoneNumber}";

  void getOTP(BuildContext context) async {
    final validated = authFormKey.currentState?.validate() ?? false;
    if (!validated) return;
    DialogHelper.unfocus(context);

    DialogHelper.showloading(context);
    final response = await AuthApi.signIn(phone);
    DialogHelper.pop(context);
    if (response != null) {
      _setState(state.copyWith(showOtpField: true));
      Toast.success("OTP has sent to $phone");
    }
  }

  void verifyOTP(BuildContext context) async {
    if (state.otp != null && state.otp!.length == 4) {
      DialogHelper.showloading(context);
      final result = await AuthApi.verifyOtp(phone, state.otp!);
      DialogHelper.pop(context);
      if (result != null) {
        final token = result["token"];
        if (token != null) {
          final decodedJWT = token.toString().decodeJWTAndGetUserId();
          final userType = decodedJWT?.type.getType;
          if (userType == UserType.ADMIN) {
            Toast.success(result["message"] ?? "Verification failed");
            ref.read(loggedUserProvider.notifier).checkAuthenticated(token);
          } else {
            Toast.failure("You are not authorized to access this platform");
          }
        } else {
          Toast.failure("Verification failed");
        }
      }
    }
  }
}
