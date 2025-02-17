import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile_page/models/user_details.dart';
import '../models/weekly_analytics.dart';

part 'state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    DateTime? joiningChartStartDate,
    DateTime? earningChartStartDate,

    //
    List<ChartJoiningModel>? joinings,
    List<ChartEarningModel>? earnings,
    List<UserDetails>? entrepreneurs,
  }) = _DashboardState;
}
