import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../profile_page/models/user_details.dart';

part 'state.freezed.dart';

@freezed
class NewJoiningRequestState with _$NewJoiningRequestState {
  const factory NewJoiningRequestState({
    List<UserDetails>? entrepreneurs,
    UserDetails? verifyTo,
  }) = _NewJoiningRequestState;
}
