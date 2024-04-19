


// ignore_for_file: must_be_immutable

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/freelancer/freelancer/controllers/freelancer_controller.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/show_service_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate/rate.dart';


class FreelancerDetailsView2 extends StatefulWidget {
 Map<String,dynamic> data;

  FreelancerDetailsView2({super.key, required this.data});


  @override
  State<FreelancerDetailsView2> createState() => _FreelancerDetailsViewState();
}

class _FreelancerDetailsViewState extends State<FreelancerDetailsView2> {

  FreelancerController controller=Get.put(FreelancerController());

  @override
  void initState() {
    controller.getFreelancerServices(widget.data['email']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar:CustomAppBar(widget.data['name'], context, false),
      body:GetBuilder<FreelancerController>(
        builder: (context) {
          return ListView(children: [
            const SizedBox(height: 11,),
            Container(
              height: 300,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 228, 228),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Center(
                child: Image.network(widget.data['image'],),
              ),
            ),
            const SizedBox(height: 5,),
            Center(
                child:
                Container(
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  child: Text(
                    widget.data['name'],
                    style: GoogleFonts.cairo(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                )
            ),
            const SizedBox(height: 10,),
             Center(
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Custom_Text(text: 'cat'.tr,
                      fontSize:16,color:AppColors.textColorDark,
                      ),
                      const SizedBox(width: 17,),
                      Container(
                        constraints: const BoxConstraints(maxWidth: double.infinity),
                        child: Text(
                          widget.data['cat'],
                          style: GoogleFonts.cairo(fontSize: 18
                          , fontWeight: FontWeight.w600, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                )
            ),
               //   dvid(40),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Center(
                    child: GetBuilder<FreelancerController>(
                      builder: (_) {
                        return AnimatedRatingStars(
                          initialRating:
                          controller.finalRate,
                          minRating: 0.0,
                          maxRating: 5.0,
                          filledColor: Colors.amber,
                          emptyColor: Colors.amber,
                          filledIcon: Icons.star,
                          halfFilledIcon: Icons.star_half,
                          emptyIcon: Icons.star_border,
                          onChanged: (double rating) {

                          },
                          displayRatingValue: true,
                          //interactiveTooltips: true,
                          customFilledIcon: Icons.star,
                          customHalfFilledIcon: Icons.star_half,
                          customEmptyIcon: Icons.star_border,
                          starSize: 30.0,
                          animationDuration: const Duration(milliseconds: 300),
                          animationCurve: Curves.easeInOut,
                          readOnly: true,
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 5,),

                  (controller.finalRate.toString()!='Nan')?
                  Custom_Text(text: controller.finalRate.toString(),
                    fontSize: 22,fontWeight:FontWeight.w600,
                  ):const SizedBox(),
                ],
              ),
            ),
          //  const SizedBox(height: 12,),
           // dvid(60),
            const SizedBox(height: 5,),
            const Divider(),
            (controller.freelancerServicesList.isNotEmpty)?
            txtS('services'.tr, 30, FontWeight.w600,
                AppColors.primary):const SizedBox(),

            const SizedBox(height: 5,),
            GetBuilder<FreelancerController>(
                builder: (_) {
                  return freelancerServiceWidget();
                }
            ),
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 9,),
                    (controller.firstCommentList.length!=0)?
                    Custom_Text(text: 'comments'.tr,
                      fontSize:20,fontWeight:FontWeight.w800,
                    ):const SizedBox()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:controller.firstCommentList.length,
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
                                    Text(controller.firstCommentList[index]
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

          ]);
        }
      ),
    );
  }

  Widget freelancerServiceWidget() {

    FreelancerController controller=Get.put(FreelancerController());

     if(controller.freelancerServicesList.isEmpty){
       return Column(children: [
         const SizedBox(height: 5,),
         Custom_Text(text: 'noService'.tr,
         color:AppColors.textColorDark,
         fontSize:28,fontWeight:FontWeight.w600,
         )
       ],);
     }
     else{

       return ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount:controller.freelancerServicesList.length,
           itemBuilder: ((context, index) {
             List <dynamic> list=controller.freelancerServicesList[index]['rate'];
             return InkWell(
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child:  Column(
                   children: [
                     Row(
                       children: [
                         Container(
                           height: 133,
                           clipBehavior: Clip.antiAlias,
                           decoration:  BoxDecoration(
                               color: const Color.fromARGB(255, 228, 228, 228),
                               borderRadius: BorderRadius.circular(

                                   25)),
                           child: Image.network(controller.freelancerServicesList
                           [index]['image'],
                             height: 120,
                             width: 200,
                             fit:BoxFit.cover,
                           ),
                         ),
                         const SizedBox(width: 10,),

                         Column(
                           children: [
                             Custom_Text(text:
                             controller.freelancerServicesList[index]['name'],
                               fontSize: 18,
                               color:AppColors.textColorDark,
                               fontWeight:FontWeight.w600,
                             ),
                             const SizedBox(height: 5,),

                             Custom_Text(text:
                             controller.freelancerServicesList[index]['cat'],
                               fontSize: 16,
                               color:AppColors.primary,
                               fontWeight:FontWeight.w600,
                             ),

                           ],
                         ),
                       ],
                     ),
                     const SizedBox(height: 5,),



                   ],
                 ),



               ),
               onTap:(){


                 // Get.toNamed(Routes.SERVICEDETAILS,arguments:controller.freelancerServicesList );

                 Get.to(ShowServiceDetails(data:
                 controller.freelancerServicesList[index],));


                 // Get.to(ShowServiceDetails(post:
                 // controller.freelancerServicesList[index], data: {},));
                 //
               },
             );
           }));

     }

  }


  txtS(String txt,  double size, FontWeight w, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right: 15,),
      child: Text(
        txt,
        style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
      ),
    );
  }
  dvid(double num) {
    return SizedBox(
        height: num,
        child: const Divider(
          indent: 40,
          endIndent: 40,
          color: Color.fromARGB(50, 0, 0, 0),
        ));
  }

}