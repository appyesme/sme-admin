// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../core/enums/enums.dart';
// import '../../../core/shared/shared.dart';
// import '../../../services/api_services/posts_apis.dart';
// import '../../../services/api_services/services_api.dart';
// import '../../../services/api_services/users_apis.dart';
// import '../../../services/file_service/file_service.dart';
// import '../../../utils/crop_image_diolog.dart';
// import '../../../utils/custom_toast.dart';
// import '../../../utils/dailog_helper.dart';
// import '../../add_post_page/models/post_model.dart';
// import '../../services_list_page/models/service_model.dart';
// import 'state.dart';

// final profileProvider = StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
//   (ref) => ProfileNotifier(ref),
// );

// class ProfileNotifier extends StateNotifier<ProfileState> {
//   final Ref ref;
//   ProfileNotifier(this.ref) : super(const ProfileState());

//   void setState(ProfileState value) => state = value;

//   void update(ProfileState Function(ProfileState state) value) {
//     final updated = value(state);
//     setState(updated);
//   }

//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   void openEndDrawer() => scaffoldKey.currentState?.openEndDrawer();

//   void getUserPosts(String? profileId) async {
//     final posts = await PostsApi.getPosts(profileID: profileId ?? userId);
//     final updated = state.copyWith(posts: posts ?? state.posts ?? <PostModel>[]);
//     setState(updated);
//   }

//   void getServices(String? profileId) async {
//     final services = await ServicesApi.getServices(profileID: profileId ?? userId);
//     final updated = state.copyWith(services: services ?? state.services ?? <ServiceModel>[]);
//     setState(updated);
//   }

//   Future<void> getUserDetails(String? profileId) async {
//     if ((profileId ?? userId) == null) return;
//     final user = await UsersApi.getUserDetails(profileId ?? userId!);
//     setState(state.copyWith(user: user));
//     if (user?.userType == UserType.ENTREPRENEUR) {
//       getUserPosts(profileId);
//       getServices(profileId);
//     }
//   }

//   Future<void> uploadPhoto(BuildContext context, WidgetRef ref) async {
//     final photo = await FileServiceX.pickImage();
//     if (photo == null) return;
//     final cropeed = await cropImageDialog(context, photo);
//     if (cropeed == null) return;

//     DialogHelper.showloading(context);
//     final uploadedPhotoUrl = await UsersApi.uploadPhoto(photo: cropeed);
//     DialogHelper.pop(context);
//     if (uploadedPhotoUrl == null) return Toast.failure("Unable to upload photo");

//     final updated = state.user?.copyWith(photoUrl: uploadedPhotoUrl);
//     setState(state.copyWith(user: updated));
//   }
// }
