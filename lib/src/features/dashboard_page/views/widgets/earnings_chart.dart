import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/kcolors.dart';
import '../../../../utils/string_extension.dart';
import '../../../../widgets/app_text.dart';
import '../../providers/provider.dart';

class EarningsChart extends ConsumerWidget {
  const EarningsChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = ref.watch(dashboardProvider.select((value) => value.earningChartStartDate));
    log("RRR ${startDate.toString()}");

    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      margin: const EdgeInsets.all(10),
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: KColors.white54, width: 0.5)),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              const Expanded(
                child: AppText(
                  'Earnings',
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () => ref.read(dashboardProvider.notifier).changeEarningChartDate(false),
                splashRadius: 20,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  CupertinoIcons.chevron_left,
                  color: KColors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 5),
              Builder(
                builder: (context) {
                  final dates = weekDates(date: startDate);
                  return AppText(
                    "${dates.first.toString().toDateFormat('dd MMM')} - ${dates.last.toString().toDateFormat('dd MMM')}",
                    fontSize: 16,
                  );
                },
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () => ref.read(dashboardProvider.notifier).changeEarningChartDate(true),
                splashRadius: 20,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  CupertinoIcons.chevron_right,
                  color: KColors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Builder(
                builder: (_) {
                  final earnings = ref.watch(dashboardProvider.select((value) => value.earnings));
                  final highestValue = earnings?.fold(0.0, (p, i) => p < i.earnings ? i.earnings : p);

                  return BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => KColors.black,
                          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                          tooltipMargin: -10,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final date = weekDates(date: startDate).elementAtOrNull((group.x % 7).toInt());

                            return BarTooltipItem(
                              '${weekNames[group.x % 7]}\n',
                              const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: KColors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${date.toString().toDateFormat('dd MMM, yyyy')}\n',
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: KColors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: "Rs. ${rod.toY.toString()}",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    color: KColors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final shortName = weekShortNames.elementAtOrNull((value % 7).toInt());

                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: AppText(
                                  shortName ?? '',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              );
                            },
                            reservedSize: 38,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: weekDates(date: startDate).map(
                        (item) {
                          final earning = earnings?.singleWhereOrNull((element) {
                            return element.day!.toDateFormat() == item.toString().toDateFormat();
                          });

                          return BarChartGroupData(
                            x: item.weekday,
                            barRods: [
                              BarChartRodData(
                                toY: (earning?.earnings ?? 0).toDouble(),
                                color: KColors.yellow,
                                width: 35,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(60)),
                                borderSide: const BorderSide(color: Colors.white, width: 0),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: (highestValue == 0 ? 1 : highestValue ?? 1).toDouble(),
                                  color: KColors.filled,
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                      gridData: const FlGridData(show: false),
                    ),
                    duration: animDuration,
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
