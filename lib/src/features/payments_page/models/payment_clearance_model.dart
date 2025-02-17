import 'package:freezed_annotation/freezed_annotation.dart';

import 'bank_account_model.dart';

part 'payment_clearance_model.freezed.dart';
part 'payment_clearance_model.g.dart';

@freezed
class PaymentClearanceEntrepreneur with _$PaymentClearanceEntrepreneur {
  const factory PaymentClearanceEntrepreneur({
    String? id,
    String? name,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'last_cleared_at') String? lastClearedAt,
    @JsonKey(name: 'total_amount_to_clear') double? totalAmountToClear,
    @JsonKey(name: 'payment_ids') @Default([]) List<String> paymentIds,
    @JsonKey(name: 'bank_account') BankAccountModel? bankAccount,
  }) = _PaymentClearanceEntrepreneur;

  factory PaymentClearanceEntrepreneur.fromJson(Map<String, dynamic> json) =>
      _$PaymentClearanceEntrepreneurFromJson(json);
}
