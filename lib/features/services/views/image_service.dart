import 'package:flutter/material.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:get/get.dart';

class ImageService extends StatelessWidget {

  List images;
  ImageService({super.key,required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('serviceImages'.tr, context, false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          const SizedBox(height: 2),
          SizedBox(
            child: ListView.builder(
               shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: images.length,
                itemBuilder: ((context, index) {
                  return  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Container(
                    //   height: 310,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Center(
                        child: Image.network(images[index],
                        fit:BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],),
      )

    );
  }
}
