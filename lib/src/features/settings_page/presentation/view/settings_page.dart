import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../widgets/app_text.dart';
import 'widgets/add_commission_dialog.dart';

// ignore: constant_identifier_names
enum SettingTypes { Commission }

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const route = "/settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ResponsiveGridView.builder(
        itemCount: SettingTypes.values.length,
        padding: const EdgeInsets.all(20),
        gridDelegate: const ResponsiveGridDelegate(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          minCrossAxisExtent: 350,
          childAspectRatio: 1.5,
          maxCrossAxisExtent: 450,
        ),
        itemBuilder: (context, index) => SettingTypeCard(
          type: SettingTypes.values[index],
        ),
      ),
    );
  }
}

class SettingTypeCard extends StatelessWidget {
  final SettingTypes type;
  const SettingTypeCard({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (type == SettingTypes.Commission) {
          CommissionDialog.show(context);
        } else {
          // Show dialog for other settings.
        }
      },
      splashColor: Colors.transparent,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Ink(
                padding: const EdgeInsets.all(16),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(BorderSide(color: KColors.white54, width: 0.5)),
                ),
                child: Center(
                  child: AppText(
                    type.name,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/lines-bg.png",
                    fit: BoxFit.fill,
                    height: 350,
                    color: const Color(0x0DFFFFFF),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
