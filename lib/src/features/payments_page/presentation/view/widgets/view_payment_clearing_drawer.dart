// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/kcolors.dart';
import '../../../../../utils/string_extension.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/button.dart';
import '../../../models/payment_clearance_model.dart';
import '../../providers/provider.dart';

class ViewPaymentClearingDrawer extends ConsumerWidget {
  const ViewPaymentClearingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);

    final details = ref.watch(paymentsProvider.select((value) => value.clearingTo));
    if (details == null) return const SizedBox();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Drawer(
          backgroundColor: KColors.bgColor,
          width: constraints.maxWidth * 0.6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        details.name ?? '',
                        fontSize: 32,
                        color: KColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () => context.pop(),
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.cancel,
                        color: KColors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const AppText("Phone :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.phoneNumber ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText("Email :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.name ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText(
                      "Last cleared date and time :",
                      fontWeight: FontWeight.w400,
                      color: KColors.white54,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.lastClearedAt?.toDateFormat("MMM dd, yyyy - hh:mm a") ?? "-",
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PaymentBankAccountDetails(details: details),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: KColors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const AppText("Total amount to clear:", fontWeight: FontWeight.w400, color: KColors.white54),
                      const SizedBox(width: 10),
                      if (details.totalAmountToClear == null)
                        const CupertinoActivityIndicator(color: KColors.white)
                      else
                        Expanded(
                          child: AppText(
                            "Rs. ${details.totalAmountToClear?.toString() ?? '-'}",
                            color: KColors.white,
                            fontSize: 32,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Flexible(
                      child: AppText(
                        "Mark as cleared and this action cannot be undone",
                        color: KColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ValueListenableBuilder(
                      valueListenable: valueNotifier,
                      builder: (BuildContext context, bool checked, Widget? child) {
                        return Checkbox(
                          value: checked,
                          side: const BorderSide(color: KColors.white),
                          activeColor: KColors.secondary,
                          onChanged: (value) {
                            valueNotifier.value = !checked;
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    ValueListenableBuilder(
                      valueListenable: valueNotifier,
                      builder: (BuildContext context, bool checked, Widget? child) {
                        return AppButton(
                          onTap: () {
                            if (valueNotifier.value && (details.totalAmountToClear ?? 0) > 0) {
                              ref.read(paymentsProvider.notifier).markAsCleared(context, details);
                            }
                          },
                          width: 200,
                          borderRadius: 8,
                          backgroundColor: checked ? Colors.green : Colors.grey,
                          text: "Mark as cleared",
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentBankAccountDetails extends StatelessWidget {
  const PaymentBankAccountDetails({super.key, required this.details});

  final PaymentClearanceEntrepreneur details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: KColors.white10,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 18,
                    color: KColors.white80,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: AppText(
                      "Payment bank account details",
                      fontSize: 18,
                      color: KColors.white80,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: AppText(
                      "Account name",
                      fontSize: 16,
                      color: KColors.white80,
                    ),
                  ),
                  const AppText(" : "),
                  Expanded(
                    flex: 3,
                    child: AppText(
                      details.bankAccount?.accountName ?? '-',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: AppText(
                      "Account number",
                      fontSize: 16,
                      color: KColors.white80,
                    ),
                  ),
                  const AppText(" : "),
                  Expanded(
                    flex: 3,
                    child: AppText(
                      details.bankAccount?.accountNumber ?? '-',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: AppText(
                      "IFSC Code",
                      fontSize: 16,
                      color: KColors.white80,
                    ),
                  ),
                  const AppText(" : "),
                  Expanded(
                    flex: 3,
                    child: AppText(
                      details.bankAccount?.ifscCode ?? '-',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: AppText(
                      "UPI",
                      fontSize: 16,
                      color: KColors.white80,
                    ),
                  ),
                  const AppText(" : "),
                  Expanded(
                    flex: 3,
                    child: AppText(
                      details.bankAccount?.upi ?? '-',
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
