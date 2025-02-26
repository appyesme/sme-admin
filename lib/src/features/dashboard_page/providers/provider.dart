import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/api_services/admins_api.dart';
import '../../requests_page/models/user_details.dart';
import '../models/weekly_analytics.dart';
import 'state.dart';

final dashboardProvider = StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
  (ref) {
    final notifier = DashboardNotifier(ref)
      ..getChartJoinings()
      ..getChartEarnings()
      ..getNewEntrepreneursJoiningRequests();
    return notifier;
  },
);

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;
  DashboardNotifier(this.ref) : super(const DashboardState());

  void setState(DashboardState value) => state = value;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void update(DashboardState Function(DashboardState value) change) {
    final updated = change(state);
    setState(updated);
  }

  void changeJoiningChartDate(bool isNext) {
    final date = state.joiningChartStartDate ?? DateTime.now();
    final newDate = isNext ? date.add(const Duration(days: 7)) : date.subtract(const Duration(days: 7));
    setState(state.copyWith(joiningChartStartDate: newDate));
    getChartJoinings(newDate, newDate.add(const Duration(days: 7)));
  }

  void changeEarningChartDate(bool isNext) {
    final date = state.earningChartStartDate ?? DateTime.now();
    final newDate = isNext ? date.add(const Duration(days: 7)) : date.subtract(const Duration(days: 7));
    setState(state.copyWith(earningChartStartDate: newDate));
    getChartEarnings(newDate, newDate.add(const Duration(days: 7)));
  }

  Future<void> getNewEntrepreneursJoiningRequests() async {
    final entrepreneurs = await AdminsApi.getNewEntrepreneursJoiningRequests();
    setState(state.copyWith(entrepreneurs: state.entrepreneurs ?? entrepreneurs ?? <UserDetails>[]));
  }

  Future<void> getChartJoinings([DateTime? start, DateTime? end]) async {
    start = start ?? DateTime.now();
    end = end ?? start.add(const Duration(days: 7));
    final result = await AdminsApi.getChartJoinings(start.toString(), end.toString());
    setState(state.copyWith(joinings: result ?? state.joinings ?? <ChartJoiningModel>[]));
  }

  Future<void> getChartEarnings([DateTime? start, DateTime? end]) async {
    start = start ?? DateTime.now();
    end = end ?? start.add(const Duration(days: 7));
    final result = await AdminsApi.getChartEarnings(start.toString(), end.toString());
    setState(state.copyWith(earnings: result ?? state.earnings ?? <ChartEarningModel>[]));
  }
}
