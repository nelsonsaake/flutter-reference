import 'dart:math';

class PageConfig {
  int from = 0, to = 0, count = 0;
  int fromIndex = 0, toIndex = 0;

  PageConfig({
    required int len,
    required int currentPage,
    required int itemsPerPage,
  }) {
    if (len == 0) return;
    if (currentPage < 1) return;
    if ((currentPage - 1) * itemsPerPage > len - 1) return;

    fromIndex = (currentPage - 1) * itemsPerPage;
    from = fromIndex + 1;

    toIndex = min(fromIndex + itemsPerPage, len);
    to = toIndex;

    count = len;
  }
}
