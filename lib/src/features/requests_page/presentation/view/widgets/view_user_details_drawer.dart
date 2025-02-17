// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/kcolors.dart';
import '../../../../../utils/string_extension.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/button.dart';
import '../../providers/provider.dart';

class ViewUserDetailsDrawer extends ConsumerWidget {
  const ViewUserDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(requestsProvider.select((value) => value.verifyTo));
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
                        details.email ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText("Aadhar Number :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.aadharNumber ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText("PAN Number :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.panNumber ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText("Expertises :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.expertises?.join(", ") ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const AppText("Aadhar Number :", fontWeight: FontWeight.w400, color: KColors.white54),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        details.totalWorkExperience?.toString() ?? '',
                        color: KColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: KColors.white10),
                const DocumentsTile(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      onTap: () => ref.read(requestsProvider.notifier).takeAction(context, details.id!, false),
                      width: 200,
                      borderRadius: 8,
                      backgroundColor: Colors.red,
                      text: "Reject",
                    ),
                    const SizedBox(width: 10),
                    AppButton(
                      onTap: () => ref.read(requestsProvider.notifier).takeAction(context, details.id!, true),
                      width: 200,
                      borderRadius: 8,
                      backgroundColor: Colors.green,
                      text: "Approve",
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

class DocumentsTile extends ConsumerWidget {
  const DocumentsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(requestsProvider.select((value) => value.verifyTo?.documents));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          "Verification Documents",
          color: KColors.white,
        ),
        const SizedBox(height: 20),
        if ((documents?.length ?? 0) == 0) ...[
          const AppText(
            "There is no attachments for this challenge",
            color: KColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ] else ...[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...List.generate(
                documents!.length,
                (index) {
                  final link = documents[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => link.openLink(),
                      borderRadius: BorderRadius.circular(8),
                      child: Ink(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: KColors.filled,
                        ),
                        child: const Badge(
                          backgroundColor: Colors.transparent,
                          alignment: Alignment.bottomRight,
                          label: Icon(
                            Icons.open_in_new,
                            color: KColors.white80,
                          ),
                          child: Icon(
                            CupertinoIcons.doc,
                            size: 74,
                            color: KColors.white80,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ],
    );
  }
}
