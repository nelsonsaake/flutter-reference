import 'package:flutter/material.dart';

class ElectionStatus {
  final String label;
  final Color color;

  const ElectionStatus._internal({
    this.color = Colors.transparent,
    this.label = "",
  });

  static const ElectionStatus inProgress = ElectionStatus._internal(
    label: "In Progress",
    color: Color(0xffFFC700),
  );

  static const ElectionStatus completed = ElectionStatus._internal(
    label: "Completed",
    color: Color(0xff4AC99B),
  );

  static const ElectionStatus cancelled = ElectionStatus._internal(
    label: "Cancelled",
    color: Color(0xffF45725),
  );

  static const ElectionStatus pending = ElectionStatus._internal(
    label: "Pending",
    color: Color(0xff70B6F6),
  );
}
