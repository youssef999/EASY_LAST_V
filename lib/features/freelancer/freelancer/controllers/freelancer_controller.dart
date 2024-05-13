

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:freelancerApp/core/const/app_message.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/resources/app_strings.dart';
import 'package:freelancerApp/core/widgets/Custom_Text.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class FreelancerController extends GetxController{


List<Map<String,dynamic>> freelancerServicesList=[];

  CarouselSliderController sliderController = CarouselSliderController();

  RxList<dynamic> sliderImagesList = [].obs;

List<Map<String,dynamic>> freelancerData=[];
final box=GetStorage();

  final RxList<Color> colors = [
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
    AppColors.whiteColor,
  ].obs;


double sumRate=0;

double finalRate=1;

List<num>ratingList=[];


List<String> firstCommentList=[];
List<String> serviceCommentList=[];

TextEditingController bioController=TextEditingController();


filterComment(){
  print("COMM");
  firstCommentList=freelancerServicesList[0]['comment'].toString().split(',');
  print("CCCCOOOO"+firstCommentList.toString());
  update();
}


  List<String>freelancerImage=[];
  getFreelancerData()async{
    freelancerImage=[];
   print("FREELNACER........XXX......");
    String email=box.read('email')??'';
    String empType=box.read("empType");
    String type='freelancers';

    if(empType=='offline'){
      type='employees';
    }else{
      type='freelancers';
    }
    freelancerData = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(type)
        .where('email',isEqualTo:email)
        .get();
    try {
      List<Map<String, dynamic>> data = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

    querySnapshot.docs.map((doc) =>sliderImagesList.value= doc['images']).toList() ;
      freelancerData = data;

      for(int i=0;i<freelancerData[i]['images'].length;i++){
        freelancerImage.add(freelancerData[i]['images'][i]);
      }
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
    print("IMAGESSS=="+freelancerImage.length.toString());
    update();
 }

  List<XFile>? pickedImageXFiles;
  bool isImage = false;

  XFile? pickedImageXFile;

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  List<String> downloadUrls = [];
 captureImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
    Get.back();
    //pickedImageXFile;
    update();
  }

  pickMultiImage() async {
    pickedImageXFiles = await _picker.pickMultiImage(
      imageQuality: 100,
    );
    isImage = true;
    update();
  }


  addNewImage() async{
uploadMultiImageToFirebaseStorage(pickedImageXFiles!).then((value) {

  for(int i=0;i<downloadUrls.length;i++){
    freelancerImage.add(downloadUrls[i]);
  }

  updateFreelancerData();

});

  }




void updateBio() async {

  print("freee=="+freelancerImage.toString());
  print("freee=="+freelancerImage.length.toString());
  final box=GetStorage();
  String email=box.read('email');
  final CollectionReference users = FirebaseFirestore.instance
      .collection('freelancers');

  // Create a query to find the user document by email
  QuerySnapshot querySnapshot = await users

      .where('email', isEqualTo: email).get();

  // Check if there is exactly one document found
  if (querySnapshot.docs.length == 1) {
    // Get the reference to the document
    DocumentSnapshot userDocument = querySnapshot.docs.first;

    // Update the data in the document
    users.doc(userDocument.id).update({
      'bio':bioController.text
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


void updateFreelancerData() async {

  print("freee=="+freelancerImage.toString());
    print("freee=="+freelancerImage.length.toString());
  final box=GetStorage();
  String email=box.read('email');
    final CollectionReference users = FirebaseFirestore.instance
    .collection('freelancers');

    // Create a query to find the user document by email
    QuerySnapshot querySnapshot = await users

    .where('email', isEqualTo: email).get();

    // Check if there is exactly one document found
    if (querySnapshot.docs.length == 1) {
      // Get the reference to the document
      DocumentSnapshot userDocument = querySnapshot.docs.first;

      // Update the data in the document
      users.doc(userDocument.id).update({
        'images':freelancerImage,
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





  pickImage() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    update();
    //   uploadImageToFirebaseStorage(pickedImageXFile!);
  }

String downloadUrl = '';
  Future uploadMultiImageToFirebaseStorage(List<XFile> images) async {
    for (int i = 0; i < images.length; i++) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference =
            FirebaseStorage.instance.ref().child('imagesNew/$fileName');
        UploadTask uploadTask = reference.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } catch (e) {
        // Handle any errors that occur during the upload process
        // ignore: avoid_print
        print('Error uploading image to Firebase Storage: $e');
      }
    }

    return downloadUrls;
  }
 showIdDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Custom_Text(
              text: 'camera'.tr,
              alignment: Alignment.center,
              fontSize: 19,
              color: Colors.black,
            ),
            children: [
              SimpleDialogOption(
                child: Custom_Text(
                  text: 'gallery'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  captureImage();
                },
              ),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'selectImage'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    pickImage();
                  }),
              SimpleDialogOption(
                  child: Custom_Text(
                    text: 'cancel'.tr,
                    alignment: Alignment.center,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Get.back();
                  })
            ],
          );
        });
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

getFreelancerDataOthers()async{
  print("FREELNACER........XXX......Others");

   final box=GetStorage();
   String email=box.read('email');
  freelancerData = [];
  try {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('freelancers')
        .where('email',isEqualTo:email)
        .get();
    Ui.logSuccess("FREELNACER........XXX.  $querySnapshot");

    List<Map<String, dynamic>> data = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    querySnapshot.docs.map((doc) =>sliderImagesList.value= doc['images']).toList() ;
    Ui.logError(sliderImagesList);
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


List<dynamic>serviceRateList=[];
  double sum=0;
  double rateV=1;

  getServiceComments(Map<String,dynamic>data) {
    sum=0;
    rateV=1;
    serviceCommentList = data['comment'].toString().split(',');
    serviceRateList = data['rate'];

    for (int i = 0; i < serviceRateList.length; i++) {
      sum = double.parse(serviceRateList[i].toString()) + sum;
    }
    print("SUMM==" + sum.toString());
    rateV = sum / serviceRateList.length;
    print("RATEVV==" + rateV.toString());

  }
}