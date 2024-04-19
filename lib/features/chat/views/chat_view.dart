// ignore_for_file: avoid_print, must_be_immutable, unused_local_variable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/resources/app_strings.dart';
import 'package:freelancerApp/core/widgets/custom_loading.dart';
import 'package:freelancerApp/features/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;

class ChatView extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  String rec;

  ChatView({Key? key, required this.rec}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  ChatController controller = Get.put(ChatController());
  @override
  void initState() {
    super.initState();
    controller.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainly,
        title: Row(
          children: [
            Image.asset('assets/images/chat.webp', height: 25),
            const SizedBox(width: 70),
            Column(
              children: [
                Text(
                  'chat'.tr,
                  style: GoogleFonts.cairo(),
                ),
                Custom_Text(text: 'sentLargeFilesAsLink'.tr,
                fontSize: 14,color:Colors.grey,
                ),
                const SizedBox(height: 6,),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamWidget(
              rec: widget.rec.toString(),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.mainly,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.10),
                      offset: const Offset(0, -4),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  Wrap(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          var imageUrl =
                              controller.getImage(ImageSource.gallery);
                          CustomLoading.showLoading('Sending');
                          imageUrl.then((value) =>
                              controller.sendMessage(widget.rec, value));
                          CustomLoading.cancelLoading();
                          // if (imageUrl != null && imageUrl.trim() != '') {
                          // controller.imageUrlX = imageUrl;

                          // }
                          Timer(const Duration(milliseconds: 100), () {
                            controller.messageController.clear();
                          });
                        },
                        icon: Icon(
                          Icons.photo_outlined,
                          color: Get.theme.colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          var imageUrl =
                              controller.getImage(ImageSource.camera);
                          CustomLoading.showLoading('Sending');

                          imageUrl.then((value) =>
                              controller.sendMessage(widget.rec, value));
                          CustomLoading.cancelLoading();
                        },
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Get.theme.colorScheme.secondary,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        controller.messageText = value;
                      },
                      controller: controller.messageController,
                      style: Get.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Type to start chat".tr,
                        hintStyle: TextStyle(
                            color: Get.theme.focusColor.withOpacity(0.8)),
                        suffixIcon: IconButton(
                          padding: const EdgeInsetsDirectional.only(
                              end: 20, start: 10),
                          onPressed: () {

                            if (controller.messageText != '') {
                              controller.sendMessage(widget.rec, '');
                              controller.messageText = '';
                              controller.messageController.clear();
                            } else {
                              null;
                            }
                          },
                          icon: const Icon(
                            Icons.send_outlined,
                            color: AppColors.primaryDarkColor,
                            size: 30,
                          ),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamWidget extends StatelessWidget {
  String rec;
  MessageStreamWidget({super.key, required this.rec});

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();
    String email = box.read('email') ?? 'x';
    String roleId = box.read('roleId') ?? '1';

    String r = '';
    String e = '';

    if (roleId == '1') {
      r = rec;
      e = email;
    } else {
      r = email;
      e = rec;
    }

    print("R===sender=xx===$r");
    print("E==rec====$e");
    // print("EMAILxx==$email");
    // print('reCXXXX==$rec');
    Ui.logError('Receievr is $rec');
    Ui.logError('Sender is $email');
    ChatController controller = Get.put(ChatController());

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {

          List<MessageLine> messageWidgets = [];
          if (!snapshot.hasData) {
            //
          }

          final messages = snapshot.data?.docs.reversed ?? [];

          for (var message in messages) {
            final messageText = message.get('text');
            final time = message.get('time');
            final receiver = message.get('rec');
            final currentUser = controller.signedInUser.email;
            final imageSend = message.get('image');
            Ui.logSuccess('MSg $messageText');
            Ui.logSuccess('currentU $currentUser');
            //  Ui.logSuccess('A $sender');
            String roleId = box.read('roleId')??'1';
            String sender = '';

            sender = message.get('sender');

            final messageSender = sender;
            Ui.logSuccess('SenderTTTT $sender');
            Ui.logSuccess('RecevierTTTTSent $rec');
            Ui.logError('RecevierTTTTFire $receiver');
            Ui.logSuccess('------------------------------- ');

            bool isMe = false;

            if (email == messageSender) {
              isMe = true;
            }

            if ((rec == sender && currentUser == receiver) ||     (currentUser == sender && rec == receiver)) {
              final messageWidget = MessageLine(
                  sender: messageSender,
                  txt: messageText,
                  image: imageSend,
                  isMe: isMe,
                  time: time ?? Timestamp.fromMicrosecondsSinceEpoch(1));
              messageWidgets.add(messageWidget);
            }

            //Text('$messageText $messageSender');
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  String txt;
  String? image;
  String sender;
  Timestamp time;
  bool isMe;

  MessageLine({
    super.key,
    this.image,
    required this.time,
    required this.sender,
    required this.txt,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe
                  ? AppColors.primaryDarkColor.withOpacity(0.2)
                  : AppColors.mainly.withOpacity(1),
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(sender,
                          style: Get.textTheme.bodyMedium?.merge(
                              const TextStyle(fontWeight: FontWeight.w600))),
                      Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: image == null || image == ''
                              ? Text(txt,
                                  style: GoogleFonts.cairo(fontSize: 18))
                              : Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                      fit: BoxFit.cover, width: 200, image!))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              child: Text(
                DateFormat('d, MMMM y | HH:mm', Get.locale.toString()).format(
                    DateTime.fromMillisecondsSinceEpoch(
                        time.millisecondsSinceEpoch)),
                overflow: TextOverflow.fade,
                softWrap: false,
                style: Get.textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
    );
  }
}
