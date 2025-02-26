import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../services/api_services/admins_api.dart';
import '../../../../utils/custom_toast.dart';
import 'state.dart';

final settingsProvider = StateNotifierProvider.autoDispose<SettingsNotifier, SettingsState>(
  (ref) {
    final notifier = SettingsNotifier()..getCommissionDetails();
    ref.onDispose(notifier.dispose);
    return notifier;
  },
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void setState(SettingsState value) => state = value;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commissionTextController = TextEditingController();
  final TextEditingController gstTextController = TextEditingController();

  @override
  void dispose() {
    commissionTextController.dispose();
    gstTextController.dispose();
    super.dispose();
  }

  Future<void> getCommissionDetails() async {
    final commission = await AdminsApi.getCommissionDetails();
    if (commission != null) {
      commissionTextController.text = commission.commissionPercentage.toString();
      gstTextController.text = commission.gstPercentage.toString();

      setState(state.copyWith(commission: commission));
    }
  }

  Future<void> updateCommissionDetails(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final commission = await AdminsApi.updateCommissionDetails(
        double.tryParse(commissionTextController.text) ?? 0.0,
        double.tryParse(gstTextController.text) ?? 0.0,
      );
      if (commission != null) {
        Toast.success("Commission details updated successfully");
        setState(state.copyWith(commission: commission));
        context.pop();
      }
    }
  }
}
