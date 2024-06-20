import 'package:flutter/material.dart';
import 'package:semper_web/helpers/page_config.dart';

class PaginationController extends ChangeNotifier {
  final VoidCallback? onPageChanged;
  final int Function() len;
  final int itemsPerPage;

  PaginationController({
    this.onPageChanged,
    required this.len,
    this.itemsPerPage = 10,
  });

  int _currentPage = 1;

  int get currentPage => _currentPage;

  set currentPage(int currentPage) {
    _currentPage = currentPage;
    onPageChanged?.call();
  }

  PageConfig get pageConfig => PageConfig(
        len: len(),
        currentPage: currentPage,
        itemsPerPage: itemsPerPage,
      );

  void onNext() {
    if (currentPage * itemsPerPage >= len()) return;
    currentPage = currentPage + 1;
  }

  void onBack() {
    if (currentPage <= 1) return;
    currentPage = currentPage - 1;
  }
}
