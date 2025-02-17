import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/text_field.dart';
import '../providers/provider.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  static const String route = "/auth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Form(
                    key: ref.read(authProvider.notifier).authFormKey,
                    child: Center(
                      child: Column(
                        children: [
                          const Spacer(),
                          const AppText(
                            "DASHBOARD",
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontSize: 52,
                          ),
                          const SizedBox(height: 40),
                          const AppText(
                            "Login",
                            color: Colors.white,
                            fontSize: 26,
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            onChanged: (value) {
                              final provider = ref.read(authProvider.notifier);
                              provider.update((state) => state.copyWith(phoneNumber: value, showOtpField: false));
                            },
                            validator: (value) => value == null || value.length != 10 ? "Required" : null,
                            hintText: 'Enter phone number',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            icon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: AppText(
                                "+91",
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: KColors.white,
                              ),
                            ),
                          ),
                          Consumer(
                            builder: (_, WidgetRef ref, __) {
                              final showOtpField = ref.watch(authProvider.select((value) => value.showOtpField));
                              if (!showOtpField) return const SizedBox();

                              return Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Pinput(
                                    onChanged: (value) {
                                      final provider = ref.read(authProvider.notifier);
                                      provider.update((state) => state.copyWith(otp: value));
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    defaultPinTheme: PinTheme(
                                      width: 50,
                                      height: 50,
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: KColors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: KColors.white54),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          Consumer(
                            builder: (_, WidgetRef ref, __) {
                              final showOtpField = ref.watch(authProvider.select((value) => value.showOtpField));

                              return AppButton(
                                onTap: () {
                                  if (showOtpField) return ref.read(authProvider.notifier).verifyOTP(context);
                                  ref.read(authProvider.notifier).getOTP(context);
                                },
                                text: showOtpField ? "Verify OTP" : "Get OTP",
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
