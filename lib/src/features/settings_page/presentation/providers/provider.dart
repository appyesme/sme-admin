import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final settingsProvider = StateNotifierProvider.autoDispose<SettingsNotifier, SettingsState>(
  (ref) {
    final notifier = SettingsNotifier();
    ref.onDispose(() => notifier.tagsTextController.dispose());
    return notifier;
  },
);

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState());

  void setState(SettingsState value) => state = value;

  final TextEditingController tagsTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
}
