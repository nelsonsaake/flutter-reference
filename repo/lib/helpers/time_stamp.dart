String timeStamp() {
  final h = DateTime.now().hour;
  final m = DateTime.now().minute;
  final s = DateTime.now().second;
  final dd = DateTime.now().day;
  final mm = DateTime.now().month;
  final yy = DateTime.now().year;

  return "$h.$m.$s..$dd.$mm.$yy";
}