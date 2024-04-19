import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_dropdown.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/features/freelancer/service/controllers/add_services_controller.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/Custom_Text.dart';

// ignore: must_be_immutable
class EditServicesView extends StatefulWidget {
  Map<String,dynamic>data;
  
   EditServicesView({super.key,required this.data});

  @override
  State<EditServicesView> createState() => _AddServicesViewState();
}

class _AddServicesViewState extends State<EditServicesView> {

 AddServiceController controller=Get.put(AddServiceController(),permanent: true);
  

  @override
  void initState() {
   controller.getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(widget.data['name'], context, false),
      backgroundColor:AppColors.backgroundColor,
      body:Padding(
        padding: const EdgeInsets.all(5.0),
        child: GetBuilder<AddServiceController>(
          builder: (_) {
            return ListView(children: [
                            (controller.pickedImageXFiles != null
                                && controller.pickedImageXFiles!.isNotEmpty)?
                            Column(
                              children: [
                                const SizedBox(height: 10,),
                                Container(
                                  decoration:BoxDecoration(border:
                                  Border.all(color:AppColors.primary,
                                  width: 2
                                  ),

                                  borderRadius:BorderRadius.circular(15)),
                                   
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                      child: Container(
                                        height:  MediaQuery.of(context).size.width*0.41,
                                        width: MediaQuery.of(context).size.width*0.6,
                                        
                                        decoration:BoxDecoration(
                                    
                                            image: DecorationImage(
                                                image:
                                            
                                                FileImage(
                                                    File(controller.pickedImageXFiles![0]
                                                        .path)),
                                                
                                                fit:BoxFit.fill
                                            )
                                        ),
                                      ),
                                      onTap:(){
                                        controller.pickMultiImage();
                                      },
                                    ),
                                  ),
                                ),
                              ])
                                :     InkWell(
                              child:  Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 100,
                                    child:Icon(Icons.image,size: 60,)
                                  ),
                                  const SizedBox(height: 10,),
                                  Custom_Text(text: 'editServiceImage'.tr,color:Colors.black,
                                    fontSize:21,alignment:Alignment.center,
                                  ),
                                ],
                              ),
                              onTap:() {

                                controller.pickMultiImage();
                              //  cubit.showDialogBox(context);
                              },
                            ),
                            const SizedBox(height: 5,),
     
              Container(
              //  height:300,
                decoration:BoxDecoration(borderRadius:BorderRadius.circular(21),
                color:AppColors.primary
                
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      CustomTextFormField(hint: widget.data['name'],
                      validateMessage: '',
                      icon:Icons.design_services,
                       obs: false, color: AppColors.textColorDark
                       , controller: controller.serviceNameController),
                
                        const SizedBox(
                    height: 15,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top:3.0,left:18,right:18),
                    child: GetBuilder<AddServiceController>(
                      builder: (_) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Custom_Text(text: 'selectCat'.tr,
                                    fontSize: 16,color:AppColors.textColorLight,
                                    ),
                                    const SizedBox(width: 7,),
                                      Custom_Text(text: widget.data['cat'].toString(),
                                    fontSize: 16,color:AppColors.textColorGreyMode,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 6,),
                            SizedBox(
                             height:60,
                             width: MediaQuery.of(context).size.width,
                              child: CustomDropDown(value: controller.selectedCategory,
                                items: controller.catNames,
                                function:  controller.changeCatValue,
                                
                              ),
                            ),
                           
                          ],
                        );
                      }
                    ),
                  ),
                              const SizedBox(height: 15,),
                               CustomTextFormField(hint: widget.data['description'],
                               icon:Icons.description,
                   obs: false, color: AppColors.textColorDark,
                
                   validateMessage: '',
                   max: 6
                   , controller: controller.serviceDescriptionController),
                              
                            
                              const SizedBox(height: 15),
                            
                               CustomTextFormField(hint: widget.data['price'].toString(),
                               icon:Icons.price_change,
                               
                   obs: false, color: AppColors.textColorDark,
                   validateMessage: '',
                   type:TextInputType.number
                   , controller: controller.servicePriceController),
                              
                   const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
          

               Padding(
                 padding: const EdgeInsets.only(left:35.0,right: 35,bottom:15),
                 child: CustomButton(text: 'edit'.tr
                 , onPressed: (){
                
                               controller. updatService(widget.data['serviceId']);
                             
                 }, ),
               )
            
               
            
            
            
            
            
            
            
            
            ]);
          }
        ),
      ),
    );
  }
}