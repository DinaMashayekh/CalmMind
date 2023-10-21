
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:calm_mind/onboarding_screen1.dart';

// import 'package:form_field_validator/form_field_validator.dart';

class Signup extends StatefulWidget { 
const Signup({Key? key}) : super(key: key); 


@override 
State<Signup> createState() => _SignupState(); 

} 



Map userData = {}; 
final _formkey = GlobalKey<FormState>(); 
class _SignupState extends State<Signup> {
  String? _selectedUserType;

  void _handleUserTypeChange(String? value) {
    setState(() {
      _selectedUserType = value;
    });
  }

  Widget _customRadio({
    required String? groupValue,
    required String? value,
    required ValueChanged<String?> onChanged,
    required Color selectedColor,
  }) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedUserType == value ? selectedColor : Colors.grey,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _selectedUserType == value ? selectedColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

@override 

Widget build(BuildContext context) { 
    Size size = MediaQuery.of(context).size;
    

	return Scaffold( 
     
	
	  backgroundColor: Colors.white,
		
	appBar: AppBar( 
  
		title: Padding(
            padding: EdgeInsets.only(top: 30.0), // Add padding top here
            child:Text("Sign Up",
    
    style: GoogleFonts.poppins(
    textStyle:TextStyle( 
      color: Color(0xff87bfff),
    fontSize: 20.0, // Change the size as needed
    fontWeight: FontWeight.bold,  ),
            ),
    ),
    ),
   elevation: 0,
		centerTitle: true, 
    iconTheme: IconThemeData(color: Colors.black), // Change this color to your desired arrow color
    backgroundColor: Colors.white, // Change this color to your desired background color
    
	), 
  
	body: SingleChildScrollView( 
		child: Column( 
		children: <Widget>[ 
    
			Padding( 
			padding: const EdgeInsets.only(top: 40.0, ), 
      
			
			), 

			Padding( 
			padding: EdgeInsets.symmetric(horizontal: 15), 
			child: Padding( 
				padding: const EdgeInsets.all(12.0), 
				child: Form( 
					key: _formkey, 
					child: Column( 
						crossAxisAlignment: CrossAxisAlignment.start, 
						children: <Widget>[ 

			Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
								// validator: MultiValidator([ 
								// 	RequiredValidator( 
								// 		errorText: 'Enter email address'), 
								// 	EmailValidator( 
								// 		errorText: 
								// 			'Please correct email filled'), 
								// ]), 
								decoration: InputDecoration( 
									hintText: 'Fullname', 
									labelText: 'Fullname', 
                     labelStyle: TextStyle(
        color: Color(0xff0E4C92), // Change the label text color here
      ),
									prefixIcon: Icon( 
										Icons.person, 
										color: Color(0xff0E4C92), 
									), 
                  	    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0E4C92)), // Change the color as desired
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),),
									errorStyle: TextStyle(fontSize: 18.0), 
									
                  border: OutlineInputBorder( 
										borderSide: 
											BorderSide(color: Colors.red), 
										borderRadius: BorderRadius.all( 
											Radius.circular(9.0)))))),




						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
								// validator: MultiValidator([ 
								// 	RequiredValidator( 
								// 		errorText: 'Enter email address'), 
								// 	EmailValidator( 
								// 		errorText: 
								// 			'Please correct email filled'), 
								// ]), 
								decoration: InputDecoration( 
									hintText: 'Email', 
									labelText: 'Email', 
                     labelStyle: TextStyle(
        color: Color(0xff0E4C92), // Change the label text color here
      ),
									prefixIcon: Icon( 
										Icons.email, 
										color: Color(0xff0E4C92), 
									), 
                  	    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0E4C92)), // Change the color as desired
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),),
									errorStyle: TextStyle(fontSize: 18.0), 
									
                  border: OutlineInputBorder( 
										borderSide: 
											BorderSide(color: Colors.red), 
										borderRadius: BorderRadius.all( 
											Radius.circular(9.0)))))),



						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
							// validator: MultiValidator([ 
							// 	RequiredValidator( 
							// 		errorText: 'Please enter Password'), 
							// 	MinLengthValidator(8, 
							// 		errorText: 
							// 			'Password must be atlist 8 digit'), 
							// 	PatternValidator(r'(?=.*?[#!@$%^&*-])', 
							// 		errorText: 
							// 			'Password must be atlist one special character') 
							// ]), 
							decoration: InputDecoration( 
								hintText: 'Password', 
								labelText: 'Password', 
                    labelStyle: TextStyle(
        color: Color(0xff0E4C92), // Change the label text color here
      ),
								prefixIcon: Icon( 
								Icons.key, 
								color: Color(0xff0E4C92), 
								), 
								errorStyle: TextStyle(fontSize: 18.0), 
								    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff0E4C92)), // Change the color as desired
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
      ),
                border: OutlineInputBorder( 
									borderSide: BorderSide(color: Colors.red), 
									borderRadius: 
										BorderRadius.all(Radius.circular(9.0))
                    ),

							), 
              
							), 
						),
              
              //------------------------------------------------
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      width: 160,
      child: ListTile(
        title: Text('Patient', style: GoogleFonts.poppins(
),),
        leading: Radio<String>(
          value: 'Patient',
          groupValue: _selectedUserType,
          onChanged: (value) {
            setState(() {
              _selectedUserType = value;
            });
          },
          activeColor: Color(0xff87bfff), // Set the active color here
        ),
      ),
    ),
    Container(
      width: 180,
      child: ListTile(
        title: Text('Specialist',style: GoogleFonts.poppins(
),),
        leading: Radio<String>(
          value: 'Specialist',
          groupValue: _selectedUserType,
          onChanged: (value) {
            setState(() {
              _selectedUserType = value;
            });
          },
          activeColor: Color(0xff87bfff), // Set the active color here
        ),
      ),
    ),
  ],
),



              //------------------------------------------------
			
            SizedBox(height: 30.0),
    Container(
    width:size.height * 0.4,
    child:ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: ElevatedButton( // Use ElevatedButton instead of FlatButton
    onPressed: () {Navigator.push(
      context, 
      MaterialPageRoute(
        builder:(context) {
       return OnboardingScreen1();
     },
     ),
     );
     },
    style: ElevatedButton.styleFrom(
    primary: Color(0xff87bfff), // Set the button's background color
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  
                ),
    child:Text(
    "Get started", style: GoogleFonts.poppins(
    textStyle:TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 16.0, fontFamily: 'Poppins',),
          ),),
        ),
      ),
     ),     
		// 				Padding( 
		// 					padding: const EdgeInsets.all(28.0), 
		// 					child: Container( 
		// 					child: ElevatedButton( 
    //              style: ElevatedButton.styleFrom(
    //  primary: Color(0xffABD5EF), // Set the button's background color
    //  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),      ),
		// 						child: Text( 
		// 						'Login', 
		// 						style: TextStyle( 
		// 							color: Colors.white, fontSize: 22), 
		// 						), 
		// 						onPressed: () { 
		// 						if (_formkey.currentState!.validate()) { 
		// 							print('form submiitted'); 
		// 						} 
		// 						}, 
			
		// 					), 
		// 					width: MediaQuery.of(context).size.width, 
		// 					height: 50, 
		// 					), 
		// 				), 
						Center( 
							child: Padding( 
							padding: EdgeInsets.fromLTRB(0, 30, 0, 0), 
							child: Center( 
								child: Text( 
								'Or Sign Up with',              style: GoogleFonts.poppins(

								textStyle: TextStyle( 
									fontSize: 18, color: Colors.black), 
								), ),
							), 
							), 
						), 
Center(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 40, 0), // Added right padding for spacing
        child: Container(
          height: 40,
          width: 40,
          child: GestureDetector(
            onTap: () {
              // Your click handler code here
            },
            child: Image.asset(
              'assets/images/Facebook_Logo_(2019).png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 40, 0), // Added right padding for spacing
        child: Container(
          height: 40,
          width: 40,
          child: GestureDetector(
            onTap: () {
              // Your click handler code here
            },
            child: Image.asset(
              'assets/images/google-icon-2048x2048-czn3g8x8.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0), // No right padding for the last container
        child: Container(
          height: 40,
          width: 40,
          child: GestureDetector(
            onTap: () {
              // Your click handler code here
            },
            child: Image.asset(
              'assets/images/580b57fcd9996e24bc43c516.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  ),
),

            
Padding(
  padding: EdgeInsets.only(top:30.0), // Adjust the value as needed
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
    children: [
      Text(
        "Already have an account?",  style: GoogleFonts.poppins(

        textStyle: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),),
      ),
      Container(

      child:  ElevatedButton(
               
      onPressed: (){
                     },
   style: ElevatedButton.styleFrom(
    primary: Colors.white,
       elevation: 0,
),
        child: Text(
          'Sign In',  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Color(0xff87bfff),),),
        ),
        ),
      ),
    ],
  ),
)

						]), 
				)), 
			), 
		], 
		), 
	), 
	); 
} 
} 
