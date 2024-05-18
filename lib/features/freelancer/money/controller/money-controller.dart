

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MoneyController extends GetxController{


 List<Map<String,dynamic>> orderList=[];

  num moneyData=0;
  num finalMoney=0;

  getOrdersData()async{
    moneyData=0;
    finalMoney=0;
    final box=GetStorage();
    String email=box.read('email');
    orderList=[];
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection
      ('orders').where('freelancer_email',isEqualTo: email).get();
    try{
      List<Map<String, dynamic>> data
      = querySnapshot.docs.map((DocumentSnapshot doc) =>
      doc.data() as Map<String, dynamic>).toList();
      orderList=data;

       for(int i=0;i<orderList.length;i++){
         if(orderList[i]['order_status']=='Done'){
           moneyData=moneyData+num.parse(orderList[i]['service_price'].toString());
         }
       }
    }catch(e){
      // ignore: avoid_print
      print("E.......");
      // ignore: avoid_print
      print(e);
      // orderState='error';
      // ignore: avoid_print
      print("E.......");
    }
    print("ORDER===="+orderList.toString());
    print("MONEY==="+moneyData.toString());
    finalMoney=moneyData -(moneyData * (10/100));
    print("FINAL ===="+finalMoney.toString());
    update();

  }

}