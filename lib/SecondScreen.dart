import 'package:flutter/material.dart';
import 'package:calm_mind/Event.dart';

class SecondScreen extends StatefulWidget {
  final DateTime selectedDate;
  final Function(Event) onEventAdded;
  final List<Doctor> doctorsList;
  final List<String> availableTimes;

  SecondScreen({
    required this.selectedDate,
    required this.onEventAdded,
    required this.doctorsList,
    required this.availableTimes,
  });

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  Doctor? selectedDoctor;
  String? selectedTime;

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Booking'),
      backgroundColor: Color(0xff0E4C92),
    ),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTextField(controller: titleController, hint: 'Enter Title'),
          SizedBox(height: 20.0),
        
          // Dropdown list for selecting a doctor
          DropdownButtonFormField<Doctor>(
            decoration: InputDecoration(
              labelText: 'Select Doctor',
              border: OutlineInputBorder(),
            ),
            value: selectedDoctor,
            onChanged: (Doctor? value) {
              setState(() {
                selectedDoctor = value;
              });
            },
            items: widget.doctorsList.map((Doctor doctor) {
              return DropdownMenuItem<Doctor>(
                value: doctor,
  child: Row(
    children: [
      Container(
        margin: EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(doctor.image),
          maxRadius: 20,
        ),
      ),
      SizedBox(width: 8.0), // Adjust spacing as needed
      Text(doctor.name),
    ],
  ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          // Dropdown list for selecting a time
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Time',
              border: OutlineInputBorder(),
            ),
            value: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value;
              });
            },
            items: widget.availableTimes.map((String time) {
              return DropdownMenuItem<String>(
                value: time,
                child: Text(time),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff87bfff),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            ),
            onPressed: () {
              final event = Event(
                eventTitle: titleController.text,
                eventDate: widget.selectedDate,
                doctor: selectedDoctor,
                availabletimes: selectedTime,
              );

              widget.onEventAdded(event);
              Navigator.pop(context);
            },
            child: Text('Book Now'),
          ),
        ],
      ),
    ),
  );
}


  Widget buildTextField({required TextEditingController controller, String? hint}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint ?? '',
        border: OutlineInputBorder(),
      ),
    );
  }
}
