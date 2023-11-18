import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calm_mind/home.dart';


class Validation extends StatelessWidget {

// void goBackTwoPages(BuildContext context) {
//   int count = 0; // Counter to track how many routes have been popped

//   Navigator.of(context).popUntil((route) {
//     // Check the condition based on your navigation structure
//     bool shouldPop = count == 2;

//     if (!shouldPop) {
//       count++;
//     }

//     return shouldPop;
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Image.asset(
                  'assets/images/undraw_Agree_re_hor9.png',
                  width: 400,
                  height: 400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Thank you for taking the mental health test, your treatment plan is ready now!",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff87bfff),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                ),
    //     onPressed: () {
    //   // Call the method to go back two pages
    //   goBackTwoPages(context);
    // },
     onPressed: () {
            BottomNavigationBarExample.navigatorKey.currentState?.rebuildWidget();
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => BottomNavigationBarExample()),
            );
          },
          
                child: Text(
                  "Check it",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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
}