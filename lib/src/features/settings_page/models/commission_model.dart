import 'package:freezed_annotation/freezed_annotation.dart';

part 'commission_model.freezed.dart';
part 'commission_model.g.dart';

@freezed
class CommissionModel with _$CommissionModel {
  const factory CommissionModel({
    String? id,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'created_by') String? createdBy,
    @Default(0.0) @JsonKey(name: 'commission_percentage') double commissionPercentage,
    @Default(0.0) @JsonKey(name: 'gst_percentage') double gstPercentage,
  }) = _CommissionModel;

  factory CommissionModel.fromJson(Map<String, dynamic> json) => _$CommissionModelFromJson(json);
}
