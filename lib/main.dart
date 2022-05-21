import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}
