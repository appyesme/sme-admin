import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_analytics.freezed.dart';
part 'weekly_analytics.g.dart';

@freezed
class ChartJoiningModel with _$ChartJoiningModel {
  const factory ChartJoiningModel({
    String? day,
    @Default(0) int count,
  }) = _ChartJoiningModel;

  factory ChartJoiningModel.fromJson(Map<String, dynamic> json) => _$ChartJoiningModelFromJson(json);
}

@freezed
class ChartEarningModel with _$ChartEarningModel {
  const factory ChartEarningModel({
    String? day,
    @Default(0.0) double earnings,
  }) = _ChartEarningModel;

  factory ChartEarningModel.fromJson(Map<String, dynamic> json) => _$ChartEarningModelFromJson(json);
}
