import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/core/constants/kcolors.dart';
import 'src/core/router/route_config.dart';
import 'src/core/shared/shared.dart';
import 'src/services/shared_pref_service /shared_pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  sharedPref = await SharedPreferences.getInstance();
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PrefService.setToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDMxMzkxMzAsImlhdCI6MTc0MDU0NzEzMCwicGhvbmVfbnVtYmVyIjoiKzkxOTE2NDgyNTE4OSIsInN1YiI6IjVjMmIzMzIzLTVjMWUtNGQxZi1iZTAyLWU5OWNhMTZhYTNkYyIsInVzZXJfdHlwZSI6IkFETUlOIn0.zlUxlWp7rKvyRskJmCKHZiolxD7oAyiknpIH3UaOiY8");
    final routerConfig = ref.watch(goRouterProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        title: appName,
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: KColors.bgColor,
          primaryColor: Colors.black,
          primarySwatch: Colors.blueGrey,
          fontFamily: "Poppins",
        ),
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: OKToast(child: child!),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          );
        },
      ),
    );
  }
}
