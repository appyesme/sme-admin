// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarProvider = StateNotifierProvider.autoDispose<NavNotifier, NavType>((ref) => NavNotifier());

enum NavType {
  Dashboard,
  Requests,
  Payments,
  Users;

  IconData get icon {
    if (this == Dashboard) return Icons.dashboard;
    if (this == Requests) return Icons.new_label;
    if (this == Payments) return Icons.currency_rupee;
    if (this == Users) return Icons.people;
    throw Exception("Invalid type");
  }
}

class NavNotifier extends StateNotifier<NavType> {
  NavNotifier() : super(NavType.Dashboard);

  void setState(NavType value) => state = value;
  void changeNavTab(int index) => setState(NavType.values.elementAt(index));
}
