import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => Container(padding:const EdgeInsets.all(8.0), child: const Text('This works!'),),
      ),
    );
  }
}