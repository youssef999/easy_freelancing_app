import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/resources/app_colors.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/features/freelancer/service/views/service_details_view.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ServiceCardWidget extends StatelessWidget {
  Map<String,dynamic> data;

 ServiceCardWidget({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 30),
        child: Container(
          decoration:BoxDecoration(

             boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!.withOpacity(1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
            borderRadius: BorderRadius.circular(11),
            color: AppColors.whiteColor
          ),
          child: Column(children: [
            Container(
              height: 95,
              decoration:  BoxDecoration(borderRadius:BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child:Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(data['image'],
                  fit:BoxFit.cover,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 2,),
            Custom_Text(text: data['name'],
              color:AppColors.textColorDark,fontSize: 20,
            fontWeight:FontWeight.w500,
            ),
            const SizedBox(height: 2,),
            Custom_Text(text: data['price']+" "+currency,
              color:AppColors.primary,fontSize: 20,
              fontWeight:FontWeight.w500,
            ),
            const SizedBox(height: 17),
          ])
        ),
      ),
      onTap:(){
       Get.to(ServiceDetailsView(service: data));
      },
    );
  }
}