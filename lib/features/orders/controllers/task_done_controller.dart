

// ignore_for_file: avoid_print, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield2.dart';
import 'package:freelancerApp/features/root/view/root_view.dart';
import 'package:get/get.dart';

class TaskDoneController extends GetxController{


TextEditingController commentController=TextEditingController();

 double value = 0.0;

 changeValue(double val){   

   value=val;
   update();
 }


  noShowDialog(BuildContext context,Map<String,dynamic>data){
    
    showDialog(
              context: context,
              builder: (BuildContext context) {
                // Return the AlertDialog widget
                return AlertDialog(
                  title: Text('taskError'.tr),
                  //content: const Text(''),
                  actions: <Widget>[
                    Center(
                      child: Custom_Text(text: 'makeComment'.tr,
                      alignment:Alignment.topLeft,
                      color:AppColors.textColorGreyMode,
                      ),
                    ),

                    const SizedBox(height: 6,),
                    CustomTextFormField(hint: 'comment'.tr,
                    max: 6,icon:Icons.comment_outlined
                    , obs: false, controller: commentController),
                
                  
                  const SizedBox(height: 11),

              Center(child: CustomButton(text: 'send'.tr, onPressed: (){


              // order comment
              // update order status

                      orderComment(data['id'],).then((value) {
                      updateOrderStatus(data['id'], 'pending');
                   });

              }))


                  ],
                );
              },
            );
   
  }

  yesShowDialog(BuildContext context,Map<String,dynamic>data){
    
    showDialog(
              context: context,
              builder: (BuildContext context) {
                // Return the AlertDialog widget
                return AlertDialog(
                  title: Text('taskFinished'.tr),
                  
                  actions: <Widget>[
                    Center(
                      child: Custom_Text(text: 'makeComment'.tr,
                      alignment:Alignment.topLeft,
                      color:AppColors.textColorGreyMode,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    CustomTextFormField(hint: 'comment'.tr,
                    max: 6,icon:Icons.comment_outlined
                    , obs: false, controller: commentController),
                     const SizedBox(height: 6,),
                    


        Center(
          child: AnimatedRatingStars(
            initialRating: value,
            minRating: 0.0,
           maxRating: 5.0,
                 filledColor: Colors.amber,
                 emptyColor: Colors.grey,
                 filledIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                emptyIcon: Icons.star_border,
                 onChanged: (double rating) {
          
                changeValue(rating);
              // Handle the rating change here
              print('Rating: $rating');
             },
               displayRatingValue: true,
               interactiveTooltips: true,
               customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half,
               customEmptyIcon: Icons.star_border,
                starSize: 30.0,
               animationDuration: const Duration(milliseconds: 300),
                animationCurve: Curves.easeInOut,
                readOnly: false,
                ),
        ),
                  const SizedBox(height: 11),

              Center(child: CustomButton(text: 'send'.tr, onPressed: (){

               print('here2025');

               //update rate and comment to the service
               // order done that add new balance to the wallet
               // update order status


                //update rate and comment to the service
                updateServiceRate(data['service_image']).then((value) {

             // order done that add new balance to the wallet
                orderDone(data['freelancer_email'],
                 data['service_price'].toString());


                    // update order status
               updateOrderStatus(data['id'], 'Done');


                });
            
              }))

                     
        
      


                  ],
                );
              },
            );
  }



 int freelancerTotalBalance=0;

  getFreelancerBalance(String email)async{

   print("freelanceing20202020");
   
   freelancerTotalBalance=0;

   QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('wallet').where('email',isEqualTo: email)
        .get();
        
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
   
    freelancerTotalBalance=data[0]['balance'];
      // ignore: duplicate_ignore, duplicate_ignore, duplicate_ignore
      }catch(e){
        // ignore: avoid_print
        print("E.......");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E.......");
      }
      print("total===$freelancerTotalBalance");
      update();
 }



  orderDone(String email,String price) async {

 print("totalBALANCE===$freelancerTotalBalance");

 int newBalance = int.parse(price)+freelancerTotalBalance;
 
  CollectionReference wallet =FirebaseFirestore.instance.collection('wallet');
      
      // Update data where a specific condition is met
      await wallet
          .where('email', isEqualTo: email) // Example where clause: age is less than 30
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Update each document found
          wallet.doc(doc.id).update({
            'balance': newBalance
            });
        });
      });
      
      print('Data updated successfully');
       
 }



 
     updateServiceRate (String serviceImage) async {

      print("UPDATE....");

      commentList.add(commentController.text);

      rateList.add(value.toString());

     CollectionReference service =FirebaseFirestore.instance.
      collection('services');
      // Update data where a specific condition is met
      await service
          .where('image', isEqualTo: serviceImage) // Example where clause: age is less than 30
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Update each document found
          service.doc(doc.id).update({

            'rate': rateList,
            'comment': commentList
   
            });
        });
      });
 }
        

     orderComment (String orderId) async {

       print("UPDATE..20222555..");

     CollectionReference service =FirebaseFirestore.instance.
      collection('orders');
      // Update data where a specific condition is met
      await service
          .where('id', isEqualTo: orderId) // Example where clause: age is less than 30
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Update each document found
          service.doc(doc.id).update({
            
            'comment': commentController.text
  
            });
        });
      });
 }





   updateOrderStatus (String orderId,String status) async {

  print("UPDATE...,.....77272.");


     CollectionReference  order=FirebaseFirestore.instance.
      collection('orders');
      // Update data where a specific condition is met
      await order
          .where('id', isEqualTo: orderId) // Example where clause: age is less than 30
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Update each document found
          order.doc(doc.id).update({
           'order_status': status
            }).then((value) {

              Get.back();
              Get.offAll(RootView());

              appMessage(text: 'done'.tr, fail: false);

          });
        });
      });
    }


    List<dynamic>commentList=[];
    List<dynamic>rateList=[];


    getServiceCommentAndRate(serviceImage)async {
 print("UPDATE........99302..");


     QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        ('services').where('image',isEqualTo: serviceImage)
        .get();

      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        print("data==$data");
   
    commentList=data[0]['comments'];
    rateList=data[0]['rate'];
      // ignore: duplicate_ignore, duplicate_ignore, duplicate_ignore
      }catch(e){
        // ignore: avoid_print
        print("E....xx...");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E....xxx...");
      }
      update();
    }

    
   








 
    
   
  }



 




