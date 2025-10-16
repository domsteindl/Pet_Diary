// domain/appointment_text.dart
String getAppointmentMessage(int numberAppointments) {
  if (numberAppointments == 0) {
    return "Diese Woche stehen keine Termine an :)";
  } else if (numberAppointments == 1) {
    return "Du hast einen anstehenden Termin diese Woche!";
  } else {
    return "Du hast $numberAppointments anstehende Termine";
  }
}
