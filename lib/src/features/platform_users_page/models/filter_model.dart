import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_model.freezed.dart';

@freezed
class FilterModel with _$FilterModel {
  const FilterModel._();

  static const FilterModel defaultValue = FilterModel();

  const factory FilterModel({
    @Default([]) List<String> types,
    @Default([]) List<String> locations,
    @Default([]) List<String> difficultyLevels,
    @Default([]) List<String> costs,
  }) = _FilterModel;

  bool get isEmpty => types.isEmpty && locations.isEmpty && difficultyLevels.isEmpty && costs.isEmpty;
}
