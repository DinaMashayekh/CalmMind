import 'package:flutter/material.dart';
import 'package:calm_mind/onboarding_screen3.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            	  backgroundColor: Colors.white,


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                  SizedBox(height:30.0),
    Image.asset( 'assets/images/undraw_Remote_meeting_re_abe7 (1).png', // Corrected asset path
    width: 400, // Adjust the width as needed
    height:400, // Adjust the height as needed
),
            Text('Remote meetings', style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 30.0, // Change the size as needed
    fontWeight: FontWeight.bold,  ),),),
            Text('Stay connected with friends',
             style: GoogleFonts.poppins(
    textStyle:TextStyle( 
    fontSize: 15.0, // Change the size as needed
      ),),),
                           SizedBox(height:40.0),

            ElevatedButton(
               style: ElevatedButton.styleFrom(
    primary: Color(0xff87bfff), // Set the button's background color
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  
                ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingScreen3()), // Navigate to the next screen
                );
              },
              child: Text('Next',
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
