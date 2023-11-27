import 'package:flutter/material.dart';
import 'package:calm_mind/Event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:calm_mind/shared_preferences_helper.dart';
class SecondScreen extends StatefulWidget {
  final DateTime selectedDate;
  // final Function(Event) onEventAdded;
  // final List<Doctor> doctorsList;
  final List<String> availableTimes;
  final String? selectedMeetingType; // Add the selectedMeetingType parameter

  SecondScreen({
    required this.selectedDate,
    // required this.onEventAdded,
    // required this.doctorsList,
    required this.availableTimes,
    this.selectedMeetingType, // Add this line to the constructor
  });

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  String? selectedTime;
    String? selectedMeetingType; // New variable to store the selected meeting type


  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  late Doctor? selectedDoctor = null; // Provide a default value
  late List<Doctor> specialists = []; // Use Doctor type for the specialists list

  @override
  void initState() {
    super.initState();
    fetchSpecialists();
  }
  
  Future<void> fetchSpecialists() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/specialists'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['specialists'];
        setState(() {
          // Convert Map<String, dynamic> to Doctor objects
        specialists = data.map((specialist) {
          final int specialistId = specialist['userId'];
          return Doctor(
            name: specialist['fullname'],
            image: specialist['image'],
            specialistId: specialistId, // Make sure you have a userId property in your Doctor class
          );
        }).toList();
        });
      } else {
        print('Failed to load specialists');
      }
    } catch (error) {
      print('Error fetching specialists: $error');
    }
  }
 Future<void> bookAppointment() async {
    try {
      final int? userId = await getUserId();//patientId

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/appointments'), // Replace with your endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          
          'patientId': userId, // Replace with the actual userId of the patient
          'specialistId': selectedDoctor?.specialistId, // Replace with the actual userId of the specialist
          'meetingType': selectedMeetingType,
          'doctor': {
            'name': selectedDoctor?.name ?? '',
            'image': selectedDoctor?.image ?? '',
          },
          'eventTitle': 'Appointment', // Replace with the actual eventTitle
          'availableTimes': selectedTime ?? '', // Replace with the actual availableTimes
          'eventDate': widget.selectedDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        // Appointment created successfully
        print('Appointment created successfully');
        // Optionally, you can navigate to another screen or show a success message.
      } else {
        // Handle other status codes or errors
        print('Failed to create appointment');
      }
    } catch (error) {
      print('Error creating appointment: $error');
    }
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

            RichText( 
text: TextSpan( 
 
	children: <TextSpan>[ 
	TextSpan( 
		text: 'Book Appointment', 
		style: TextStyle( 
		fontSize: 22, 
		fontWeight: FontWeight.bold, 
		color: Colors.black, 
		), 
	), 
	], 
), 
),
          // buildTextField(controller: titleController, hint: 'Enter Title'),
          // SizedBox(height: 20.0),
        
             // Radio buttons for selecting meeting type
            Row(
              children: [
                Radio(
                  value: 'In-Clinic',
                  groupValue: selectedMeetingType,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMeetingType = value;
                    });
                  },
                ),
                Text('In-Clinic'),
                SizedBox(width: 20.0),
                Radio(
                  value: 'Online Meeting',
                  groupValue: selectedMeetingType,
                  onChanged: (String? value) {
                    setState(() {
                      selectedMeetingType = value;
                    });
                  },
                ),
                Text('Online Meeting'),
              ],
            ),
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
        items: specialists.map((Doctor doctor) {
          return DropdownMenuItem<Doctor>(
            value: doctor,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/${doctor.image}'),
                  maxRadius: 20,
                ),
                SizedBox(width: 8.0),
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
              // final event = Event(
              //   meetingType: selectedMeetingType,
              //   // eventTitle: titleController.text,
              //   eventTitle: "Appointment",
              //   eventDate: widget.selectedDate,
              //   doctor: selectedDoctor,
              //   availabletimes: selectedTime,
              // );

              // widget.onEventAdded(event);
              bookAppointment();

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
