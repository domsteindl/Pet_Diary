
import 'package:flutter/material.dart';

class AppointmentUtils {
  

String dateToHumanReadableString(DateTime? date) {
  if (date == null) return "Keine Termine";

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day); // ignore hours/minutes
  final targetDate = DateTime(date.year, date.month, date.day);

  final diffDays = targetDate.difference(today).inDays;

  if (diffDays == 0) {
    return "Heute";
  } else if (diffDays == 1) {
    return "Morgen";
  } else if (diffDays > 1 && diffDays < 7) {
    return "Bald";
  } else {
    return "Keine Termine";
  }
}

String dateToHoursAndMinutes(DateTime date) {
  return '${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')} Uhr';
}



Color getAppointmentColor(DateTime? date) {
  if (date == null) return Colors.grey;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);
  final difference = target.difference(today).inDays;

  if (difference == 0) return Colors.green;
  if(difference == 1) return Colors.orange;
  if (difference > 1 && difference < 7) return Colors.yellow;
  return Colors.grey;
}


}