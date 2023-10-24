import 'package:flutter/material.dart';
import 'package:calm_mind/models/chatUsersModel.dart';
import 'package:calm_mind/widgets/conversationList.dart';
import 'package:calm_mind/screens/chatDetailPage.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);


  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}


class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {

List<ChatUsers> chatUsers = [
  ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "assets/images/image4.jpg", time: "Now"),
  ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "assets/images/image4.jpg", time: "Yesterday"),
 ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "assets/images/image5.jpg", time: "31 Mar"),
  ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "assets/images/image1.jpg", time: "28 Mar"),
  ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "assets/images/image2.jpg", time: "23 Mar"),
  ChatUsers(name: "Jacob Pena", messageText: "will update you in the evening", imageURL: "assets/images/image3.jpg", time: "17 Mar"),
  ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "assets/images/image5.jpg", time: "24 Feb"),
];
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading:Icon(Icons.menu),
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
             IconButton(
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
        ],
        backgroundColor: Color(0xff0E4C92),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          // Home Page
          _buildPage(0, 'Home'),
          // Room Page
          _buildRoomsPage(),
          // Chats Page
          _buildChatsPage(),
          // Treatment Plan Page
          _buildPage(3, 'Treatment plan'),
          // Calendar Page
          _buildPage(4, 'Calendar'),
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
            icon: Icon(Icons.check_box_rounded),
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

Widget _buildRoomsPage() {
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
