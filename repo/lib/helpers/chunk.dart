import 'dart:math';

List<List<T>> chunk<T>(List<T> ls, int chunkSize) {
  var chunks = <List<T>>[];
  for (var i = 0; i < ls.length; i += chunkSize) {
    chunks.add(ls.sublist(i, min(i + chunkSize, ls.length)));
  }
  return chunks;
}
