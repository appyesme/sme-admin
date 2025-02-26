import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/kcolors.dart';
import '../../../core/shared/auth_handler.dart';
import '../../../core/shared/shared.dart';
import '../../../widgets/app_text.dart';
import '../../dashboard_page/views/dashboard_page.dart';
import '../../payments_page/presentation/view/payments_page.dart';
import '../../platform_users_page/views/platform_users_page.dart';
import '../../requests_page/presentation/view/requests_page.dart';
import '../../settings_page/presentation/view/settings_page.dart';
import '../provider/provider.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  static const route = "/";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: KColors.bgColor,
      appBar: AppBar(
        backgroundColor: KColors.black,
        title: const AppText(
          appName,
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: Row(
        children: [
          Consumer(builder: (context, ref, child) {
            // ref.watch(homeProvider);
            // ref.watch(requestsProvider);
            // ref.watch(paymentsProvider);
            // ref.watch(faqsProvider);

            return const SizedBox();
          }),
          SizedBox(
            width: 250,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: NavType.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final selectedNavType = ref.watch(navbarProvider);

                          final type = NavType.values[index];

                          return TabTile(
                            title: type.name,
                            icon: type.icon,
                            selected: index == selectedNavType.index,
                            onTap: () {
                              ref.read(navbarProvider.notifier).changeNavTab(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(color: KColors.white10, height: 0, thickness: 2),
                TabTile(
                  icon: Icons.logout,
                  title: "Logout",
                  selected: false,
                  onTap: () => ref.read(loggedUserProvider).logOut(),
                )
              ],
            ),
          ),
          const VerticalDivider(color: KColors.white10, width: 1, thickness: 2),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final selectedNavType = ref.watch(navbarProvider);

                if (selectedNavType == NavType.Dashboard) {
                  return const DashboardPage();
                } else if (selectedNavType == NavType.Requests) {
                  return const RequestsPage();
                } else if (selectedNavType == NavType.Payments) {
                  return const PaymentsPage();
                } else if (selectedNavType == NavType.Users) {
                  return const PlatformUsersPage();
                } else if (selectedNavType == NavType.Settings) {
                  return const SettingsPage();
                } else {
                  throw Exception("No page found");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class TabTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  const TabTile({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(12),
      minTileHeight: 30,
      tileColor: selected ? KColors.blue : null,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? KColors.white10 : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Icon(
            icon,
            color: selected ? KColors.white : KColors.grey,
          ),
        ),
      ),
      title: AppText(
        title,
        color: selected ? KColors.white : KColors.grey,
      ),
    );
  }
}
