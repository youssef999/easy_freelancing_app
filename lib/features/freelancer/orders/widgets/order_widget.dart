import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/const/constant.dart';
import '../controllers/order_controller.dart';

// ignore: must_be_immutable
class OrderCardWidget extends StatelessWidget {
  Map<String, dynamic> data;
  OrderController controller;

  OrderCardWidget({super.key, required this.data, required this.controller});

  @override
  Widget build(BuildContext context) {

  final box=GetStorage();

    String locationName=box.read('locationName')??"";

   String lat=box.read('lat')??"";

   String lng=box.read('lng')??"";
   
    String status='';
    
    if(data['order_status']=='pending'){
      status='pending'.tr;
    }

    if(data['order_status']=='accept'){
      status='finish'.tr;
      
    }

    if(data['order_status']=='refuse'){
      status='cancel'.tr;
    }

    if(data['order_status']=='Done'){
      status='taskFinish'.tr;
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(

            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400]!.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 20,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(11),
                color: AppColors.whiteColor),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.mainly),
                child: Column(children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      data['service_image'] ?? "",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Custom_Text(
                    text: data['service_name'] ?? "",
                    color: AppColors.textColorDark,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(height: 7,),

                  (locationName.length>1
                  && lat.length>1&&lng.length>1
                  )?
                  Row(
                    children: [
                      Custom_Text(text: locationName,
                      fontSize:16,color:AppColors.textColorDark,
                
                      ),
                      IconButton(onPressed: (){
                        controller.openLocation(double.parse(lat)
                        , double.parse(lng));
                      }, icon: const Icon(Icons.location_on))


                    ],
                  ):const SizedBox(),

                  const SizedBox(
                    height: 7,
                  ),
                  (data['client_name'].toString().length>1)?
                   sampleCardData('from'.tr,data['client_name']):
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Custom_Text(text: "${'des'.tr} : ",
                        fontSize:12,color:AppColors.textColorGreyMode,
                        ),
                        Custom_Text(
                          text: data['order_des'] ?? "",
                          color: AppColors.greyColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  sampleCardData('date'.tr, data['date'] ?? ""),
                  const SizedBox(
                    height: 7,
                  ),
                  sampleCardData('taskTime'.tr, data['task_time'] + ' ' + days),
                  const SizedBox(
                    height: 7,
                  ),
                  sampleCardData(
                      'price'.tr, '${data['service_price']} $currency'),
                  const SizedBox(
                    height: 7,
                  ),
                  sampleCardData('status'.tr, status),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         if  (data['order_status']=='pending')
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [

                  
                    CustomButton(
                      color1:AppColors.success.withOpacity(0.9),
                      text: 'finish'.tr, onPressed:(){

                      controller.getUserToken(data['client_email']).then({

                      controller.changeOrderStatus(data['id'],
                      'accept',
                      int.parse( data['service_price'].toString()),
                      data['client_email']
                      )
                      });


                    }),
                    const SizedBox(width: 10,),
                   
                    CustomButton(
                        color1:AppColors.failed.withOpacity(0.9),
                      text: 'cancel'.tr, onPressed:(){

                          controller.getUserToken(data['client_email']).then({

                          controller.getUserBalance(data['client_email']).then((value) {

                          controller.changeOrderStatus(data['id'],
                          'refuse',
                          int.parse(data['service_price'].toString()),
                          data['client_email']
                          );
                          })
                          });
                    })
                ]))])
                  //sampleCardData('des'.tr,data['order_des']),
              )]),
              ),
            )),
      ),
      onTap: () {
        //Get.to(ServiceDetailsView(service: data));
      },
    );
  }
}
Widget sampleCardData(String txt1,String txt2){

  Color txtColor=AppColors.primary;
  if(txt1=='status'.tr){
    if(txt2=='accept'){
      txtColor=AppColors.success;
    }
    if(txt2=='refuse'){
       txtColor=AppColors.failed;
    }

  }
  return   Row(
    children: [
      const SizedBox(width: 14,),
      Text(txt1,style: TextStyle(
          color:AppColors.textColorGreyMode,fontSize:18
      ),),
      const SizedBox(width: 10,),


      Custom_Text(
        text: txt2,
        color: AppColors.primaryDarkColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ],
  );
}
