import 'package:flutter/foundation.dart';

class FiltrationController<T> extends ChangeNotifier {
  final String Function() getFilter;
  final List<T> Function() getUnFilteredItems;
  final String Function(T t) toScope;

  String _filter = "";

  FiltrationController({
    required this.getUnFilteredItems,
    required this.getFilter,
    required this.toScope,
  });

  bool isPass(String scope) {
    _filter = getFilter().trim();

    if (_filter.isEmpty) return true;

    final keywords = _filter.toLowerCase().split(" ");

    keywords.removeWhere((x) => x.isEmpty);

    scope = scope.toString();

    for (var keyword in keywords) {
      if (scope.contains(keyword)) return true;
    }

    return false;
  }

  bool _itemPassed(T t) {
    final String scope = toScope(t);
    return isPass(scope);
  }

  List<T> get filteredItems {
    return getUnFilteredItems().where(_itemPassed).toList();
  }
}
