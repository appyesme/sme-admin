import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/api_services/admins_api.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/dialog/dailog_helper.dart';
import '../../models/payment_clearance_model.dart';
import 'state.dart';

final paymentsProvider = StateNotifierProvider.autoDispose<PaymentsNotifier, PaymentsState>(
  (ref) {
    final notifier = PaymentsNotifier(ref)..getPaymentClearanceEntrepreneurs();
    return notifier;
  },
);

class PaymentsNotifier extends StateNotifier<PaymentsState> {
  final Ref ref;
  PaymentsNotifier(this.ref) : super(const PaymentsState());

  void setState(PaymentsState value) => state = value;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void update(PaymentsState Function(PaymentsState value) change) {
    final updated = change(state);
    setState(updated);
  }

  void setClearEntrepreneurPayment(PaymentClearanceEntrepreneur entrepreneur) {
    final updated = state.copyWith(clearingTo: entrepreneur);
    scaffoldKey.currentState?.openEndDrawer();
    setState(updated);

    getClearingPaymentDetails(entrepreneur.id!);
  }

  Future<void> getPaymentClearanceEntrepreneurs() async {
    final entrepreneurs = await AdminsApi.getPaymentClearanceEntrepreneurs();
    setState(state.copyWith(entrepreneurs: entrepreneurs ?? state.entrepreneurs ?? <PaymentClearanceEntrepreneur>[]));
  }

  Future<void> getClearingPaymentDetails(String entrepreneurId) async {
    final details = await AdminsApi.getClearingPaymentDetails(entrepreneurId);
    final updated = state.clearingTo?.copyWith(
      totalAmountToClear: details?.totalAmountToClear,
      paymentIds: details?.paymentIds ?? [],
    );
    setState(state.copyWith(clearingTo: updated));
  }

  Future<void> markAsCleared(BuildContext context, PaymentClearanceEntrepreneur details) async {
    DialogHelper.showloading(context);
    final result = await AdminsApi.markAsPaymentCleared(details.id!, details.paymentIds);
    DialogHelper.pop(context);

    if (result == true) {
      DialogHelper.pop(context); // Close drawer
      final updated = state.entrepreneurs?.where((user) => user.id != details.id).toList();
      setState(state.copyWith(entrepreneurs: updated));
      Toast.success("Payment cleared successfully");
    }
  }
}
