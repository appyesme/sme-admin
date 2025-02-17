import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../utils/string_extension.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/profile_avatar.dart';
import '../../models/user_model.dart';

Future<void> showUserDetailsDialog(
  BuildContext context, {
  required UserModel user,
}) async {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: KColors.bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: KColors.bgColor,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleCachedAvatar(
                          scale: 72,
                          image: user.photoUrl,
                          errorIconSize: 24,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                user.name ?? '',
                                fontSize: 20,
                                color: KColors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                decoration: const BoxDecoration(
                                  color: KColors.blue,
                                  borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                                ),
                                child: AppText(
                                  user.userType?.name ?? '',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: KColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () => context.pop(),
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.cancel,
                              color: KColors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: KColors.white80, height: 0),
                  Flexible(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: AppText(
                                "Verified at",
                                color: KColors.white,
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                user.verifiedAt?.toDateFormat("dd MMM, yyyy 'at' hh:mm a") ?? '',
                                color: KColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: AppText(
                                "Expertises",
                                color: KColors.white,
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                user.expertises.join(", "),
                                color: KColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: AppText(
                                "Total work experience",
                                color: KColors.white,
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                (user.totalWorkExperience ?? '-').toString(),
                                color: KColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: AppText(
                                "Aadhar number",
                                color: KColors.white,
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                user.aadharNumber ?? '-',
                                color: KColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(
                              child: AppText(
                                "Pan number",
                                color: KColors.white,
                              ),
                            ),
                            Expanded(
                              child: AppText(
                                user.panNumber ?? '-',
                                color: KColors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
