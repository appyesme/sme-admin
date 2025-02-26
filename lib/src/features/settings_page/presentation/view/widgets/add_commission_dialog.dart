import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/kcolors.dart';
import '../../../../../utils/string_extension.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/button.dart';
import '../../../../../widgets/loading_indidactor.dart';
import '../../../../../widgets/text_field.dart';
import '../../providers/provider.dart';

class CommissionDialog extends ConsumerWidget {
  const CommissionDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => const CommissionDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Form(
        key: ref.read(settingsProvider.notifier).formKey,
        child: SimpleDialog(
          title: Row(
            spacing: 10,
            children: [
              const Flexible(child: AppText("Add Commission Details")),
              if (ref.watch(settingsProvider.select((value) => value.commission == null)))
                const LoadingIndicator(scale: 18, strokeWidth: 2),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.all(24),
          backgroundColor: KColors.bgColor,
          children: [
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.25),
            Row(
              spacing: 25,
              children: [
                const Expanded(child: AppText("Commission(%)", color: KColors.white54, fontSize: 16)),
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    controller: ref.read(settingsProvider.notifier).commissionTextController,
                    hintText: "Enter commission (in percentage)",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              spacing: 25,
              children: [
                const Expanded(child: AppText("GST(%)", color: KColors.white54, fontSize: 16)),
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    controller: ref.read(settingsProvider.notifier).gstTextController,
                    hintText: "Enter GST (in percentage)",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: AppText(
                "• Commission and GST details should be in percentage.",
                fontWeight: FontWeight.w400,
                color: KColors.white54,
                fontSize: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 0),
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final lastUpdated = ref.watch(settingsProvider.select((value) => value.commission?.updatedAt));
                  return AppText(
                    // "• Last updated on 12th August 2021",
                    "• Last updated on ${lastUpdated?.toDateFormat("dd MMMM yyyy") ?? "N/A"}",
                    fontWeight: FontWeight.w400,
                    color: KColors.white54,
                    fontSize: 14,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            AppButton(
              text: "Save",
              onTap: () {
                ref.read(settingsProvider.notifier).updateCommissionDetails(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
