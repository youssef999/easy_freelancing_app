
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {

  RxMap<String, dynamic>? userData = <String, dynamic>{}.obs;
   String? roleId ;

 @override
  void onInit() async {
        final box = GetStorage();
   roleId =  box.read('roleId');
   await data();
    super.onInit();
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataByEmail(
      String email) async {
    final userRef = FirebaseFirestore.instance.collection(roleId == '1' ?'users': 'freelancers');
    return await userRef.where('email', isEqualTo: email).get();
  }
                                         

   data() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final String? email = currentUser?.email;
    
    if (email != null) {
      final snapshot = await getUserDataByEmail(email);
      if (snapshot.docs.isNotEmpty) {
      
          userData?.value = snapshot.docs.first.data();
      update();
      }
    }
  }
}
