import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/chat/views/chat_view.dart';
import 'package:freelancerApp/features/checkout/views/checkout_view.dart';
import 'package:freelancerApp/features/services/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailsView extends GetView<ProductController> {

  const ServiceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
        const Color.fromARGB(245, 255, 255, 255),
        appBar: CustomAppBar(controller.posts?['name'], context, false),
        body: Form(
          child: ListView(
            children: [
              Container(
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 228, 228),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Image.network(controller.posts?['image']),
                ),
              ),
              Center(
                child: txtT('name', 'Hind', 30, FontWeight.w900, Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dvid(40),
                    const SizedBox(
                      height: 5,
                    ),
                    txtS('price'.tr, 'Hind', 20, FontWeight.normal, Colors.black),
                    Row(
                      children: [
                        txtS('startFrom'.tr, 'Hind', 15, FontWeight.normal,
                            Colors.black),
                        const SizedBox(
                          width: 10,
                        ),
                        txtT('price', 'Thasadith', 40, FontWeight.w900,
                            AppColors.primary),
                        txtS(currency, 'Hind', 20, FontWeight.normal, Colors.black)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    dvid(30),
                    // txtS('About This Item', 'Hind', 22, FontWeight.w300,
                    //     Colors.black45),
                    Text(controller.posts?['description'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        )),
                    dvid(60),
                    txtS('freelancer'.tr, 'Hind', 20, FontWeight.w900,
                        Colors.black),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 228, 228, 228),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 70,
                              height: 60,
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: ClipOval(
                                child: Image.network(
                                  controller.posts?['freelancer_image'],
                                  width: 90,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  controller.posts!['freelancer_name'],
                                  style: GoogleFonts.cairo(
                                      color: Colors.black, fontSize: 18),
                                ),
                                Text(
                                  controller.posts!['freelancer_email'],
                                  style: GoogleFonts.cairo(
                                      color: Colors.grey, fontSize: 16),
                                )
                              ],
                            ),

                            IconButton(
                                onPressed: () {
                                 Get.to(ChatView(rec:controller.posts!['freelancer_email']));
                                },
                                icon: const Icon(
                                  Icons.chat,
                                  color: AppColors.primaryDarkColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),


                    Center(
                      child: AnimatedRatingStars(
                        initialRating: controller.finalRate,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: Colors.amber,
                        emptyColor: Colors.grey,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (double rating) {

                        },
                        displayRatingValue: true,
                        interactiveTooltips: true,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star_border,
                        starSize: 30.0,
                        animationDuration: const Duration(milliseconds: 300),
                        animationCurve: Curves.easeInOut,
                        readOnly: true,
                      ),
                    ),



                    const SizedBox(height: 10,),

                    (controller.posts?['comment'].length>0)?
                        Custom_Text(text: 'comments'.tr,
                        fontSize:19,color:AppColors.primary,
                        ):const SizedBox(),


                    for( int i=0;i<controller.posts?['comment'].length;i++)

                      Column(
                        children: [
                          Custom_Text(text: controller.posts?['comment'][i]),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,right:10),
                            child: Divider(color:Colors.grey[300]),
                          )
                        ],
                      ),
                    // Column(
                    //   children: [
                    //
                    //    Custom_Text(text: controller.posts?['comment'])
                    //
                    //   ],
                    // ),



                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: animBtn(() {

                Get.to( CheckOutView(data: controller.posts!));

          //Get.toNamed(Routes.CART);
        }, 'buyService'.tr, AppColors.primary));
  }

  txtT(dynamic txt, String style, double size, FontWeight w, Color color) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Text(
        controller.posts![txt].toString(),
        style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
      ),
    );
  }

  txtS(String txt, String style, double size, FontWeight w, Color color) {
    return Text(
      txt,
      style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
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

  animBtn(void Function() function, String txt, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: function,
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            width: 250,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                txt,
                style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        )
      ],
    );
  }
}
