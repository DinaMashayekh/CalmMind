import 'package:calm_mind/screens/SessionsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calm_mind/models/chatUsersModel.dart';
import 'package:calm_mind/widgets/conversationList.dart';
import 'package:calm_mind/screens/chatDetailPage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:calm_mind/screens/detailScreen.dart';
import 'package:calm_mind/Event.dart';
import 'package:calm_mind/SecondScreen.dart';
import 'package:calm_mind/changeNotifier.dart';
import 'package:calm_mind/screens/QuestionsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calm_mind/validation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:calm_mind/widgets/RoomsList.dart';
import 'package:calm_mind/models/RoomsModel.dart';
import 'package:calm_mind/screens/SessionsPage.dart';
import 'package:calm_mind/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


int TestDone=0;


class BottomNavigationBarExample extends StatefulWidget {
  
    static final GlobalKey<_BottomNavigationBarExampleState> navigatorKey =
      GlobalKey<_BottomNavigationBarExampleState>();

  @override
  _BottomNavigationBarExampleState createState() => _BottomNavigationBarExampleState();

 
}
class AppColors { 
  AppColors._(); // Private constructor to prevent instantiation. 
  
  // Define color constants as static members of the class. 
  static const Color blackCoffee = Color(0xFF352d39); // Dark brownish-black color. 
  static const Color eggPlant = Color(0xFF6d435a); // Eggplant purple color. 
  static const Color celeste = Color(0xFFb1ede8); // Light blue-green color. 
  static const Color babyPowder = Color(0xFFFFFcF9); // Soft off-white color. 
  static const Color ultraRed = Color(0xFFFF6978); // Bright red color. 
} 

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
   void rebuildWidget() {
    setState(() {});
  }
  
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedCalendarDate = DateTime.now();
  DateTime _initialCalendarDate = DateTime(DateTime.now().year - 1, 1, 1);
  DateTime _lastCalendarDate = DateTime(DateTime.now().year + 1, 12, 31);
  DateTime selectedCalendarDate = DateTime.now(); // Initialize here
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descpController = TextEditingController();
  Event? myEvents; // Define the type of myEvents
  int _selectedIndex = 0;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  List<Event> events = [];
  Map<DateTime, List<Event>> mySelectedEvents = {};

  final PageController _pageController = PageController();

 void changePagenav(int index) {
    context.read<PageControllerProvider>().setPage(index);
  }
   

  @override
  void dispose() {
    // Dispose of the PageController when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  Map<DateTime, List<Event>> groupAppointmentsByDate(List<Event> appointments) {
  Map<DateTime, List<Event>> groupedAppointments = {};

  for (var appointment in appointments) {
    DateTime date = appointment.eventDate;
    
    // If the date is not already a key in the map, add it with an empty list
    groupedAppointments.putIfAbsent(date, () => []);

    // Add the appointment to the list corresponding to the date
    groupedAppointments[date]!.add(appointment);
  }

  return groupedAppointments;
}
// Assuming this is a method where you want to fetch and display appointments
void loadAppointments() async {
  final int? userId = await getUserId();

  try {
    print('Fetching appointments for userId: $userId');

    // Check if userId is not null before making the request
    if (userId != null) {
      List<Event> appointments = await fetchAppointments(userId);

      print('Appointments loaded: $appointments');

      // Assuming mySelectedEvents is a Map<DateTime, List<Event>>
      setState(() {
        // Clear existing events for the user
        mySelectedEvents.clear();

        // Group appointments by date
  for (var appointment in appointments) {
  final date = appointment.eventDate;
  if (date != null) {
    mySelectedEvents[date] = [...mySelectedEvents[date] ?? [], appointment];
  }
}


      });

      print('mySelectedEvents after loading: $mySelectedEvents');
    } else {
      print('User ID is null. Cannot fetch appointments.');
      // Handle the case where userId is null
    }
  } catch (error) {
    print('Error loading appointments: $error');
    // Handle error loading appointments
  }
}


// Function to fetch appointments for a specific patientId
Future<List<Event>> fetchAppointments(int? userId) async {
  try {
    if (userId == null) {
      print('Error: UserId is null.');
      return []; // or return null or an empty list based on your logic
    }

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api//appointments/$userId'));

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = json.decode(response.body)['appointments'];

     List<Event> appointments = data.map((appointment) {
  // Ensure that 'meetingType' is a non-null String or provide a default value.
  final String? meetingType = appointment['meetingType'] ?? 'DefaultMeetingType';

  // Ensure that 'eventTitle' is a non-null String.
  final String eventTitle = appointment['eventTitle'] ?? 'DefaultEventTitle';

  // Ensure that 'eventDate' is a non-null String and can be parsed to DateTime.
  final String? serverDateString = appointment['eventDate'];
  final DateTime eventDate =
      serverDateString != null ? DateTime.tryParse(serverDateString) ?? DateTime.now() : DateTime.now();

  // Ensure that 'availableTimes' is a non-null String or provide a default value.
  final String? availableTimes = appointment['availableTimes'] ?? 'DefaultAvailableTimes';

  // Ensure that 'doctor' is a Map and contains the required fields.
  final Map<String, dynamic>? doctorData = appointment['doctor'];
  final Doctor? doctor = doctorData != null
      ? Doctor(
          name: doctorData['name'] ?? 'DefaultDoctorName',
          image: doctorData['image'] ?? 'DefaultDoctorImage',
          specialistId: doctorData['specialistId'] ?? -1, // Provide a default value or handle differently
        )
      : null;

  return Event(
    meetingType: meetingType,
    doctor: doctor,
    eventTitle: eventTitle,
    availabletimes: availableTimes,
    eventDate: eventDate,
  );
}).toList();

         

      return appointments;
    } else {
      print('Failed to load appointments. Status code: ${response.statusCode}');
      return []; // or return null or an empty list based on your logic
    }
  } catch (error) {
    print('Error fetching appointments: $error');
    return []; // or return null or an empty list based on your logic
  }
}


  @override
  void initState() {
    super.initState();

    // Initialize selectedCalendarDate with a default value.
    selectedCalendarDate = DateTime.now();

    // ... other initialization code ...
  loadAppointments();

  }
 
  
List<Event> _listOfDayEvents(DateTime? selectedCalendarDate) {
  if (selectedCalendarDate == null) {
    return [];
  }

  print('Selected Calendar Date: $selectedCalendarDate');

  // Retrieve the list of events for the selected calendar date
  // from the mySelectedEvents map, or initialize an empty list.
  final selectedDateEvents = mySelectedEvents[selectedCalendarDate] ?? [];

  print('Appointments for $selectedCalendarDate: $selectedDateEvents');

  return selectedDateEvents;
}


void _navigateToAddEventScreen() async {
  // Use Navigator.push to navigate to 'SecondScreen'.
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SecondScreen(
        selectedDate: selectedCalendarDate,
   
      
        availableTimes: [
          '8:00 AM',
          '9:00 AM',
          '10:00 AM',
          '11:00 AM',
          '1:00 PM',
          '2:00 PM',
          '3:00 PM',
          '4:00 PM',
          '5:00 PM',
        ],
      ),
    ),
  );
 
}


// This function creates and returns a TextField widget with specified properties. 
Widget buildTextField({String? hint, required TextEditingController controller}) { 
  // Create a TextField widget with the provided controller. 
  return TextField( 
    controller: controller, 
    textCapitalization: TextCapitalization.words, // Capitalize each word in the input. 
    decoration: InputDecoration( 
      labelText: hint ?? '', // Set the label text to the provided hint, or empty if not provided. 
      focusedBorder: OutlineInputBorder( 
        // Define the border when the TextField is focused. 
        borderSide: const BorderSide(color: Colors.black, width: 1.5), // Border color and width. 
        borderRadius: BorderRadius.circular(10.0), // Border radius. 
      ), 
      enabledBorder: OutlineInputBorder( 
        // Define the border when the TextField is not focused. 
        borderSide: const BorderSide(color:Colors.black, width: 1.5), // Border color and width. 
        borderRadius: BorderRadius.circular(10.0), // Border radius. 
      ), 
    ), 
  ); 
} 
List<ChatUsers> chatUsers = [
  ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "assets/images/image4.jpg", time: "Now"),
  ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "assets/images/image4.jpg", time: "Yesterday"),
  ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "assets/images/image5.jpg", time: "31 Mar"),
  ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "assets/images/image1.jpg", time: "28 Mar"),
  ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "assets/images/image2.jpg", time: "23 Mar"),
  ChatUsers(name: "Jacob Pena", messageText: "will update you in the evening", imageURL: "assets/images/image3.jpg", time: "17 Mar"),
  ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "assets/images/image5.jpg", time: "24 Feb"),
];
List<Room> Rooms = [
  Room(name: "Depression", doctorname: "Philip Fox"),
  Room(name: "PTSD", doctorname: "Jacob Pena"),
  Room(name: "Anxiety", doctorname: "Debra Hawkins"),
  Room(name: "Depression", doctorname: "Andrey Jones"),
  Room(name: "Eating Disorder", doctorname: "Glady's Murphy"),
  Room(name: "Bipolar Disorder", doctorname: "Jane Russel"),

];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('CalmMind'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
            icon: const Icon(Icons.notifications),
          ),
        
        ],
        backgroundColor: Color(0xff0E4C92),
      ),
      body: PageView(
          controller: context.watch<PageControllerProvider>().pageController,

        children: <Widget>[
          // Home Page
          _buildPage(0, 'Home'),
          // Room Page
          buildRoomsPage(),
          // Chats Page
          _buildChatsPage(),
          // Treatment Plan Page
          _buildTreatmentPlanPage(),
          // Calendar Page
        _buildCalendarPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Room',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            label: 'Treatment plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calendar',
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff0E4C92),
        unselectedItemColor: Colors.black54,
        onTap: (int index) {
          
    changePagenav(index); // Call the changePage function
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }

  Widget _buildPage(int index, String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }


Widget _buildTreatmentPlanPage() {
 return TestDone == 0
      ?  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child:SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:0.0 ),
                  
    child: Image.asset(
                'assets/images/undraw_Questions_re_1fy7.png',
                width: 400,
                height: 400,
              ),
            
               ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "You need to answer some questions before you get your treatment plan",
             style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 18.0,
      fontWeight:FontWeight.bold
 ),
      ),
                textAlign: TextAlign.center,
              
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
    primary: Color(0xff87bfff), // Set the button's background color
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),),
     onPressed: () {
        TestDone=1;        
      Navigator.push(
      context, 
      MaterialPageRoute(
        builder:(context) {
       return QuestionsPage();
     },
     ),
     );
               },
              child: Text("Let's go",
             style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 18.0,
      fontWeight:FontWeight.bold // Change the size as needed
      ),
      ),
      ),
            ),
          ],
        ),
      ),
      ),
    )
  :Scaffold(
  backgroundColor: Colors.grey.shade100,
  body: SingleChildScrollView(
    child: Column(
      children: [

         Padding(
      padding: const EdgeInsets.only(top:50.0, left:20), 
    child:Text(
      'Welcome back, Salma',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
     ),
     
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10, right:20),

          child:Container(

           height: 70,
           
          child: ListTile(
           
    contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15), // Adjust vertical padding as needed

             shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),

      ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Your Treatment Plan Progress',
    
    style: GoogleFonts.poppins(
    textStyle:TextStyle( 
      color: Colors.black87,
    fontSize: 16.0, // Change the size as needed
    fontWeight: FontWeight.normal,  ),
            ),
            ),
          ),
          trailing: Container(
            width: 50.0, // Adjust the width to fit the CircularPercentIndicator
            child: CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 3.0,
              percent: 0.75, // Change this value based on your requirement
              center: Text("75%"),
              progressColor: Colors.blue,
            ),
          ),
        ),
          ),
     
     ),
 SizedBox(height: 30),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Container(
      width: 180,
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          onPressed: () {
            // Handle button click
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xff87bfff),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.white,
                size: 20, // Adjust the size of the icon
              ),
            Text(
                "Mood Tracking"),
           
              

            ],
          ),
        ),
      ),
    ),
    Container(
      width: 180,
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionsPage()), // Navigate to the next screen
                );
              },
          
          style: ElevatedButton.styleFrom(
            primary: Color(0xff0E4C92),
          ),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 20, // Adjust the size of the icon
              ),

            Text(
                "Upcoming Sessions"),
           
              

            ],
          ),
        ),
      ),
    ),
  ],
),

        Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  
    Padding(
      padding: const EdgeInsets.only(top:30.0, left:20), 
    child:Text(
      "Today's tasks",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
     
  
),
Padding(
  padding: const EdgeInsets.only(top: 20.0, left: 10, right: 20),
  child: SizedBox(
   
    height: 100, // Adjust the height as needed
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: ListTile(
     
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Meditation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle:Padding(
          padding: const EdgeInsets.only(top: 6.0),
           child: Text('10 min'),

        ),
         
        trailing: Transform.scale(
       scale: 1.5,
        child:Checkbox(
          
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
activeColor: Color(0xff0E4C92),
         ),
        ),
  ),
    
      ),
    ),
  ),

Padding(
  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 20),
  child: SizedBox(
    height: 100, // Adjust the height as needed
    child: Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
      
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Outdoor activity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle:Padding(
          padding: const EdgeInsets.only(top: 6.0),
           child: Text('Check your current mental health or do the test again!'),

        ), 
        trailing: Transform.scale(
       scale: 1.5,
        child:Checkbox(
          
          value: isChecked1,
          onChanged: (value) {
            setState(() {
              isChecked1 = value!;
            });
          },
activeColor: Color(0xff0E4C92),
         ),
        ),
      ),
    ),
  ),
),
  ],
        ),
Padding(
  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 20),
  child: SizedBox(
    height: 100, // Adjust the height as needed
    child: Card(

      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
       
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            'Reading',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle:Padding(
          padding: const EdgeInsets.only(top: 6.0),
           child: Text('Check your current mental health or do the test again!'),

        ), 
        trailing: Transform.scale(
       scale: 1.5,
        child:Checkbox(
          
          value: isChecked2,
          onChanged: (value) {
            setState(() {
              isChecked2 = value!;
            });
          },
activeColor: Color(0xff0E4C92),
         ),
        ),
      ),
    ),
  ),
),
      ],
    ),
  ),
);
}

Widget _buildCalendarPage() {
    // loadAppointments(); // Call the function when the calendar page is built

  return Scaffold(

      floatingActionButton: FloatingActionButton( 
    onPressed: () => _navigateToAddEventScreen(), // Define the onPressed action. 
    child: Icon( 
      Icons.edit, 
      color: Color(0xff0E4C92), 
    ), 
    backgroundColor: AppColors.babyPowder, // Background color of the button. 
  ), 
  
  body: SingleChildScrollView(
  child: Column( 
      children: [ 
        // Card widget for displaying content with a card-like design. 
        Card( 
          margin: const EdgeInsets.all(8.0), 
          elevation: 5.0, 
          shape: const RoundedRectangleBorder( 
            borderRadius: BorderRadius.all( 
              Radius.circular(10), 
            ), 
          ), 
          child: TableCalendar( 
            calendarFormat: _calendarFormat, // Define the calendar format. 
  
            focusedDay: _focusedCalendarDate, // Set the focused calendar day. 
            // today's date 
            firstDay: _initialCalendarDate, // Set the earliest possible date. 
            lastDay: _lastCalendarDate, // Set the latest allowed date. 
              
            // ... (Additional calendar settings and styles) 
              
            // Event loader function to load events for specific dates. 
  
            // 
            //... (Header style and other calendar styles) 
              
  selectedDayPredicate: (currentSelectedDate) {
      return isSameDay(selectedCalendarDate, currentSelectedDate);
    
  },
 onDaySelected: (selectedDay, focusedDay) {
  if (!isSameDay(selectedCalendarDate, selectedDay)) {
    setState(() {
      selectedCalendarDate = selectedDay;
      _focusedCalendarDate = focusedDay;
    });
    // Load appointments for the selected date when the date is changed.
    loadAppointments();
  }
},


   calendarStyle: CalendarStyle(
    selectedDecoration: BoxDecoration(
      shape: BoxShape.circle,
            color: Color(0xff87bfff), // Change this to your desired color for today's date

    ),
       todayDecoration: BoxDecoration(
      shape: BoxShape.circle,
                  color: Color.fromARGB(255, 175, 210, 249), // Change this to your desired color for today's date

    ),
  ),
          ), 
        ), 
        // Map over a list of events and display them as ListTiles. 
  
        // ... (List item styling and onTap actions) 
        
  ..._listOfDayEvents(selectedCalendarDate!).map( 
              (myEvents) => GestureDetector( 
                onTap: () { 
                      if (selectedCalendarDate != null) {

                  Navigator.push( 
                    context, 
                    MaterialPageRoute( 
                      builder: (context) =>detail( 
                        // eventTitle: myEvents.eventTitle,
                        meetingType:myEvents.meetingType ,
                        eventTitle: "Appointment",
                      availableTime:myEvents.availabletimes,
                        eventDate: selectedCalendarDate!,
                       doctor: myEvents.doctor,
 
                      ), 
                    ),
                     
                  ); 
                }
                }, 
                child: Padding( 
                  padding: const EdgeInsets.symmetric( 
                      horizontal: 12.0, vertical: 8.0), 
                  child: ListTile( 
                    // add rounded border to list item 
                    shape: RoundedRectangleBorder( 
                     
                      borderRadius: BorderRadius.circular(10.0), 
                    ), 
  
                    leading: Container( 
                      width: 50, 
                      height: 50, 
                      decoration: BoxDecoration( 
                        color: Color(0xff87bfff), 
                        shape: BoxShape.circle, 
                      ), 
                      child: const Icon( 
                        Icons.done, 
                        color: AppColors.babyPowder, 
                      ), 
                    ), 
                    // in trailing add forward icon 
                    trailing: const Icon( 
                      Icons.arrow_forward_ios, 
                      color: Colors.black87, 
                    ), 
  
                    title: Padding( 
                      padding: const EdgeInsets.only(bottom: 8.0), 
                      child: Text( 
                        '${myEvents.eventTitle}', 
                        style: TextStyle( 
                            fontSize: 20, fontWeight: FontWeight.bold), 
                      ), 
                    ), 
                    subtitle: Text('${myEvents.availabletimes}'), 
                  ), 
                ), 
              ), 
            )


      ], 
    ), 
  ),
  );
}


Widget buildRoomsPage( ) {
return Scaffold(
    backgroundColor: Colors.grey.shade100, // Set the background color of the entire page to white
    body: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Rooms",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ), 
                 //add new room
             // Container(
                //   padding: EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                //   height: 30,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Color(0xffd2e6fd),
                //   ),
                //   child: Row(
                //     children: <Widget>[
                //       Icon(Icons.add, color: Color(0xff0E4C92), size: 20),
                //       SizedBox(width: 2),
                //       Text(
                //         "Add New",
                //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
        // Add your ListView.builder here
ListView.builder(
  itemCount: Rooms.length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 16),
  physics: NeverScrollableScrollPhysics(),

  itemBuilder: (context, index){
    return RoomsList(
      name: Rooms[index].name,
      doctorname: Rooms[index].doctorname,
    
    );
  },
),


      ],
    ),
        ),

  );
}

Widget _buildChatsPage() {
  
  return SingleChildScrollView(
    
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Chats",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
             
              ],
            ),
          ),
        ),
        // Add your ListView.builder here
ListView.builder(
  itemCount: chatUsers.length,
  shrinkWrap: true,
  padding: EdgeInsets.only(top: 16),
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index){
    return ConversationList(
      name: chatUsers[index].name,
      messageText: chatUsers[index].messageText,
      imageUrl: chatUsers[index].imageURL,
      time: chatUsers[index].time,
      isMessageRead: (index == 0 || index == 3)?true:false,
    );
  },
),


      ],
    ),
    
  );
}


}

class NavDrawer extends StatelessWidget {
 void changePage(int index, BuildContext context) {
    context.read<PageControllerProvider>().setPage(index);
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Color(0xff87bfff),
            ),
          ),
          ListTile(
            leading:      IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
  icon: CircleAvatar(
    backgroundColor: Colors.blue, // Set the desired background color
    child: Container(
      width: 50, // Adjust the width and height as needed
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/image1.jpg'), // Use a square image
          fit: BoxFit.cover, // Make sure the image covers the entire circle
        ),
      ),
    ),
  ),
             
          ),
            title: Text('Profile'),
            onTap: () {
              // Handle the 'Profile' navigation
            },
          ),
       
           ListTile(
            leading: Icon(Icons.psychology_outlined),
            title: Text('Specialists'),
            onTap: () {
              // Handle the 'Filter' navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Rooms'),
            onTap: () {
    Navigator.pop(context); // Close the drawer
    changePage(1,context); // Navigate to the 'Rooms' page (index 1)
  },
          ),
           ListTile(
            leading: Icon(Icons.chat_rounded),
            title: Text('Chats'),
            onTap: () {
               Navigator.pop(context); // Close the drawer
    changePage(2,context);
              // Handle the 'Filter' navigation
            },
          ),
           ListTile(
            leading: Icon(Icons.checklist_outlined),
            title: Text('Treatment Plan'),
            onTap: () {
 Navigator.pop(context); // Close the drawer
    changePage(3,context);            },
          ),
           ListTile(
            leading: Icon(Icons.calendar_month_rounded),
            title: Text('Calendar'),
            onTap: () {
 Navigator.pop(context); // Close the drawer
    changePage(4,context);            },
          ),
            ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Log out'),
            onTap: () {
              // Handle the 'Filter' navigation
            },
          ),
          // Rest of the ListTile items
        ],
      ),
    );
  }

//  void _selectPage(int index, BuildContext context) {
//   _pageController.setPage(index);
// }

}


class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xff0E4C92),
      ),
    );
  }
}
