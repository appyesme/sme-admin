import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/enums/enums.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? name,
    String? email,
    String? about,
    @JsonKey(name: 'user_type') UserType? userType,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'aadhar_number') String? aadharNumber,
    @JsonKey(name: 'pan_number') String? panNumber,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'verified_at') String? verifiedAt,
    @JsonKey(name: 'total_work_experience') int? totalWorkExperience,
    @Default(false) bool favourited,
    @Default([]) List<String> expertises,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
