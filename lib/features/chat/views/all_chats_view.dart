import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/chat/controllers/chat_controller.dart';
import 'package:freelancerApp/features/chat/views/chat_view.dart';
import 'package:get/get.dart';

class AllChatsView extends StatefulWidget {
  const AllChatsView({super.key});

  @override
  State<AllChatsView> createState() => _AllChatsViewState();
}

class _AllChatsViewState extends State<AllChatsView> {
  ChatController controller = Get.put(ChatController());
  @override
  void initState() {
    controller.getAllUserChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar('chat'.tr, context, true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Obx(() {
            return controller.isEMP?.value == true
                ? AllChatWidget(
              controller: controller,
            )
                :
            AllChatWidget(
              controller: controller,
            );

            //   Padding(
            //   padding: const EdgeInsets.only(top: 300),
            //   child: Text('Empty Chats Lists',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontSize: 35, ),),
            // );
          })
        ]),
      ),
    );
  }
}

class AllChatWidget extends StatelessWidget {
  ChatController controller;
  AllChatWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (_) {

      if(controller.recNames.isEmpty){
        return Center(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/chat.webp')),
                  const SizedBox(height: 10,),
                  Custom_Text(text: 'noChat'.tr,
                  color:AppColors.textColorDark,fontSize:22,
                    fontWeight:FontWeight.w700,
                  )
            ],),
          ),
        );
      }else{
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.recNames.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainly),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Custom_Text(
                                text: controller.recNames[index],
                                color: AppColors.textColorDark,
                                fontSize: 18,
                              ),
                              Custom_Text(
                                text: controller.recTexts[index],
                                color: Color.fromARGB(255, 141, 141, 141),
                                fontSize: 15,
                              ),
                            ],
                          ),
                          CustomButton(
                              text: 'chat'.tr,
                              onPressed: () {
                                Get.to(ChatView(
                                  rec: controller.recNames[index],
                                ));
                              })
                        ],
                      ),
                    ]),
                  ),
                ),
              );
            }));
      }

    });
  }
}