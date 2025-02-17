// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sizer/sizer.dart';
// import 'package:go_router/go_router.dart';

// import '../../../core/constants/kcolors.dart';
// import '../../../core/enums/enums.dart';
// import '../../../core/shared/shared.dart';
// import '../../../widgets/app_text.dart';
// import '../../../widgets/loading_indidactor.dart';
// import '../../../widgets/not_logged_in.dart';
// import '../../../widgets/profile_avatar.dart';
// import '../../../widgets/tab_indicator.dart';
// import '../../edit_profile_page/presentation/view/edit_profile_page.dart';
// import '../providers/provider.dart';
// import 'widgets/my_posts.dart';
// import 'widgets/services_tab.dart';
// import 'widgets/settings_drawer.dart';

// // ignore: constant_identifier_names
// enum ProfileTabs { Posts, Services }

// class ProfilePage extends ConsumerStatefulWidget {
//   final String? profileId;
//   const ProfilePage({super.key, this.profileId});

//   static const String route = "/profile";

//   @override
//   ConsumerState<ProfilePage> createState() => _ProfilePage2State();
// }

// class _ProfilePage2State extends ConsumerState<ProfilePage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final provider = ref.read(profileProvider.notifier);
//       provider.getUserDetails(widget.profileId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final profileId = ref.watch(profileProvider.select((value) => value.user?.id));

//     return Scaffold(
//       key: ref.read(profileProvider.notifier).scaffoldKey,
//       endDrawer: userId == profileId ? const SettingDrawer() : null,
//       appBar: AppBar(
//         title: const AppText(
//           "Profile",
//           fontSize: 20,
//           color: KColors.white,
//           fontWeight: FontWeight.w500,
//         ),
//         backgroundColor: KColors.purple,
//         centerTitle: false,
//         toolbarHeight: 60.px,
//         shape: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
//         actions: [
//           if (userId == profileId && widget.profileId == null)
//             CupertinoButton(
//               onPressed: ref.read(profileProvider.notifier).openEndDrawer,
//               padding: const EdgeInsets.only(),
//               child: const Icon(
//                 Icons.settings,
//                 color: KColors.white,
//               ),
//             ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: SafeArea(
//         child: NotificationListener<OverscrollIndicatorNotification>(
//           onNotification: (notification) {
//             notification.disallowIndicator();
//             return true;
//           },
//           child: Builder(builder: (context) {
//             if (!isLoggedIn) {
//               return const NotLoggedInWidget();
//             }
//             if (profileId == null) {
//               return const Center(
//                 child: LoadingIndicator(),
//               );
//             } else {
//               return NestedScrollView(
//                 headerSliverBuilder: (context, innerBoxIsScrolled) {
//                   return [
//                     Consumer(
//                       builder: (_, WidgetRef ref, __) {
//                         final user = ref.watch(profileProvider.select((value) => value.user));
//                         return SliverPadding(
//                           padding: const EdgeInsets.all(15),
//                           sliver: SliverList(
//                             delegate: SliverChildListDelegate([
//                               Row(
//                                 children: [
//                                   Stack(
//                                     clipBehavior: Clip.none,
//                                     children: [
//                                       Consumer(
//                                         builder: (_, WidgetRef ref, __) {
//                                           final photoUrl = ref.watch(
//                                             profileProvider.select((value) => value.user?.photoUrl),
//                                           );

//                                           return ProfileAvatar(
//                                             image: photoUrl ?? '',
//                                             scale: 80,
//                                             errorIconSize: 48,
//                                           );
//                                         },
//                                       ),
//                                       if (userId == profileId) ...[
//                                         Positioned(
//                                           right: -6,
//                                           bottom: -6,
//                                           child: CupertinoButton(
//                                             onPressed: () {
//                                               ref.read(profileProvider.notifier).uploadPhoto(context, ref);
//                                             },
//                                             padding: const EdgeInsets.only(),
//                                             child: Container(
//                                               width: 30,
//                                               height: 30,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(color: KColors.grey, width: 0.5),
//                                                 borderRadius: BorderRadius.circular(30),
//                                               ),
//                                               child: const Icon(
//                                                 Icons.edit,
//                                                 size: 18,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Consumer(
//                                       builder: (_, WidgetRef ref, __) {
//                                         final name = ref.watch(profileProvider.select((value) => value.user?.name));
//                                         return AppText(
//                                           name ?? '--',
//                                           fontWeight: FontWeight.w500,
//                                           height: 1.0,
//                                           fontSize: 16,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   if (userId == profileId) ...[
//                                     CupertinoButton(
//                                       onPressed: () {
//                                         final user = ref.read(profileProvider.select((value) => value.user));
//                                         context.pushNamed(EditProfilePage.route, extra: user);
//                                       },
//                                       padding: const EdgeInsets.only(),
//                                       child: Container(
//                                         width: 40,
//                                         height: 40,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: KColors.grey),
//                                           borderRadius: BorderRadius.circular(30),
//                                         ),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           color: KColors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                               Consumer(
//                                 builder: (_, WidgetRef ref, __) {
//                                   final about = ref.watch(profileProvider.select((value) => value.user?.about));
//                                   if (about == null || about.isEmpty) return const SizedBox(height: 20);

//                                   return Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(height: 20),
//                                       AppText(
//                                         about,
//                                         height: 1.4,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               if (user?.userType == UserType.ENTREPRENEUR || userId == user?.id) ...[
//                                 Row(
//                                   children: [
//                                     const Expanded(
//                                       flex: 4,
//                                       child: AppText(
//                                         "Phone Number",
//                                         color: KColors.grey,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 6,
//                                       child: AppText(
//                                         user?.phone ?? 'NA',
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                               const SizedBox(height: 5),
//                               Row(
//                                 children: [
//                                   const Expanded(
//                                     flex: 4,
//                                     child: AppText(
//                                       "Email",
//                                       color: KColors.grey,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 6,
//                                     child: AppText(
//                                       user?.email ?? 'NA',
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               if (user?.userType == UserType.ENTREPRENEUR) ...[
//                                 const SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     const Expanded(
//                                       flex: 4,
//                                       child: AppText(
//                                         "Work Experience",
//                                         color: KColors.grey,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 6,
//                                       child: AppText(
//                                         user?.totalWorkExperience.toString() ?? "NA",
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Row(
//                                   children: [
//                                     const Expanded(
//                                       flex: 4,
//                                       child: AppText(
//                                         "Expertises",
//                                         color: KColors.grey,
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 6,
//                                       child: AppText(
//                                         user?.expertises.join(", ") ?? "NA",
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ]
//                             ]),
//                           ),
//                         );
//                       },
//                     ),
//                     const SliverToBoxAdapter(child: Divider()),
//                   ];
//                 },
//                 body: Consumer(
//                   builder: (_, WidgetRef ref, __) {
//                     final userType = ref.watch(profileProvider.select((value) => value.user?.userType));
//                     if (userType == UserType.USER) return const SizedBox();

//                     return DefaultTabController(
//                       length: [ProfileTabs.Posts, ProfileTabs.Services].length,
//                       child: Column(
//                         children: [
//                           TabBar(
//                             indicatorWeight: 0.001,
//                             labelPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                             overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//                             splashBorderRadius: BorderRadius.circular(25),
//                             indicator: const MaterialIndicator(),
//                             labelStyle: const TextStyle(
//                               fontSize: 16,
//                               fontFamily: "Poppins",
//                               fontWeight: FontWeight.w500,
//                               color: KColors.purple,
//                             ),
//                             tabs: ProfileTabs.values.map((tab) => Tab(text: tab.name)).toList(),
//                           ),
//                           const Expanded(
//                             child: TabBarView(
//                               children: [
//                                 MyPostsTab(),
//                                 ServicesTab(),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }
