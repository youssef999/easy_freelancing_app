// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/Custom_button.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/core/widgets/custom_textformfield.dart';
import 'package:freelancerApp/features/checkout/controllers/checkout_controller.dart';
import 'package:freelancerApp/features/emp/views/select_location2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class EmpCheckoutView extends StatefulWidget {
  Map<String, dynamic> data;

  EmpCheckoutView({super.key, required this.data});

  @override
  State<EmpCheckoutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<EmpCheckoutView> {
  CheckoutController controller = Get.put(CheckoutController());
  final box=GetStorage();
    Rx<String> locationName = ''.obs;
   
  @override
  void initState() {
    locationName= box.read('location').toString().obs;
    controller.getUserName();
    controller.getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar( widget.data['name'].toString(), context, false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 10,),
          // Center(
          //   child: Custom_Text(
          //     text: widget.data['name'],
          //     color: AppColors.textColorDark,
          //     fontSize: 20,
              
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              Custom_Text(fontSize: 20,
                text: 'price'.tr,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                width: 10,
              ),
              Custom_Text(
                text: '${widget.data['price']} $currency',
                color: AppColors.primary,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
              hint: 'location'.tr,
              max: 3,
              obs: false,
              icon: Icons.local_offer_outlined,
              controller: controller.locationController),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              hint: 'price'.tr,
              icon: Icons.price_change,
              obs: false,
              type: TextInputType.number,
              controller: controller.priceController),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              hint: 'avgTime'.tr,
              icon: Icons.timelapse,
              type: TextInputType.number,
              obs: false,
              controller: controller.timeController),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              hint: 'notes'.tr,
              icon: Icons.notes,
              max: 3,
              obs: false,
              controller: controller.notesController),
          const SizedBox(
            height: 22,
          ),

            Obx(() {
                                      return InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                              BorderRadius.circular(15)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Custom_Text(
                                                  text: 'selectLocation'.tr,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors
                                                      .textColorDark,
                                                ),
                                                Icon(
                                                  Icons.location_on,
                                                  color: AppColors.primary,
                                                  size: 30,
                                                ),
                                                locationName.value !=
                                                    'null' ||
                                                    locationName.value !=
                                                        ''
                                                    ? SizedBox(
                                                    width: 150,
                                                    height: 50,
                                                    child: Center(
                                                        child: Text(
                                                          locationName.value,
                                                          style: GoogleFonts
                                                              .cairo(
                                                              color: Colors
                                                                  .grey),
                                                          overflow:
                                                          TextOverflow
                                                              .fade,
                                                        )))
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Get.to(SearchPlacesView2(
                                            data: widget.data,
                                          ));
                                       //   Get.toNamed(Routes.LOCATION);
                                        },
                                      );
                                    }),
          
           const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right: 18),
            child: CustomButton(
                text: 'sendOffer'.tr,
                onPressed: () {
                 controller.addOrderToFirebase2(widget.data);
                }),
          ),
         
        ]),
      ),
    );
  }
}
