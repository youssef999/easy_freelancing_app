import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/adv.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/emp/views/emp_details_view.dart';
import 'package:freelancerApp/features/home/views/all_emp_view.dart';
import 'package:freelancerApp/features/home/views/all_freelancers_view.dart';
import 'package:freelancerApp/features/home/views/all_services.dart';
import 'package:freelancerApp/features/home/views/firebase_data.dart';
import 'package:freelancerApp/features/search/search_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: CustomAppBar('home'.tr, context, true),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              const AdvWidget(),
              GetBuilder<HomeController>(builder: (_) {
                return Column(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 10, right: 10),

                      child: TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          Get.to(const SearchView());
                          controller.clearSearch();
                          controller.searchController.text='';
                         // controller.isSearching.value=
                          // print('$value');
                           //controller.searchProducts(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: InkWell(child: const Icon(Icons.search),
                          onTap:(){
                            Get.to(const SearchView());
                          },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'search'.tr+"...",
                          hintStyle: const TextStyle(height: 1),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    if (controller.isSearching.value &&
                        controller.searchResults.isNotEmpty)
                      GestureDetector(
                        onTap: controller.clearSearch,
                        child: ListView(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          padding:const EdgeInsets.all(10),
                          children: controller.searchResults.map((document) {
                            final product =
                                document.data() as Map<String, dynamic>;
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 0, bottom: 2),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: Colors.white,
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 1)),
                              child: ListTile(
                                title: Text(product['name'],style: GoogleFonts.cairo(),),
                                trailing: Image.network(product['image'],width: 100,),
                                onTap: () {
                                  Get.toNamed(Routes.SERVICEDETAILS,arguments: document);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left:7.0,right:7,top:3),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'services'.tr,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),InkWell(
                      child: Text(
                        'allServices'.tr,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          color:AppColors.textColorGreyMode,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap:(){
                        Get.to(const AllServicesView());
                      },
                    ),
                  ],
                ),
              ),
              const FireBaseView(
                typeFilter: 'top',
                collection: 'services',
              ),
              Padding(
                padding: const EdgeInsets.only(left:7.0,right:7,top:3),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'freelancers'.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ), InkWell(
                      child: Text(
                        'seeAll'.tr,
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          color:AppColors.textColorGreyMode,
                          fontWeight: FontWeight.bold,
                        ),
                      ),onTap:(){
                        Get.to(const AllFreelancersView());

                    },
                    ),
                  ],
                ),
              ),

              const FireBaseView(
                typeFilter: 'normal',
                collection: 'freelancers',
              ),

    const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left:7.0,right:7,top:3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'serviceProviders'.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'seeAll'.tr,
                        style: GoogleFonts.cairo(
                          fontSize: 17,
                          color:AppColors.textColorGreyMode,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap:(){
                        Get.to(const AllEmpView());
                      },
                    ),
                  ],
                ),
              ),
            GetBuilder<HomeController>(
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: EmployeeWidget(),
                );
              }
            ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget EmployeeWidget(){
    HomeController controller=Get.put(HomeController());
    return SizedBox(
      height: 205,
      child: ListView.builder(
        itemCount: controller.empList.length,
        scrollDirection:Axis.horizontal,
      
        itemBuilder: (context, index) {
        return InkWell(
          child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Colors.white,
                                    width: 1)),
                            clipBehavior: Clip.antiAlias,
                            child: Image(
                              height: 180,
                              width: 150,
                              fit: BoxFit.cover,
                              image: NetworkImage(  controller.empList[index]['image'] ?? '' ),
                            )),
                        Text(
                          controller.empList[index]['name'],
                          style: GoogleFonts.cairo(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
          onTap:(){
             Get.to(EmpDetailsView(
                    emp: controller.empList[index],
                   ));
          },
        );
      }),
    );
  }
}

