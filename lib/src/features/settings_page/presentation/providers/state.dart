import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/commission_model.dart';

part 'state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    CommissionModel? commission,
  }) = _SettingsState;
}
