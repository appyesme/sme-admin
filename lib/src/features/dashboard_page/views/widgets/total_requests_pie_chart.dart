import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/kcolors.dart';
import '../../../../utils/string_extension.dart';
import '../../../../widgets/app_text.dart';
import '../../providers/provider.dart';

class TotalRequestsPieChart extends StatelessWidget {
  const TotalRequestsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: KColors.white54, width: 0.5)),
      child: Column(
        children: <Widget>[
          const Row(
            children: [
              Expanded(
                child: AppText(
                  'Today Requests',
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Consumer(
                builder: (context, ref, child) {
                  final entrepreneurs = ref.watch(dashboardProvider.select((value) => value.entrepreneurs));

                  return Container(
                    padding: const EdgeInsets.all(54),
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KColors.bgColor,
                      border: Border.all(color: KColors.blue, width: 30),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        FittedBox(
                          child: AppText(
                            "${entrepreneurs?.length ?? 0}",
                            fontSize: 54,
                          ),
                        ),
                        AppText(
                          DateTime.now().toString().toDateFormat('dd MMMM'),
                          fontSize: 14,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
