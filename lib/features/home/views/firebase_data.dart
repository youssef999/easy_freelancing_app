// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/features/freelancer/freelancer/views/freelancer_details_view.dart';
import 'package:freelancerApp/features/home/controllers/home_controller.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FireBaseView extends GetView<HomeController> {
  final String typeFilter;
  final String collection;
  const FireBaseView(
      {super.key, required this.typeFilter, required this.collection});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final allPosts = snapshot.data!.docs;
        final filteredPosts = typeFilter.isNotEmpty
            ? allPosts.where((post) => post ['type'] == typeFilter).toList()
            : allPosts;
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: SizedBox(
            height: 250,
            child: ListView.builder(
              physics:const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return GestureDetector(
                  onTap: (() {
                    //freelancer
                    if(collection=='freelancers'){
                      print("here");

Get.to(FreelancerDetailsView(
  data: post,
));
                    }
                    else if (collection == 'services'){
      Get.toNamed(Routes.SERVICEDETAILS,arguments:post );
                    }
                    else {
         Get.toNamed(Routes.SERVICEDETAILS,arguments:post );
                    }

                  }),
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
                              image: NetworkImage(  post['image'] ),
                            )),

                        Text(
                          post['name'],
                          style: GoogleFonts.cairo(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                
                );
              },
            ),
          ),
        );
      },
    );
  }
}
