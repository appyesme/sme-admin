import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/view/auth_page.dart';
import '../../features/landing_page/view/landing_page.dart';
import '../shared/auth_handler.dart';
import 'route_not_found_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider(
  (ref) {
    return GoRouter(
      // initialLocation: SplashScreen.route,
      navigatorKey: navigatorKey,
      // observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
      errorBuilder: (context, state) => const RouteNotFoundPage(),
      refreshListenable: ref.read(loggedUserProvider),
      redirect: (context, state) {
        final isLoggedIn = ref.read(loggedUserProvider).isLoggedIn;
        final isLoggingIn = state.matchedLocation == AuthPage.route;

        if (!isLoggedIn) return isLoggingIn ? null : AuthPage.route;
        if (isLoggingIn) return LandingPage.route;
        return null;
      },

      // redirect: (context, state) {
      //   final isLoggedIn = ref.read(loggedUserProvider).isLoggedIn;
      //   final isLoggingIn = state.matchedLocation == AuthPage.route;

      //   if (!isLoggedIn && !isLoggingIn) return AuthPage.route;
      //   if (isLoggingIn && isLoggedIn) return LandingPage.route;
      //   return null; // No redirect needed
      // },
      routes: [
        GoRoute(
          name: AuthPage.route,
          path: AuthPage.route,
          pageBuilder: (context, state) {
            return CupertinoPage(key: state.pageKey, child: const AuthPage());
          },
        ),
        GoRoute(
          name: LandingPage.route,
          path: LandingPage.route,
          pageBuilder: (context, state) {
            return CupertinoPage(key: state.pageKey, child: const LandingPage());
          },
        ),
      ],
    );
  },
);
