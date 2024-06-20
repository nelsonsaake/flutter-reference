import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/extensions/widget_list.dart';
import 'package:semper_web/styles/input_styles.dart';
import 'package:semper_web/widgets/text/div.dart';

class DateInput extends StatefulWidget {
  final String? label;
  final DateTime? dateTime;
  final Function(DateTime dt)? onDateSelected;

  const DateInput({
    Key? key,
    this.label,
    this.dateTime,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  // there is a lifecycle issue here
  late DateTime? _dateTime = widget.dateTime;

  DateTime get dateTime {
    return _dateTime ?? widget.dateTime ?? DateTime.now();
  }

  set dateTime(DateTime dt) {
    _dateTime = dt;
    widget.onDateSelected?.call(dateTime);
  }

  DateTime merge(DateTime dt, TimeOfDay t) {
    return DateTime(dt.year, dt.month, dt.day, t.hour, t.minute);
  }

  TimeOfDay get time => TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);

  DateTime get date => dateTime;

  ThemeData get theme {
    return Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.green, // header background color
        onPrimary: Colors.white, // header text color
        onSurface: AppColors.green, // body text color
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.red, // button text color
        ),
      ),
    );
  }

  static final firstDateTime =
      DateTime.now().subtract(const Duration(days: 365));
  static final lastDateTime = DateTime.now().add(const Duration(days: 365));

  Future _selectDate() {
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: firstDateTime,
      lastDate: lastDateTime,
      initialEntryMode: DatePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(data: theme, child: child!);
      },
    ).then((date) {
      if (date == null) return;
      setState(() => dateTime = merge(date, time));
    });
  }

  Future _selectTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dateTime),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(data: theme, child: child!);
      },
    ).then((time) {
      if (time == null) return;
      setState(() => dateTime = merge(date, time));
    });
  }

  void _selectDateAndTime() {
    _selectDate().then((value) => _selectTime());
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("[_MyDatePickerState.build] ${widget.dateTime.toString()}");
    final date = DateFormat("dd MMM, y").format(dateTime);
    final time = DateFormat("jm").format(dateTime);

    return Container(
      constraints: InputStyles.constraints,
      decoration: InputStyles.decoration,
      child: TextButton(
        onPressed: _selectDateAndTime,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.label != null) Div(widget.label).rem(0.8),
                  Row(
                    children: [
                      Text(date, style: InputStyles.textStyle),
                      Text("-", style: InputStyles.textStyle),
                      Text(time, style: InputStyles.textStyle),
                    ].spacing(5),
                  ),
                ],
              ),
              const Icon(
                PhosphorIcons.calendar_blank,
                size: 20,
                color: Color(0xFFB7B7B7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
