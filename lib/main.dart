import 'package:flutter/material.dart';
import 'package:calm_mind/welcomePage.dart';
import 'package:calm_mind/screens/chatDetailPage.dart';
import 'package:calm_mind/models/chatUsersModel.dart'; // Import the ChatUsers model.

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalmMind',
      theme: ThemeData(),
      home: WelcomeScreen(),
      routes: {
        '/chatDetailPage': (context) => ChatDetailPage(),
        // You can add other routes here as needed
      },
    );
  }
}
