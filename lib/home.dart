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


Map<DateTime, List<Event>> mySelectedEvents = {}; 
List<Event> events = [
  Event(
    eventTitle: "Event 1",
    availabletimes: "11:00 AM",
    eventDate: DateTime(2023, 10, 25),
  ),
  Event(
    eventTitle: "Event 2",
    availabletimes: "11:00 AM",
    eventDate: DateTime(2023, 10, 26),
  ),
  Event(
    eventTitle: "Event 3",
    availabletimes: "11:00 AM",
    eventDate: DateTime(2023, 10, 27),
  ),
  // Add more events here
];
  @override
  void initState() {
    super.initState();

    // Initialize selectedCalendarDate with a default value.
    selectedCalendarDate = DateTime.now();

    // ... other initialization code ...

  }
 
  
List<Event> _listOfDayEvents(DateTime selectedCalendarDate) {
  return events.where((event) => event.eventDate.isAtSameMomentAs(selectedCalendarDate)).toList();
}
void _navigateToAddEventScreen() async {
  // Use Navigator.push to navigate to 'SecondScreen'.
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SecondScreen(
        selectedDate: selectedCalendarDate,
        onEventAdded: (Event event) {
          setState(() {
            // Add the event to your list of events.
            events.add(event);

            // Update the events for the selected date
            mySelectedEvents[selectedCalendarDate] = mySelectedEvents[selectedCalendarDate] ?? [];
            mySelectedEvents[selectedCalendarDate]!.add(event);
          });
        },
        doctorsList: [
          Doctor(name: 'Dr. John Doe', image: 'assets/images/image3.jpg'),
          Doctor(name: 'Dr. Jane Smith', image: 'assets/images/image1.jpg'),
          // Add more doctors as needed
        ],
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
  // Check if a result is returned and if it is of type 'MyEvents'.
  if (result != null && result is Event) {
    // Retrieve the list of events for
    // the selected calendar date
    // or initialize an empty list.
    final selectedDateEvents = mySelectedEvents[selectedCalendarDate] ?? [];

    // Update the list of events with
    // the result from 'SecondScreen'.
    setState(() {
      // Add the new event to the list
      selectedDateEvents.add(result);

      // Update the events for the selected date
      mySelectedEvents[selectedCalendarDate] = selectedDateEvents;
    });
  }
}

// This function displays an AlertDialog to add a new event. 

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
     return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
      child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:0.0 ),
                  
    child: Image.asset(
                'assets/images/undraw_survey_05s5(1).png',
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
               onPressed: () {Navigator.push(
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
    );
}

Widget _buildCalendarPage() {
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
                        eventTitle: myEvents.eventTitle,
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
    backgroundColor: Colors.white, // Set the background color of the entire page to white
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
