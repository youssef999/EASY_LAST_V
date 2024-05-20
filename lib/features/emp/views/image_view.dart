


 import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';

class ImageView extends StatelessWidget {

  String image;
  ImageView({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', context, false),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 21,),
          SizedBox(
            height: 300,
            child: Image.network(image.toString(),
            fit:BoxFit.fill,
            ),
          )
        ],),
      ),
    );
  }
}
