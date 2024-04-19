

// ignore_for_file: avoid_print, duplicate_ignore, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancerApp/features/payment/views/payment_view.dart';
import 'package:freelancerApp/features/payment/views/payment_view2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {




String baseUrl='';

String webUrl='';

List<Map<String,dynamic>> userData=[];



  getClientData(Map<String,dynamic>data,num amount)async {
  final box=GetStorage();
  String roleId=box.read('roleId')??'1';
  String type='';

  if(roleId=='1'){
   type='users';
  }else{
    type='freelancers';
  }


   String email=box.read('email');

   userData=[];

 print("TYPE===$type");
 print("ROLEID==========="+roleId.toString());

QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        (type).where('email',isEqualTo: email).get();
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
     
        userData=data;

        print("DATA====="+data.toString());


        
      }
      
      catch(e){
        // ignore: avoid_print
        print("E.......");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E.......");
      }
      update();
          amount=amount*0.35;
      getApi(amount,data);
}



 getClientData2(DocumentSnapshot data,num amount)async {
  
  final box=GetStorage();
  String roleId=box.read('roleId')??'1';
  String type='';

  if(roleId=='1'){
   type='users';
  }else{
    type='freelancers';
  }
String email=box.read('email');
 userData=[];

 print("TYPE===$type");
 print("ROLEID==========="+roleId.toString());

QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection
        (type).where('email',isEqualTo: email).get();
      try{
        List<Map<String, dynamic>> data
        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();
     
        userData=data;

        print("DATA====="+data.toString());


        
      }
      
      catch(e){
        // ignore: avoid_print
        print("E.......");
        // ignore: avoid_print
        print(e);
       // orderState='error';
        // ignore: avoid_print
        print("E.......");
      }
      update();
    amount=amount*0.35;
      getApi2(amount,data);
}


Future<void>getApi(num amount,Map<String,dynamic>data) async {
  print("GET API.......");
  var url = Uri.parse('https://api.fatora.io/v1/payments/checkout');
  var headers = {
    'Content-Type': 'application/json',
    'api_key': 'E4B73FEE-F492-4607-A38D-852B0EBC91C9'
  };
  //
  var body = jsonEncode({
    "amount":amount,
    "currency": "EGP",
    "order_id": "123456",
    "client": {
      "name": userData[0]['name'],
     // "phone": "+974 77777777",
      "email": userData[0]['email']
    },
    "language": "ar",
    "success_url": "http://domain.com/payments/success",
    "failure_url": "http://domain.com/payments/failure",
    "fcm_token": "XXXXXXXXX",
    "save_token": true,
    "note": "some additional info"
  });

  var response = await http.post(url, headers: headers, body: body);
  print(response.body);
  print("Response status: ${response.statusCode}");

  baseUrl=response.body.toString();

  var responseBody =jsonDecode(response.body);

  print("BASE========"+baseUrl.toString());
  
  print("res505050=="+responseBody['result']['checkout_url']);

  webUrl=responseBody['result']['checkout_url'];

 print("RESPONSE==="+responseBody['result'].toString());
  update();

  Get.to(PaymentView(url: webUrl,data: data,
  price: amount,
  ));
}

Future<void>getApi2(num amount, DocumentSnapshot data) async {
  print("GET API.......");
  var url = Uri.parse('https://api.fatora.io/v1/payments/checkout');
  var headers = {
    'Content-Type': 'application/json',
    'api_key': 'E4B73FEE-F492-4607-A38D-852B0EBC91C9'
  };
  //
  var body = jsonEncode({
    "amount":amount,
    "currency": "EGP",
    "order_id": "123456",
    "client": {
      "name": userData[0]['name'],
     // "phone": "+974 77777777",
      "email": userData[0]['email']
    },
    "language": "ar",
    "success_url": "http://domain.com/payments/success",
    "failure_url": "http://domain.com/payments/failure",
    "fcm_token": "XXXXXXXXX",
    "save_token": true,
    "note": "some additional info"
  });

  var response = await http.post(url, headers: headers, body: body);
  print(response.body);
  print("Response status: ${response.statusCode}");

  baseUrl=response.body.toString();

  var responseBody =jsonDecode(response.body);

  print("BASE========"+baseUrl.toString());
  
  print("res505050=="+responseBody['result']['checkout_url']);

  webUrl=responseBody['result']['checkout_url'];

 print("RESPONSE==="+responseBody['result'].toString());

  update();

  Get.to(PaymentView2(url: webUrl,data: data,price: amount,));

  }
}

class Client {
  final String name;
  final String phone;
  final String email;

  Client({
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

class Payment {
  final double amount;
  final String currency;
  final String orderId;
  final Client client;
  final String language;
  final String successUrl;
  final String failureUrl;
  final String fcmToken;
  final bool saveToken;
  final String note;

  Payment({
    required this.amount,
    required this.currency,
    required this.orderId,
    required this.client,
    required this.language,
    required this.successUrl,
    required this.failureUrl,
    required this.fcmToken,
    required this.saveToken,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'order_id': orderId,
      'client': client.toJson(),
      'language': language,
      'success_url': successUrl,
      'failure_url': failureUrl,
      'fcm_token': fcmToken,
      'save_token': saveToken,
      'note': note,
    };
  }
}