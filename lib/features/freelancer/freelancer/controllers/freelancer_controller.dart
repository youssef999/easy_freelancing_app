

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FreelancerController extends GetxController{


List<Map<String,dynamic>> freelancerServicesList=[];



List<Map<String,dynamic>> freelancerData=[];
final box=GetStorage();



double sumRate=0;

double finalRate=1;

List<num>ratingList=[];


List<String> firstCommentList=[];
List<String> serviceCommentList=[];


filterComment(){
  print("COMM");
  firstCommentList=freelancerServicesList[0]['comment'].toString().split(',');
  print("CCCCOOOO"+firstCommentList.toString());
  update();
}

  getFreelancerData()async{
   print("FREELNACER........XXX......");
    String email=box.read('email')??'';
    freelancerData = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('freelancers')
        .where('email',isEqualTo:email)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      freelancerData = data;
     
    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    print("FFFDATAAAAAAAA==$freelancerData");

    update();
 }

  getFreelancerServices(String email) async {

    finalRate=0;

    sumRate=0;

    firstCommentList=[];
     print("EMAIL=="+email);
    freelancerServicesList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('services')
        .where('freelancer_email',isEqualTo:email)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      freelancerServicesList = data;

      for(int i=0;i<freelancerServicesList.length;i++){

        List<dynamic>list=freelancerServicesList[i]['rate'];

        for(int i=0;i<list.length;i++){
          ratingList.add(num.parse(list[i].toString()));
        }
    }

      print("RATING LIST========="+ratingList.toString());

      for(int i=0;i<ratingList.length;i++){
        sumRate=ratingList[i]+sumRate;
      }



      finalRate=sumRate/ratingList.length;

      if(ratingList.isEmpty){
        finalRate=0;
      }

      update();

      print("Final rate==="+finalRate.toString());

      filterComment();

    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    print("SERVICESS==$freelancerServicesList");



  }


  List<dynamic>serviceRateList=[];
  double sum=0;
  double rateV=1;

  getServiceComments(Map<String,dynamic>data) {
    sum=0;
    rateV=1;
    serviceCommentList = data['comment'].toString().split(',');
    serviceRateList = data['rate'];

    for (int i = 0; i < serviceRateList.length; i++) {
      sum = serviceRateList[i] + sum;
    }
    print("SUMM==" + sum.toString());
    rateV = sum / serviceRateList.length;
    print("RATEVV==" + rateV.toString());

  }
}