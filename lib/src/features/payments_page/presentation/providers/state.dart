import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/payment_clearance_model.dart';

part 'state.freezed.dart';

@freezed
class PaymentsState with _$PaymentsState {
  const factory PaymentsState({
    List<PaymentClearanceEntrepreneur>? entrepreneurs,
    PaymentClearanceEntrepreneur? clearingTo,
  }) = _PaymentsState;
}
