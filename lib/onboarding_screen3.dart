import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calm_mind/home.dart';
class OnboardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            	  backgroundColor: Colors.white,


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             SizedBox(height:30.0),
    Image.asset( 'assets/images/undraw_completed_tasks_vs6q (1).png', // Corrected asset path
    width: 400, // Adjust the width as needed
    height:400, // Adjust the height as needed
),
            Text('Ready to get started?', style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 30.0, // Change the size as needed
    fontWeight: FontWeight.bold,  ),),),
            SizedBox(height:40.0),

            ElevatedButton(
                
              style: ElevatedButton.styleFrom(
              primary: Color(0xff87bfff), // Set the button's background color
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),),
             onPressed: () {
            BottomNavigationBarExample.navigatorKey.currentState?.rebuildWidget();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => BottomNavigationBarExample()),
            );
          },
              child: Text('Get Started',
             style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 15.0, // Change the size as needed
      ),),),
            ),
          ],
        ),
      ),
    );
  }
}
