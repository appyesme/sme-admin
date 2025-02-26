import 'package:flutter/foundation.dart';

import '../../core/api/api_helper.dart';
import '../../core/constants/pagination_limit_count.dart';
import '../../features/dashboard_page/models/weekly_analytics.dart';
import '../../features/payments_page/models/payment_clearance_model.dart';
import '../../features/platform_users_page/models/filter_model.dart';
import '../../features/platform_users_page/models/user_model.dart';
import '../../features/requests_page/models/user_details.dart';
import '../../features/settings_page/models/commission_model.dart';
import '../../utils/custom_toast.dart';

@immutable
abstract class AdminsApi {
  static Future<List<UserDetails>?> getNewEntrepreneursJoiningRequests() async {
    String path = "/admin/users/joining-requests";
    final response = await ApiHelper.get(path);

    return response.fold<List<UserDetails>?>(
      (error) => Toast.failure(error.message),
      (success) => List.from(success.data ?? []).map((e) => UserDetails.fromJson(e)).toList(),
    );
  }

  static Future<UserDetails?> approveOrRejectEntrepreneur(String joiningRequestorId, bool approvalStatus) async {
    String path = "/admin/users/$joiningRequestorId/approval";
    final response = await ApiHelper.put(path, queryParams: {"approval_status": approvalStatus});

    return response.fold<UserDetails?>(
      (error) => Toast.failure(error.message),
      (success) => UserDetails.fromJson(success.data),
    );
  }

  static Future<List<PaymentClearanceEntrepreneur>?> getPaymentClearanceEntrepreneurs() async {
    String path = "/admin/payments/clearance-entrepreneurs";
    final response = await ApiHelper.get(path);

    return response.fold<List<PaymentClearanceEntrepreneur>?>(
      (error) => Toast.failure(error.message),
      (success) => List.from(success.data ?? []).map((e) => PaymentClearanceEntrepreneur.fromJson(e)).toList(),
    );
  }

  static Future<PaymentClearanceEntrepreneur?> getClearingPaymentDetails(String entrepreneurId) async {
    String path = "/admin/payments/status/clear";
    final response = await ApiHelper.get(path, queryParams: {"entrepreneur_id": entrepreneurId});

    return response.fold<PaymentClearanceEntrepreneur?>(
      (error) => Toast.failure(error.message),
      (success) => PaymentClearanceEntrepreneur.fromJson(success.data),
    );
  }

  static Future<bool?> markAsPaymentCleared(String entrepreneurId, List<String> paymentIds) async {
    String path = "/admin/payments/status/clear";
    final response = await ApiHelper.put(
      path,
      queryParams: {"entrepreneur_id": entrepreneurId},
      body: paymentIds,
    );
    return response.fold<bool?>((error) => Toast.failure(error.message), (success) => true);
  }

  static Future<List<UserModel>> getPlatformUsers({
    String? query,
    FilterModel filter = FilterModel.defaultValue,
    int page = 0,
  }) async {
    String path = "/admin/users";
    final response = await ApiHelper.get(
      path,
      queryParams: {
        "search_query": query ?? '',
        "page": page,
        "limit": PaginationLimitCount.platformUsers,
      },
    );

    return response.fold<List<UserModel>>(
      (error) => <UserModel>[],
      (success) => List.from(success.data ?? []).map((e) => UserModel.fromJson(e)).toList(),
    );
  }

  static Future<List<ChartJoiningModel>?> getChartJoinings(String start, String end) async {
    String path = "/admin/analytics/joinings";
    final response = await ApiHelper.get(path, queryParams: {"start_date": start, "end_date": end});

    return response.fold<List<ChartJoiningModel>?>(
      (error) => Toast.failure(error.message),
      (success) => List.from(success.data ?? []).map((e) => ChartJoiningModel.fromJson(e)).toList(),
    );
  }

  static Future<List<ChartEarningModel>?> getChartEarnings(String start, String end) async {
    String path = "/admin/analytics/earnings";
    final response = await ApiHelper.get(path, queryParams: {"start_date": start, "end_date": end});

    return response.fold<List<ChartEarningModel>?>(
      (error) => Toast.failure(error.message),
      (success) => List.from(success.data ?? []).map((e) => ChartEarningModel.fromJson(e)).toList(),
    );
  }

  static Future<CommissionModel?> getCommissionDetails() async {
    String path = "/admin/commissons";
    final response = await ApiHelper.get(path);

    return response.fold<CommissionModel?>(
      (error) => Toast.failure(error.message),
      (success) => CommissionModel.fromJson(success.data),
    );
  }

  static Future<CommissionModel?> updateCommissionDetails(double commissionPercentage, double gstPercentage) async {
    String path = "/admin/commissons";
    final response = await ApiHelper.post(
      path,
      body: {
        "commission_percentage": commissionPercentage,
        "gst_percentage": gstPercentage,
      },
    );

    return response.fold<CommissionModel?>(
      (error) => Toast.failure(error.message),
      (success) => CommissionModel.fromJson(success.data),
    );
  }
}
