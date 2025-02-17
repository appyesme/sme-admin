import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/shared_pref_service /shared_pref_service.dart';
import '../../utils/string_extension.dart';
import '../enums/enums.dart';
import 'shared.dart';

final unreadNotificationProvider = StateProvider.autoDispose<int>((ref) => 0);

final loggedUserProvider = ChangeNotifierProvider((ref) => UserInfoNotifier()..checkAuthenticated());

class UserInfoNotifier extends ChangeNotifier {
  bool isLoggedIn = false;

  void checkAuthenticated([String? value]) {
    final token = value ?? PrefService.getToken();

    if (token == null) {
      return logOut();
    } else {
      PrefService.setToken(token);
      authToken = token;
      final decodedJWT = token.decodeJWTAndGetUserId();
      userId = decodedJWT?.id;
      userType = decodedJWT?.type.getType;
      isLoggedIn = userType == UserType.ADMIN && userId != null;
    }
    notifyListeners();
  }

  void logOut() {
    isLoggedIn = false;
    authToken = null;
    userId = null;
    userType = null;
    sharedPref.clear();
    // context.goNamed(AuthPage.route);
    notifyListeners();
  }
}
