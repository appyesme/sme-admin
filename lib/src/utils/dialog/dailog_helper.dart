import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/kcolors.dart';
import '../../widgets/app_text.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_indidactor.dart';

abstract class DialogHelper {
  static void removeLoading(BuildContext context) => GoRouter.of(context).pop();
  static pop(BuildContext context) => GoRouter.of(context).pop();
  static unfocus(BuildContext context) => FocusManager.instance.primaryFocus?.unfocus();

  static void showloading(BuildContext context, [String text = 'Please hold on']) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: KColors.blue,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 180,
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LoadingIndicator(color: KColors.white),
                    AppText(
                      text,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  static Future<bool?> deleteWarning(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      barrierColor: Colors.black38,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: KColors.filled,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const AppText(
                        "This action cannot be reversible.\nAre you sure you want to delete ?",
                        textAlign: TextAlign.center,
                        color: KColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(
                            onTap: () => context.pop(false),
                            width: 120,
                            height: 50,
                            elevation: 0,
                            backgroundColor: KColors.white10,
                            text: "Cancel",
                          ),
                          const SizedBox(width: 10),
                          AppButton(
                            onTap: () => context.pop(true),
                            width: 120,
                            height: 50,
                            elevation: 0,
                            backgroundColor: KColors.secondary,
                            text: "Delete",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
