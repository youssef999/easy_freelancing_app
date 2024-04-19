// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatView extends StatelessWidget {
//   const ChatView({Key? key});

//   static const String screenRoute = 'chat_screen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Chat')),
//       body: const Column(
//         children: [
//           Expanded(
//             child: ChatMessagesList(),
//           ),
//           ChatInputField(),
//         ],
//       ),
//     );
//   }
// }

// class ChatMessagesList extends StatelessWidget {
//   const ChatMessagesList({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Message>>(
//       stream: chatMessagesStream('chatId', FirebaseAuth.instance.currentUser!.uid, 'recipientId'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final messages = snapshot.data ?? [];
//         return ListView.builder(
//           reverse: true,
//           itemCount: messages.length,
//           itemBuilder: (context, index) {
//             final message = messages[index];
//             return ListTile(
//               title: Text(message.text),
//               subtitle: Text(message.senderId),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class ChatInputField extends StatefulWidget {
//   const ChatInputField({Key? key});

//   @override
//   _ChatInputFieldState createState() => _ChatInputFieldState();
// }

// class _ChatInputFieldState extends State<ChatInputField> {
//   final TextEditingController _textEditingController = TextEditingController();

//   void _sendMessage() {
//     final message = _textEditingController.text.trim();
//     if (message.isNotEmpty) {
//       sendMessage('chatId', message, FirebaseAuth.instance.currentUser!.uid);
//       _textEditingController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(labelText: 'Type a message...'),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Send a message
// void sendMessage(String chatId, String text, String senderId) async {
//   try {
//     await FirebaseFirestore.instance.collection('chats').doc(chatId).collection('messages').add({
//       'text': text,
//       'senderId': senderId,
//       'timestamp': Timestamp.now(),
//     });
//   } catch (e) {
//     print('Error sending message: $e');
//   }
// }

// // Stream of chat messages for a specific chat
// Stream<List<Message>> chatMessagesStream(String chatId, String senderId, String recipientId) {
//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(senderId)
//       .collection('chats')
//       .doc(chatId)
//       .collection('messages')
//       .where('senderId', whereIn: [senderId, recipientId])
//       .orderBy('timestamp', descending: true)
//       .snapshots()
//       .map((snapshot) => snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
// }

// // Message Model
// class Message {
//   final String text;
//   final String senderId;
//   final Timestamp timestamp;

//   Message({required this.text, required this.senderId, required this.timestamp});

//   factory Message.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Message(
//       text: data['text'],
//       senderId: data['senderId'],
//       timestamp: data['timestamp'],
//     );
//   }
// }
