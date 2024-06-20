List<T> pop<T>(List<T> ls, [int count = 1]) {
    final res = <T>[];

    for (int i = 0; i < count; i++) {
      if (ls.isNotEmpty) {
        res.add(ls.first);
        ls.removeAt(0);
      } else {
        break;
      }
    }

    return res;
  }