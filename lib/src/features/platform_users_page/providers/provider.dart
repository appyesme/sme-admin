import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/constants/pagination_limit_count.dart';
import '../../../services/api_services/admins_api.dart';
import '../../../utils/debouncer.dart';
import '../models/filter_model.dart';
import '../models/user_model.dart';
import 'state.dart';

final platformUsersProvider = StateNotifierProvider.autoDispose<PlatformUsersNotifier, PlatformUsersState>(
  (ref) {
    final notifier = PlatformUsersNotifier(ref);
    notifier.pagingUserController.addPageRequestListener(notifier.loadMoreUsers);

    ref.onDispose(() {
      notifier.pagingUserController.dispose();
      notifier.searchController.dispose();
    });
    return notifier;
  },
);

class PlatformUsersNotifier extends StateNotifier<PlatformUsersState> {
  final Ref ref;
  PlatformUsersNotifier(this.ref) : super(const PlatformUsersState());

  TextEditingController searchController = TextEditingController();

  void setState(PlatformUsersState value) => mounted ? state = value : null;
  void update(PlatformUsersState Function(PlatformUsersState value) update) => setState(update(state));

  Future<void> init({bool refresh = false}) async {
    searchController.clear();
    pagingUserController.refresh();
    setState(state.copyWith(filter: refresh ? FilterModel.defaultValue : state.filter, searching: true));
    searchDebouncer.run(refreshUsers);
  }

  ///
  ///
  ///
  ///
  ///
  final pagingUserController = PagingController<int, UserModel>(firstPageKey: 0);
  final searchDebouncer = Debouncer(milliseconds: 600);

  String? searchQuery;
  void onSearchChanged(String? query) {
    searchQuery = query;
    if (!state.searching) setState(state.copyWith(searching: true));

    pagingUserController.refresh();

    searchDebouncer.run(() {
      refreshUsers();
      setState(state.copyWith(searching: false));
    });
  }

  Future<void> refreshUsers() async {
    var users = await AdminsApi.getPlatformUsers(query: searchQuery, filter: state.filter, page: 0);
    setState(state.copyWith(users: users, searching: false));

    late PagingState<int, UserModel> pagingState;
    final isLastPage = users.length < PaginationLimitCount.platformUsers;

    if (isLastPage) {
      pagingState = PagingState(nextPageKey: null, itemList: users);
    } else {
      pagingState = PagingState(nextPageKey: 1, itemList: users);
    }

    pagingUserController.value = pagingState;
  }

  void loadMoreUsers(int page) {
    searchDebouncer.run(() async {
      // if (searchQuery == null) return pagingUserController.refresh();
      var users = await AdminsApi.getPlatformUsers(query: searchQuery, filter: state.filter, page: page);

      final isLastPage = users.length < PaginationLimitCount.platformUsers;
      if (isLastPage) {
        pagingUserController.appendLastPage(users);
      } else {
        final nextPageKey = page + 1;
        pagingUserController.appendPage(users, nextPageKey);
      }
    });
  }
}
