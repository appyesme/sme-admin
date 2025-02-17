import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/filter_model.dart';
import '../models/user_model.dart';

part 'state.freezed.dart';

@freezed
class PlatformUsersState with _$PlatformUsersState {
  const factory PlatformUsersState({
    @Default(false) bool searching,
    @Default(true) bool showEntrepreneurs,
    List<UserModel>? users,
    @Default(FilterModel.defaultValue) FilterModel filter,
  }) = _PlatformUsersState;
}
