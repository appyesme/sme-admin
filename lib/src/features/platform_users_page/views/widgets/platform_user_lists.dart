import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/dialog/dailog_helper.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/no_content_message_widget.dart';
import '../../../../widgets/profile_avatar.dart';
import '../../models/user_model.dart';
import '../../providers/provider.dart';
import '../dialogs/select_challenge_badges_dialog.dart';

class PlatformUserLists extends ConsumerWidget {
  const PlatformUserLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        PagedSliverList.separated(
          pagingController: ref.read(platformUsersProvider.notifier).pagingUserController,
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          // showNewPageProgressIndicatorAsGridChild: false,
          separatorBuilder: (context, index) => const Divider(color: KColors.white10, height: 0),
          builderDelegate: PagedChildBuilderDelegate<UserModel>(
            newPageProgressIndicatorBuilder: (context) => const Padding(
              padding: EdgeInsets.all(54.0),
              child: CupertinoActivityIndicator(
                color: KColors.white,
                radius: 24,
              ),
            ),
            firstPageProgressIndicatorBuilder: (context) => const Padding(
              padding: EdgeInsets.all(16.0),
              child: CupertinoActivityIndicator(
                color: KColors.white,
                radius: 32,
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const NoContentMessageWidget(
              message: "No users found on your search",
              icon: Icons.person,
            ),
            itemBuilder: (context, user, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  DialogHelper.unfocus(context);
                  showUserDetailsDialog(context, user: user);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleCachedAvatar(
                        scale: 40,
                        image: user.photoUrl,
                        errorIconSize: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          user.name ?? "-",
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                          color: KColors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: AppText(
                                user.email ?? '',
                                maxLines: 2,
                                fontWeight: FontWeight.w400,
                                color: KColors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (user.email == null || user.email!.isEmpty) return;
                                Clipboard.setData(ClipboardData(text: user.email ?? ''));
                                Toast.info("${user.email} copied");
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.copy,
                                  size: 18,
                                  color: KColors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: AppText(
                                user.phoneNumber ?? '',
                                maxLines: 2,
                                fontWeight: FontWeight.w400,
                                color: KColors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (user.phoneNumber == null || user.phoneNumber!.isEmpty) return;
                                Clipboard.setData(ClipboardData(text: user.phoneNumber ?? ''));
                                Toast.info("${user.phoneNumber} copied");
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.copy,
                                  size: 18,
                                  color: KColors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          user.userType?.name ?? '',
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                          color: KColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
