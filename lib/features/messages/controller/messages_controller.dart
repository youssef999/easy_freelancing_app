// // Send a message
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:freelancerApp/features/messages/model/message_model.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class ChatController extends GetxController{
// Future<void> sendMessage(String chatId, String text, String senderId) async {
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

// // Stream of chat messages
// Stream<List<Message>> chatMessagesStream(String chatId) {
//   return FirebaseFirestore.instance
//       .collection('chats')
//       .doc(chatId)
//       .collection('messages')
//       .orderBy('timestamp', descending: true)
//       .snapshots()
//       .map((snapshot) => snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
// }

// }