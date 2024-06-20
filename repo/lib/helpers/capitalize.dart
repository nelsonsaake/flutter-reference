String capitalize(String s) {
  s = s.trim();
  return s[0].toUpperCase() + s.substring(1);
}

String capitalize2([String? s = ""]) {
  s ??= "";
  var ls = s.trim().split(" ");
  ls = ls.where((v) => v.trim().isNotEmpty).toList();
  return [
    for (var v in ls) capitalize(v),
  ].join(" ");
}
