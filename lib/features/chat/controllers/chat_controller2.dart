

// // ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, duplicate_ignore

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';

// class ChatController extends GetxController{
//   final auth = FirebaseAuth.instance;
//   late User signedInUser;
//   String messageText='';
//    Rx<bool>? isEMP = false.obs;
//   File? imageFile;
//   TextEditingController messageController=TextEditingController();

//  @override
//   void onInit() async {
//     ChatController();
//     super.onInit();
//   }


//   void getCurrentUser() {
//     try {
//       final user = auth.currentUser;
//       if (user != null) {
//         signedInUser = user;
//         // ignore: avoid_print
//         print(signedInUser.email);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future getImage(ImageSource source) async {
//     ImagePicker imagePicker = ImagePicker();
//     XFile? pickedFile;

//     pickedFile = await imagePicker.pickImage(source: source);
//     imageFile = File(pickedFile!.path);

//     if (imageFile != null) {
//       try {
//         final d = await uploadFile(imageFile!);
//         print('hahahahahaha ${d}');
//         return  d;
        
//       } catch (e) {
//        print( e);
//       }
//     } else {
//       print("Please select an image file".tr);
//     }
//   }

//   Future<String> uploadFile(File _imageFile) async {

//     String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
//     Reference reference = FirebaseStorage.instance.ref().child(fileName);
//     UploadTask uploadTask = reference.putFile(_imageFile,SettableMetadata(contentType: 'image/jpeg'));
//     print("fire err xx1 ${uploadTask.toString()}");
//     return uploadTask.then((TaskSnapshot storageTaskSnapshot) {
//       print("fire err xx2 ${storageTaskSnapshot.ref.getDownloadURL()}");
     
//       return storageTaskSnapshot.ref.getDownloadURL().then((value) { 
//      print('fireeeeee $value'); 
    
//      return  value ;
//       }
     
//       );
//     }, onError: (e) {
//       throw Exception("fire err xx3 ${e.toString()}");
//     });
//   }

//   sendMessage(String rec,String imageUr )async{

//     final box=GetStorage();
//     String email=box.read('email') ?? '';
//    // print('baaaaas ${imageUrl.value.isEmpty}');
//      String roleId=box.read('roleId') ?? '1';
   
//     String r='';
//     String e='';

//       if(roleId=='1'){
//        r=rec;
//        e=email;
//       }

//       else{
//         r=email;
//         e=rec;
//       }

//       print("EE======"+e.toString());
//       print("RR======"+r.toString());


//    if(roleId=='1'){
//      await  FirebaseFirestore.instance.collection('chat').add({
//        'image':imageUr,
//        'text': messageText,
//        'sender': e,
//        //e,
//        'time': FieldValue.serverTimestamp(),
//        'rec':r,
//        //'reciever':''
//      });
//    }else{
//      await  FirebaseFirestore.instance.collection('chat').add({
//        'image':imageUr,
//        'text': messageText,
//        'sender': r,
//        //e,
//        'time': FieldValue.serverTimestamp(),
//        'rec':e,
//        //'reciever':''
//      });
//    }

//   }

//   getMessages(String rec)async {

//    print("GET MESSSAGES");
//    //sender 'sender': r, r=rec
//     final box=GetStorage();
//       // ignore: unused_local_variable
//       String email=box.read('email');
//         String roleId=box.read('roleId');

//         String e='';
//         String r='';

//         if(roleId=='1'){
//           e=email;
//           r=rec;
//         }
//         else{
//           e=rec;
//           r=email;
//         }
//     print("SENDER=="+e);

//     print("RECCC=="+r);



//    final messages= await FirebaseFirestore.instance.collection('chat')
//    .where('sender',isEqualTo: e).where('rec',isEqualTo:r)
   
//    .orderBy('time')
//    .get();

//   for(var message in messages.docs){
//     // ignore: avoid_print
//     print(message.data());
//   }
//   }


//   void messageStreams()async{
//     await for(var snapShot in 
//     FirebaseFirestore.instance.collection('chat').snapshots()){
//      for (var message in snapShot.docs){
//       print(message.data());
//      }
//     }
//   }

//  List<Map<String,dynamic>>userChatList=[];
//  List<String>recNames=[];


//   getAllUserChat()async{

//       final box=GetStorage();
//       String roleId=box.read('roleId')??'1';
//      String type='';
//       if(roleId=='1'){
//         type='sender';
//       }
//       else{
//         type='rec';
//       }
//       // ignore: unused_local_variable
//       String email=box.read('email')??"freelancer2024@gmail.com";

//       print("EMAIL========="+email);
//     userChatList= [];
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('chat')
//         .where(type,isEqualTo:email)
//         .get();
//     try {
//       List<Map<String, dynamic>> data = querySnapshot.docs
//           .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
//           .toList();

//      userChatList= data;
//     // userChatList= userChatList.toSet().toList();
     
//     } catch (e) {
//       // ignore: avoid_print
//       print("E.......");
//       // ignore: avoid_print
//       print(e);
//       // orderState='error';
//       // ignore: avoid_print
//       print("E.......");
//     }
//     print('chat==='+userChatList.toString());
//     filterReceiver();
   

//     update();

//   }



//   filterReceiver()async{

// final box=GetStorage();
// String roleId=box.read('roleId')??'1';

// if(roleId=='1'){
// for(int i=0;i<userChatList.length;i++){
//     if(recNames.contains(userChatList[i]['rec'])){
//      print("CONTAINS");
//      isEMP = true.obs;
//     }else{
//      isEMP = false.obs;
//  recNames.add( userChatList[i]['rec']);
      
//     }
//      update();

//    }
// }

// else{
//   for(int i=0;i<userChatList.length;i++){
//     if(recNames.contains(userChatList[i]['sender'])){
//      print("CONTAINS");
//     }

//     else{
//  recNames.add( userChatList[i]['sender']);
//     }
//      update();
//    }
// }
   



//   }


// }
  


