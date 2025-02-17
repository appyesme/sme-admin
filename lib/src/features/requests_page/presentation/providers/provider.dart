import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/api_services/admins_api.dart';
import '../../../../utils/custom_toast.dart';
import '../../../../utils/dialog/dailog_helper.dart';
import '../../../profile_page/models/user_details.dart';
import 'state.dart';

final requestsProvider = StateNotifierProvider.autoDispose<NewJoiningRequestNotifier, NewJoiningRequestState>(
  (ref) {
    final notifier = NewJoiningRequestNotifier(ref)..getNewEntrepreneursJoiningRequests();
    return notifier;
  },
);

class NewJoiningRequestNotifier extends StateNotifier<NewJoiningRequestState> {
  final Ref ref;
  NewJoiningRequestNotifier(this.ref) : super(const NewJoiningRequestState());

  void setState(NewJoiningRequestState value) => state = value;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void update(NewJoiningRequestState Function(NewJoiningRequestState value) change) {
    final updated = change(state);
    setState(updated);
  }

  void setVerifyingToUser(UserDetails faq) {
    final updated = state.copyWith(verifyTo: faq);
    scaffoldKey.currentState?.openEndDrawer();
    setState(updated);
  }

  Future<void> getNewEntrepreneursJoiningRequests() async {
    final entrepreneurs = await AdminsApi.getNewEntrepreneursJoiningRequests();
    setState(state.copyWith(entrepreneurs: state.entrepreneurs ?? entrepreneurs ?? <UserDetails>[]));
  }

  Future<void> takeAction(BuildContext context, String joiningRequestorId, bool approvalStatus) async {
    DialogHelper.showloading(context);
    final result = await AdminsApi.approveOrRejectEntrepreneur(joiningRequestorId, approvalStatus);
    DialogHelper.pop(context);

    if (result?.id != null) {
      final updated = state.entrepreneurs?.map((user) {
        if (user.id != joiningRequestorId) return user;
        return user.copyWith(verified: approvalStatus, verifiedAt: result!.verifiedAt);
      });

      setState(state.copyWith(entrepreneurs: updated?.toList()));
      DialogHelper.pop(context); // Close drawer
      Toast.success(approvalStatus ? "Application approved" : "Application rejected");
    }
  }
}
