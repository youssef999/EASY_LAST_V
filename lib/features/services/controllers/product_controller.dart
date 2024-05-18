import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductController extends GetxController {
  final box = GetStorage();
  String typeFilter = '';
  RxList sliderImagesList = [].obs;
  CarouselSliderController sliderController = CarouselSliderController();
  String index = '';
  String clr = '';
  QueryDocumentSnapshot<Object?>? posts;

  List<DocumentSnapshot> searchResults = [];
  bool isSearching = false;
  final RxList<Color> colors = [
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
  ].obs;
  int? balance = 0; // Variable to store the   void addDataToFirestore() async {
 @override
  void onInit() async {
    posts = Get.arguments;
    super.onInit();


  }
  double finalRate=0;

 List<Map<String,dynamic>>empData=[];

 getEmpData(String email)async{
   print("EMP DATA...........");
   empData=[];
   QuerySnapshot querySnapshot =
   await FirebaseFirestore.instance.collection
     ('employees').where('email',isEqualTo: email).get();
   try{
     List<Map<String, dynamic>> data
     = querySnapshot.docs.map((DocumentSnapshot doc) =>
     doc.data() as Map<String, dynamic>).toList();
     empData=data;
   }catch(e){
     // ignore: avoid_print
     print("E.......");
     // ignore: avoid_print
     print(e);
     // orderState='error';
     // ignore: avoid_print
     print("E.......");
   }
   print('emp===='+empData.toString());
   update();

 }

  List<Map<String,dynamic>>empServices=[];


 getEmpService(String email)async{
  print("FREELANCING...........................");
  print('EMAILLL===='+email);
   empServices=[];
   QuerySnapshot querySnapshot =
   await FirebaseFirestore.instance.collection
     ('services').where('freelancer_email',isEqualTo:email).get();
   try{
     List<Map<String, dynamic>> data
     = querySnapshot.docs.map((DocumentSnapshot doc) =>
     doc.data() as Map<String, dynamic>).toList();
     empServices=data;
   }catch(e){
     // ignore: avoid_print
     print("E.......");
     // ignore: avoid_print
     print(e);
     // orderState='error';
     // ignore: avoid_print
     print("E.......");
   }
   print("EMPPPPP=========="+empServices.toString());

   update();
 }

 getServiceRate(){
   print(".............SERVICE RATES ........");
   List rateList=posts!['rate'];
   num rateValue=0;

   for(int i=0;i<rateList.length;i++){
     rateValue=num.parse(rateList[i].toString())+rateValue;
   }

   finalRate =rateValue/(rateList.length);
   print('RATES=======$rateValue');
   print("Final=====$finalRate");
   update();
  }









 
}
