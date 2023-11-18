class Doctor {
  final String name;
  final String image; // You can replace this with the actual type for storing images

  Doctor({required this.name, required this.image});
}

class Event {
  final String eventTitle;
  final DateTime eventDate;
  final Doctor? doctor; // Selected doctor for the event
  final String? availabletimes; // Selected time for the event

  Event({
    required this.eventTitle,
    required this.eventDate,
    this.doctor,
    this.availabletimes,
  });
}
