import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/kcolors.dart';
import '../../../widgets/text_field.dart';
import '../providers/provider.dart';
import 'widgets/platform_user_lists.dart';

class PlatformUsersPage extends ConsumerStatefulWidget {
  const PlatformUsersPage({super.key});

  static const route = "/platform-users";

  @override
  ConsumerState<PlatformUsersPage> createState() => _PlatformUsersPageState();
}

class _PlatformUsersPageState extends ConsumerState<PlatformUsersPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ref.read(platformUsersProvider.notifier).init());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 10,
        automaticallyImplyLeading: false,
        backgroundColor: KColors.bgColor,
        centerTitle: false,
        bottom: Tab(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: ref.read(platformUsersProvider.notifier).searchController,
                    onChanged: ref.read(platformUsersProvider.notifier).onSearchChanged,
                    filledColor: const Color(0xFFF8F8F8),
                    borderColor: Colors.transparent,
                    hintText: "Search",
                    trailing: Consumer(
                      builder: (ctx, ref, child) {
                        final searching = ref.watch(platformUsersProvider.select((value) => value.searching));

                        if (!searching) return const SizedBox();

                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const PlatformUserLists(),
    );
  }
}
