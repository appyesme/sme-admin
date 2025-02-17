import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details.freezed.dart';
part 'user_details.g.dart';

@freezed
class UserDetails with _$UserDetails {
  const factory UserDetails({
    String? id,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'user_type') String? userType,
    @JsonKey(name: 'verified_at') String? verifiedAt,
    String? name,
    String? email,
    @JsonKey(name: 'photo_url') String? photoUrl,
    @JsonKey(name: 'expertises') List<String>? expertises,
    @JsonKey(name: 'total_work_experience') int? totalWorkExperience,
    @JsonKey(name: 'documents') List<String>? documents,
    @Default(false) bool verified,
    String? about,
    @JsonKey(name: 'aadhar_number') String? aadharNumber,
    @JsonKey(name: 'pan_number') String? panNumber,
  }) = _UserDetails;

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
}
