// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import '../controllers/task_done_controller.dart';

class TaskDoneView extends StatefulWidget {

  Map<String,dynamic> data;
  
  TaskDoneView({super.key,required this.data});

  @override
  State<TaskDoneView> createState() => _TaskDoneViewState();
}

class _TaskDoneViewState extends State<TaskDoneView> {

TaskDoneController controller=Get.put(TaskDoneController());

 @override
  void initState() {
    
    controller.getServiceCommentAndRate(widget.data['service_image']);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<TaskDoneController>(
          builder: (_) {
            return ListView(children: [
              const SizedBox(height: 10,),
            
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Custom_Text(text: 'taskDone'.tr,
                color:AppColors.textColorDark,fontSize: 25,
                fontWeight:FontWeight.bold,
                ),
              ),
            
              const SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                  CustomButton(
                    color1:AppColors.success,
                    color2:AppColors.textColorLight,
                    text: 'yes'.tr,
                   onPressed: () {

                    controller.getFreelancerBalance
                    (widget.data['freelancer_email']).then((value){
                
                    controller.yesShowDialog(context,
                    widget.data
                    );

                   
                            
                   });
                   }
                  ),
                   
                            
                    CustomButton(
                    color1:AppColors.failed,
                    color2:AppColors.textColorLight,
                    text: 'no'.tr,
                   onPressed: (){

                    controller.noShowDialog(context,
                    widget.data
                    );
                            
                   })
                ],),
              ),
            
            
            
              
            ]);
          }
        ),
      ),
    );
  }
}