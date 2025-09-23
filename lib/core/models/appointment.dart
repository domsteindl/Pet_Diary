class PetAppointment {
  final DateTime date;
  final String description;

  PetAppointment({
required this.date,
required this.description
  });
@override
  String toString() {
    return '${_formattedDate()} - $description';
  }

  String _formattedDate() {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

