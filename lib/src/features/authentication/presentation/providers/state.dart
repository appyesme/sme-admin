import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? phoneNumber,
    String? otp,
    @Default(false) bool showOtpField,
  }) = _AuthState;
}
