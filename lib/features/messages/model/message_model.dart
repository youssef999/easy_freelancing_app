// import 'package:cloud_firestore/cloud_firestore.dart';

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