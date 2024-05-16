
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/routes/app_routes.dart';
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

 List cityList=[];
 List<String>cityNames=[];

  getAllCities() async {
    print("ccc");

    cityList = [];

    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('city').get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      cityList = data;

      for (int i = 0; i < cityList.length; i++) {
        cityNames.add(cityList[i]['name']);
      }

      print("city===$cityList");

    } catch (e) {
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    update();
  }


  void updateCity(String city) async {

    final box=GetStorage();
    String email=box.read('email');
    String empType=box.read("empType")??"offline";
    String type='freelancers';

    if(empType=='offline'){
      type='employees';
    }else{
      type='freelancers';
    }
    final CollectionReference users = FirebaseFirestore.instance
        .collection(type);

    // Create a query to find the user document by email
    QuerySnapshot querySnapshot = await users

        .where('email', isEqualTo: email).get();

    // Check if there is exactly one document found
    if (querySnapshot.docs.length == 1) {
      // Get the reference to the document
      DocumentSnapshot userDocument = querySnapshot.docs.first;

      // Update the data in the document
      users.doc(userDocument.id).update({
        'city':city
        // Add more fields to update as needed
      }).then((_) {
        print('Document successfully updated!');
        appMessage(text: 'changeDone'.tr, fail: false);
        Get.offAllNamed(Routes.ROOT);
      }).catchError((error) {
        print('Error updating document: $error');
      });
    } else {
      //  print('User with email $userEmail not found or multiple users found.');
    }
  }


  String selectedCity = 'وهران';




  changeCityValue(String val) {
    selectedCity = val;
    update();
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataByEmail(
      String email) async {
    final box = GetStorage();
    String empType=box.read('empType');
    String type='freelancers';
    if(empType=='offline'){
      type='employees';
    }else{
      type='freelancers';
    }
    final userRef = FirebaseFirestore.
    instance.collection(roleId == '1' ?'users': type);
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
