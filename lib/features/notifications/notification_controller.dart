

// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

 import 'dart:convert';
 import 'package:http/http.dart'as http;
 import 'package:get/get.dart';

class NotificationController extends GetxController{


  sendNotificationNow
      ({required String token,
    required String type,
    required String title,required String body}) async

  {

    print("NOTIFICATIONSSS.................");
    var responseNotification;
    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAA_nLvVTA:APA91bGKSy5tJncdmShDi0KUAkyrrBFwdFmdelgO3n__6dGwZhfO_wzINIX1IpIyS6O16T1JhMHjCnKvk_iNf_9V45KR-of-kICZUXvCV_2dbUPd_86ccwYVQ5HYRYsivSIRVplX2qZF'
      // 'key=AAAAAhgtFZQ:APA91bGXxhm9fmKeoXql3LyIJdhLt2mi3-Go6DXPjkgDGQAuUaH42wRJx-GgxQ0biJb05fdPlDfIJ4OBwgLNrLHXQneDT41lE4Sk08wHzVOm4VdpYOtIakEyunbU5wfDIpUI4VkoKBHh'
    };
    Map bodyNotification =
    {
      "body":body,
      "title":title
    };

    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      //   "rideRequestId": docId
    };


   // for(int i=0;i<token.length;i++){
      Map officialNotificationFormat =
      {
        "notification": bodyNotification,
        "data": dataMap,
        "priority": "high",
        "to": token,
      };
      try{
        print('try send notification');
        responseNotification = http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: headerNotification,
          body: jsonEncode(officialNotificationFormat),
        ).then((value) {
          print('NOTIFICATION SENT==$value');
        });
      }
      catch(e){
        print("NOTIFICATION ERROR===$e");
      //}
    }
    return   responseNotification;

  }

}