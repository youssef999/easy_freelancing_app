

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:get/get.dart';
import 'package:rate/rate.dart';


import '../../../checkout/views/checkout_view2.dart';

// ignore: must_be_immutable
class ShowServiceDetails extends StatefulWidget {

  Map<String,dynamic> data;

 ShowServiceDetails({super.key,required this.data});

  @override
  State<ShowServiceDetails> createState() => _ShowServiceDetailsState();
}

class _ShowServiceDetailsState extends State<ShowServiceDetails> {

  FreelancerController controller=Get.put(FreelancerController());


  @override
  void initState() {

     controller.getFreelancerServices(widget.data['freelancer_email']);
     controller.getServiceComments(widget.data);
      super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor:Colors.black,
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 12,),
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:NetworkImage(widget.data['image']),
              ),
              const SizedBox(width: 20,),
              Custom_Text(text: widget.data['name'],
              fontSize:20,fontWeight: FontWeight.w600,
              )
            ],
          ),
          const SizedBox(height: 12,),
        Row(
        children: [

       Custom_Text(text: 'price'.tr,
       fontSize:18,fontWeight: FontWeight.w600,
       ),
       const SizedBox(width: 10,),
        Custom_Text(text: widget.data['price'].toString()+currency,
        fontSize:30,fontWeight:FontWeight.bold,
        color:AppColors.primary,
        ),
        ],
      ),
          GetBuilder<FreelancerController>(
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Rate(
                      iconSize: 23,
                      color: Colors.amber,
                      allowHalf: true,
                      // allowClear: true,
                      initialValue:
                      double.parse(controller.rateV.toString()),
                      //double.parse(.toString()),
                      readOnly: true,
                      onChange: (value) => print(value),
                    ),
                    const SizedBox(width: 5,),
                    Custom_Text(text: controller.rateV.toString(),
                      fontSize: 22,fontWeight:FontWeight.w800,
                    )
                  ],
                ),
              );
            }
          ),
           const SizedBox(height: 12,),
            Custom_Text(text: widget.data['description'],
            color:AppColors.textColorGreyMode,
              fontSize:16,fontWeight: FontWeight.w500,
              ),
               const SizedBox(height: 11,),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 9,),
                  Custom_Text(text: 'comments'.tr,
                    fontSize:20,fontWeight:FontWeight.w800,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:controller.serviceCommentList.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.comment,
                                      color:Colors.blueAccent
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(controller.serviceCommentList[index]
                                      .toString().replaceAll('[','').replaceAll(']', ''),

                                    style:const TextStyle(
                                        fontSize:16,
                                        color:Colors.grey,
                                        fontWeight:FontWeight.w500
                                    ),

                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 0.4,
                              color:Colors.grey[800],
                            )
                          ],
                        );

                      }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11,),
               Padding(
                 padding: const EdgeInsets.only(left:14.0,right: 14),
                 child: CustomButton(text: 'buyService'.tr, onPressed: (){

                   Get.to(CheckOutView2(data: widget.data));
                  // Get.to( CheckOutView(data: data));


                   // DocumentSnapshot snapShot=data as DocumentSnapshot<Object?>;
                   //
                   //  Get.to(CheckOutView(data: snapShot));

                //   Get.toNamed(Routes.SERVICEDETAILS,arguments:data );


                  // Get.to(const ServiceDetailsView());

                 }),
               )



        ]),
      ),
    );
  }
}