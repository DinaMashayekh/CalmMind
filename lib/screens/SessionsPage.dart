import 'package:flutter/material.dart';
import 'package:calm_mind/models/SessionModel.dart';
import 'package:calm_mind/widgets/SessionsList.dart';



class SessionsPage extends StatefulWidget{


  @override
  _SessionsPageState createState() => _SessionsPageState();
}


class _SessionsPageState extends State<SessionsPage> {
List<Session> session = [
    Session(doctorname: "Hello, Will", doctorimage: "assets/images/image1.jpg", subject: "PTSD", Session_Date:DateTime(2023, 10, 27),time:"" ),
    Session(doctorname: "Hello, Will", doctorimage: "assets/images/image2.jpg", subject: "Eating Disorder", Session_Date:DateTime(2023, 10, 27),time:"" ),
    Session(doctorname: "Hello, Will", doctorimage: "assets/images/image3.jpg", subject: "Sleeping Disorder", Session_Date:DateTime(2023, 10, 27),time:"" ),


  ];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
   	appBar: AppBar( 
  

   elevation: 0,
		centerTitle: true, 
    iconTheme: IconThemeData(color: Colors.black), 
    backgroundColor: Colors.grey.shade100,// Change this color to your desired arrow color
    
	), 
      backgroundColor: Colors.grey.shade100, // Set the background color of the entire page to white
  body: SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Padding(
    padding: const EdgeInsets.only(top: 20.0, left: 10, right: 20),
    child: Column(
      children: [
        SizedBox(
         
          height: 150,
          child: Card(
             color:Color(0xff87bfff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  'Thought of the day',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  '“Taking care of your mental health is an act of self-love.” “You are worthy of happiness and peace of mind.”',
                  
                  style: TextStyle(fontSize: 16,),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20), // Add spacing between the two widgets
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Upcoming Sessions",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: session.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SessionsList(
                  doctorname: session[index].doctorname,
                  doctorimage: session[index].doctorimage,
                  time: session[index].time,
                  Session_Date: session[index].Session_Date,
                  subject: session[index].subject,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ),
),

    
  );


  }
}