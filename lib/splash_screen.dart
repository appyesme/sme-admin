// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'core/constants/kcolors.dart';
// import 'core/shared/auth_handler.dart';
// import 'widgets/app_text.dart';

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({super.key});

//   static const route = "/splash";

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: KColors.secondary,
//       body: TweenAnimationBuilder(
//         tween: Tween<double>(begin: 15, end: 100),
//         duration: const Duration(seconds: 1),
//         curve: Curves.easeIn,
//         onEnd: () => ref.read(loggedUserProvider).checkAuthenticated(),
//         builder: (context, value, child) {
//           return Stack(
//             children: [
//               Center(
//                 child: ScaleTransition(
//                   scale: AlwaysStoppedAnimation(value),
//                   child: Container(
//                     height: value,
//                     width: value,
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       color: Color.fromRGBO(255, 255, 255, 0.05),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: ScaleTransition(
//                   scale: AlwaysStoppedAnimation(value),
//                   child: Container(
//                     height: value - 15,
//                     width: value - 15,
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       color: Color.fromRGBO(0, 0, 0, 0.05),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//               ),
//               const Center(
//                 child: SizedBox(
//                   height: 150,
//                   width: 150,
//                   child: AppText(
//                     appName,
//                     color: Colors.white,
//                     textAlign: TextAlign.center,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 36,
//                     height: 1.0,
//                   ),
//                 ),
//               ),
//               const Positioned(
//                 bottom: 60,
//                 left: 0,
//                 right: 0,
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(
//                         strokeCap: StrokeCap.round,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
