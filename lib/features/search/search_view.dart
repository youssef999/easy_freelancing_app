

// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';


class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<SearchView> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  TextEditingController controller = TextEditingController();
  
  String searchData = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppBar('search'.tr, context, false),
       
        body: ListView(children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10)
                ),
                child:Row(children: [
                  const SizedBox(width: 8,),
                  SvgPicture.asset('assets/icon/icon-search.svg',
                  color:Colors.grey,),
                  const SizedBox(width: 8,),
                  Expanded(child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: -0.41,
                    ),
                    decoration: InputDecoration(
                      hintText: 'search'.tr,
                      border: InputBorder.none,
                      isDense:true,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.6),
                        fontSize: 17,
                        letterSpacing: -0.41,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchData = value.toString().capitalize!;
                      });
                    }
                  )),

                  const SizedBox(width: 8,),
              
                  const SizedBox(width: 8,)
                ]),
              )
            
              ),
          const SizedBox(
            height: 20,
          ),
          searchWidget()
        ]));
  }

  Widget searchWidget() {

    print("PR===="+searchData.toString());
    //  final box=GetStorage();
    //      String lang= box.read('locale')??'en';
    //      String name='name';
    //      String cat='cat';
    //      if(lang=='ar'){
    //       name='nameAr';
    //       cat='catAr';
    //      }
    return SizedBox(
   
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('services')
                .where('name', isGreaterThanOrEqualTo
                : searchData)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('loading'.tr));
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Custom_Text(text: "${'loading'.tr}...");
                default:
                  return ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot posts = snapshot.data!.docs[index];
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        return

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.greyColor.withOpacity(0.1),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image:NetworkImage(
                                             posts['image']),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    //here
                                    Column(
                                      children: [
                                        
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width:100,
                                          child: Text(
                                           posts['name'],
                                           overflow:TextOverflow.ellipsis,
                                           //.toString().substring(0,2),
                                            style:  TextStyle(
                                        
                                              fontSize: 14,
                                              color: AppColors.textColorDark,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 11,),
                                   
                               
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              posts['price'].toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff80B1FE),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                             const Text(
                                          currency,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),

                                      const SizedBox(height: 10,)
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                           onTap:(){
                            Get.toNamed(Routes.SERVICEDETAILS,arguments: posts);
                     
                           },
                           
                            ),
                          );
                        

                      });
              }
            }));
  }
}
