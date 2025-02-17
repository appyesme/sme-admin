import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widgets/earnings_chart.dart';
import 'widgets/joinings_chart.dart';
import 'widgets/total_requests_pie_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const route = "/dashboard";

  @override
  Widget build(BuildContext context) {
    List<Widget> charts = [
      const JoiningsChart(),
      const EarningsChart(),
      const TotalRequestsPieChart(),
    ];

    return Scaffold(
      body: ResponsiveGridView.builder(
        itemCount: charts.length,
        gridDelegate: const ResponsiveGridDelegate(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          minCrossAxisExtent: 480,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) => charts[index],
      ),
    );
  }
}
