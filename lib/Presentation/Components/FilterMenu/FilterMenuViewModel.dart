import 'package:flutter/foundation.dart';
import 'package:rmcharactersappfluttercupertino/Model/Filter.dart';

class FilterMenuViewModel extends ChangeNotifier {
  bool _isFilterMenuOpen;
  Filter filter;
  Function(Filter) onFilterChanged;

  FilterMenuViewModel({
    required bool isFilterMenuOpen,
    required this.filter,
    required this.onFilterChanged,
  }) : _isFilterMenuOpen = isFilterMenuOpen;

  bool get isFilterMenuOpen => _isFilterMenuOpen;

  set isFilterMenuOpen(bool value) {
    _isFilterMenuOpen = value;
    notifyListeners();
  }

  void updateFilter(Filter newFilter) {
    filter = newFilter;
    onFilterChanged(filter);
    notifyListeners();
  }
}
