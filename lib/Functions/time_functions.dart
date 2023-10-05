import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

abstract class AppTime {
  Future<DateTime?> openTimePicker(BuildContext context) async {
    Time t = Time.fromTimeOfDay(TimeOfDay.now(), 0);
    await Navigator.of(context).push(await showPicker(
        value: t, onChange: (value) => t = value, context: context));

    DateTime? time = DateTime(0,0,0,t.hour,t.minute);

    return time;
  }

  String dateToText(DateTime d) {
    String cMonth = d.month < 10 ? '0${d.month}' : '${d.month}';
    String cDay = d.day < 10 ? '0${d.day}' : '${d.day}';

    return '$cDay$cMonth${d.year}';
  }
/*
  Note createNote(String text, DateTime date, DateTime start, DateTime end,
      Color color, bool notification) {
    return Note(
      text: text,
      date: DateFormat("ddMMyyyy").format(date),
      start: DateFormat('hh:mm').format(start),
      end: DateFormat('hh:mm').format(end),
      color: color.value,
      notify: notification == true ? 1 : 0,
    );
  }*/
}
