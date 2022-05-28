import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_firebase/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (chatSnapshot.hasError) {
          return Text('Error loading data: ${chatSnapshot.error}');
        }

        final chatDocs = chatSnapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(message: chatDocs[index]['text'],),
        );
      },
    );
  }
}
