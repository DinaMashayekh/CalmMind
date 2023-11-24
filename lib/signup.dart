
import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:calm_mind/onboarding_screen1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:form_field_validator/form_field_validator.dart';

class Signup extends StatefulWidget { 
const Signup({Key? key}) : super(key: key); 


@override 
State<Signup> createState() => _SignupState(); 

} 



Map userData = {}; 
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class _SignupState extends State<Signup> {
String? _selectedUserType;
final TextEditingController fullnameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

  void _handleUserTypeChange(String? value) {
    setState(() {
      _selectedUserType = value;
    });
  }

////////////////////send data to backend/////////////////
 
 Future<void> createUser() async {
  try {
    final Map<String, dynamic> userData = {
      'userId': "1234",
      'fullname': fullnameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'userType': _selectedUserType?.toLowerCase(), // Convert to lowercase
    };

    print('Request Body: $userData');

    final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print('User created successfully');
      // Optionally, you can navigate to the next screen or show a success message.
        Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => OnboardingScreen1(),
    ),
  );
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Optionally, you can show an error message.
    }
  } catch (error) {
    print('Error creating user: $error');
    // Handle the error, e.g., display an error message to the user.
  }
}


//////////////////////////////////////////////////////////////////


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
					child: Column( 
						crossAxisAlignment: CrossAxisAlignment.start, 
						children: <Widget>[ 

			Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
					    controller: fullnameController,
              validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your fullname';
                    }
                    return null;
                  },

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

  if (_formKey.currentState?.validate() == true &&
        fullnameController.text.isEmpty)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          'Please enter your fullname',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          ),
        ),
      ),

						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
				      controller: emailController,
              validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add email pattern validation
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
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


   // Display Email error message
    if (_formKey.currentState?.validate() == true &&
        emailController.text.isEmpty)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          'Please enter your email',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          ),
        ),
      ),
if (_formKey.currentState?.validate() == true &&
        emailController.text.isNotEmpty &&
        !RegExp(
                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(emailController.text))
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          'Please enter a valid email address',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          ),
        ),
      ),

						Padding( 
							padding: const EdgeInsets.all(12.0), 
							child: TextFormField( 
	            controller: passwordController,
					    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Add password pattern validation
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
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
     // Display Email error message
    if (_formKey.currentState?.validate() == true &&
        passwordController.text.isEmpty)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          'Please enter your password',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          ),
        ),
      ),
  if (_formKey.currentState?.validate() == true &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length < 8)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(
          'Password must be at least 8 characters',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
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

 if (_selectedUserType == null)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Please choose a user type',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                    ),
                  ),
                ),

              //------------------------------------------------
			
     SizedBox(height: 30.0),
    Container(
    width:size.height * 0.4,
    child:ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: ElevatedButton( // Use ElevatedButton instead of FlatButton
    onPressed:() {
      if (_formKey.currentState?.validate() ?? false) {
                        // Check if user type is selected
       if (_selectedUserType != null) {
                          // If form is valid and user type is selected, call createUser
            createUser();
                        }
                      }
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
		
						Center( 
							child: Padding( 
							padding: EdgeInsets.fromLTRB(0, 30, 0, 0), 
							child: Center( 
								child: Text( 
								'Or Sign Up with Google',              style: GoogleFonts.poppins(

								textStyle: TextStyle( 
									fontSize: 18, color: Colors.black), 
								), ),
							), 
							), 
						), 


                SizedBox(height: 20.0), // Add some space between the existing content and the new button

      Container(
        width: size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: GestureDetector(
          onTap: () {
            // Handle button tap
            // Add your logic here
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google-icon-2048x2048-czn3g8x8.png',
                  height: 30.0, // Adjust the height as needed
                ),
                SizedBox(width: 10.0), // Add some space between the icon and text
                Text(
                  'Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
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
