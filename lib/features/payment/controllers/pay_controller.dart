

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancerApp/features/payment/views/pay.dart';
import 'package:freelancerApp/features/payment/views/payment_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../views/pay2.dart';
import '../views/payment_view2.dart';

class PayController extends GetxController{


   List<Map<String,dynamic>>userData=[];

  getClientData (Map<String,dynamic>data,num amount)async {

    print("DATA==="+data.toString());
    print("client.......");
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

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection
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
    createCheckout(data,amount);
  }


    getClientData2(DocumentSnapshot data,num amount)async {

    print("DATA==="+data.toString());
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
   createCheckout2(data,amount);

}


  String productId='';
  String priceId='';

 createCheckout(Map<String,dynamic>data,num amount) async {

   print("GET API.......");
    var url = Uri.parse('https://pay.chargily.net/api/v2/products');
    var headers = {
      'Authorization': 'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
           // 'Authorization': 'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
            'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "name": data['name']
    });

    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print("Response status: ${response.statusCode}");

    var responseBody =jsonDecode(response.body);

    print("res505050======"+responseBody.toString());
    productId=responseBody['id'].toString();

    secondApi(data,amount);

    update();

  }

  createCheckout2(DocumentSnapshot data,num amount) async {
     print("GET API.pay22......");
     var url = Uri.parse(
         'https://pay.chargily.net/api/v2/products');
     var headers = {
       'Authorization': 'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
    //   'Authorization': 'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
       'Content-Type': 'application/json',
     };
     //
     var body = jsonEncode({
       "name": data['name']
     });

     var response = await http.post(url, headers: headers, body: body);
     print(response.body);
     print("Response status: ${response.statusCode}");

     //  baseUrl=response.body.toString();

     var responseBody =jsonDecode(response.body);

     // print("BASE========"+baseUrl.toString());

     // print("res505050=="+responseBody['result']['checkout_url']);
     print("res505050======"+responseBody.toString());
     productId=responseBody['id'].toString();
     // webUrl=responseBody['result']['checkout_url'];
     print("RESPONSE==="+responseBody['result'].toString());

     secondApi2(data,amount);

     update();

     // Get.to(PaymentView(url: webUrl,data: data,
     //   price: amount,
     // ));
   }

  secondApi(Map<String,dynamic>data,num amount) async {
    print("price=="+amount.toString());
    print("price=="+data['price'].toString());
    print("GET API..2222.....");
    var url = Uri.parse('https://pay.chargily.net/api/v2/prices');
    var headers = {
      'Authorization': 'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
    //  'Authorization': 'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
      'Content-Type': 'application/json',
    };
    var
    body = jsonEncode({
      "amount":amount,
      "currency":"dzd",
      "product_id":productId
    });

    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print("Response status: ${response.statusCode}");

    var responseBody =jsonDecode(response.body);

    print("res6000006660======"+responseBody.toString());

    priceId=responseBody['id'];

    update();

    thirdApi(data,amount);

  }


   secondApi2(DocumentSnapshot data,num amount) async {
   print("price=="+amount.toString());
   print("price=="+data['price'].toString());
     print("GET API..2222..xx...");
     var url = Uri.parse('https://pay.chargily.net/api/v2/prices');
     var headers = {
       'Authorization':
         'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
       //'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
       //'Bearer live_pk_7ecxpYdrGhVCUrMMvLxQFsjIgFG3VjWOQ0zP0otp',
       //'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
       //'Bearer test_pk_H167NBnY1dCrUanBGFB53vjBBVH7g2gLFElMyLHl',
       'Content-Type': 'application/json',
       // 'Content-Type': 'application/json',
       // 'api_key': 'E4B73FEE-F492-4607-A38D-852B0EBC91C9'
     };
     //
     var
     body = jsonEncode({
       "amount":amount,
       "currency":"dzd",
       "product_id":productId
       //"01hhyjnrdbc1xhgmd34hs1v3en"
     });

     var response = await http.post(url, headers: headers, body: body);
     print(response.body);
     print("Response status: ${response.statusCode}");

     //  baseUrl=response.body.toString();

     var responseBody =jsonDecode(response.body);

     // print("BASE========"+baseUrl.toString());

     // print("res505050=="+responseBody['result']['checkout_url']);
     print("res6000006660======"+responseBody.toString());

     priceId=responseBody['id'];

     // webUrl=responseBody['result']['checkout_url'];
     // print("RESPONSE==="+responseBody['result'].toString());

     update();

     thirdApi2(data,amount);
     // Get.to(PaymentView(url: webUrl,data: data,
     //   price: amount,
     // ));
   }

  String checkoutUrl='';

  thirdApi(Map<String,dynamic>data,num amount) async {
    print("GET API..2222.....");
    var url = Uri.parse('https://pay.chargily.net/api/v2/checkouts');
    var headers = {
      'Authorization':'',
      //'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
      //'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
      'Content-Type': 'application/json',

    };

    var

    body = jsonEncode({
      //"items": [
       // [
      "items":[
        {
          "price" : priceId,
          "quantity": 1,
        }
        ],

      "success_url": "https://your-cool-website.com/payments/success"
    });

    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    print("Response status: ${response.statusCode}");

    var responseBody =jsonDecode(response.body);

    print("res6000006660======"+responseBody.toString());

    checkoutUrl=responseBody['checkout_url'];

    update();
    print("CHECKOUT==="+checkoutUrl);

    Get.to(PaymentView(url: checkoutUrl, data: data, price: amount));
  }

  thirdApi2(DocumentSnapshot data,num amount) async {
     print("GET API..OWPPWPWWPWPW.....");
     var url = Uri.parse('https://pay.chargily.net/api/v2/checkouts');
     var headers = {
       'Authorization':'Bearer live_sk_dELGciqUzKBPWPe12vNPpb5P2SdCa8QaoLcxeVGY',
       //'Bearer test_sk_URIi8RcwOF3nNuN1HBz2IRYF5xtZgz9ifeaXs6js',
       //'Bearer test_pk_H167NBnY1dCrUanBGFB53vjBBVH7g2gLFElMyLHl',
       'Content-Type': 'application/json',
       // 'Content-Type': 'application/json',
       // 'api_key': 'E4B73FEE-F492-4607-A38D-852B0EBC91C9'
     };
     //
     var
     body = jsonEncode({
       //"items": [
       // [
       "items":[
         {
           "price" : priceId,
           //"01hhy57e5j3xzce7ama8gtk7m0",
           "quantity": 1,
         }
       ],
       // ],
       "success_url":'https://youssef999.github.io/pay/'
      // "https://your-cool-website.com/payments/success"
       //"01hhyjnrdbc1xhgmd34hs1v3en"
     });

     var response = await http.post(url, headers: headers, body: body);
     print(response.body);
     print("Response status: ${response.statusCode}");

     //  baseUrl=response.body.toString();

     var responseBody =jsonDecode(response.body);

     // print("BASE========"+baseUrl.toString());

     // print("res505050=="+responseBody['result']['checkout_url']);
     print("res6000006660======"+responseBody.toString());

     checkoutUrl=responseBody['checkout_url'];

     // webUrl=responseBody['result']['checkout_url'];
     // print("RESPONSE==="+responseBody['result'].toString());
     update();
     print("CHECKOUT==="+checkoutUrl);

     Get.to(PaymentView2(
         url: checkoutUrl, data: data, price: amount));
     // Get.to(PaymentView(url: webUrl,data: data,
     //   price: amount,
     // ));
   }

}