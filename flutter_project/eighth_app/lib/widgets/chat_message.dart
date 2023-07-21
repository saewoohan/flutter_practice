import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighth_app/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(Object context) {
    final authenticaatedUser = FirebaseAuth.instance.currentUser!;


    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true,).snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(child: const Text('No messages found.'));
        }

        if(chatSnapshots.hasError){
          return const Center(child: Text('Something went wrong...'),);
        }
        final loadedMessages = chatSnapshots.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13,),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length ? loadedMessages[index+1].data() : null;
            final currentMessageUserID = chatMessage['userId'];
            final nextMessageUserID = nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserID == currentMessageUserID;

            if(nextUserIsSame){
              return MessageBubble.next(message: chatMessage['text'], isMe: authenticaatedUser.uid == currentMessageUserID);
            }
            else{
              return MessageBubble.first(userImage: chatMessage['userImage'], username: chatMessage['username'], message: chatMessage['text'], isMe:  authenticaatedUser.uid == currentMessageUserID);
            }
          }
        );
      },
    );
  }
}
