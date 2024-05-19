import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/Core/widgets/Custom_Text.dart';
import 'package:freelancerApp/core/const/constant.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_app_bar.dart';
import 'package:freelancerApp/features/emp/views/emp_checkout_view.dart';
import 'package:freelancerApp/features/emp/views/image_view.dart';
import 'package:freelancerApp/features/services/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class EmpDetailsView extends StatefulWidget {
  Map<String, dynamic> emp;

  EmpDetailsView({super.key, required this.emp});

  @override
  State<EmpDetailsView> createState() => _EmpDetailsViewState();
}

class _EmpDetailsViewState extends State<EmpDetailsView> {
  txtT(dynamic txt, String style, double size, FontWeight w, Color color) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      child: Text(
        widget.emp[txt].toString(),
        style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
      ),
    );
  }
  ProductController controller=Get.put(ProductController());

  @override
  void initState() {
    controller.getEmpService(widget.emp['email']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainly,
      appBar: CustomAppBar(widget.emp['name'], context, false),
      bottomSheet: animBtn(() {

        Get.to(EmpCheckoutView(
          data: widget.emp,
          //data2: data2
        ));
        //Get.toNamed(Routes.CART);
      }, 'buyService'.tr, AppColors.primary),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        // ignore: prefer_const_literals_to_create_immutables
        child: GetBuilder<ProductController>(
          builder: (_) {
            return ListView(children: [
              Container(
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 228, 228),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Image.network(
                    widget.emp['image'],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Center(
                  child: Container(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Text(
                  widget.emp['name'],
                  style: GoogleFonts.cairo(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: double.infinity),
                    child: Text(
                      widget.emp['emp'],
                      style: GoogleFonts.cairo(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                  )),
              dvid(40),
              const SizedBox(
                height: 5,
              ),


              txtS('price'.tr, 'Hind', 20, FontWeight.normal, Colors.black),


              Row(
                children: [
                  txtS('startFrom'.tr, 'Hind', 15, FontWeight.normal,
                      Colors.black),
                  const SizedBox(
                    width: 10,
                  ),
                  txtT('price', 'Thasadith', 40, FontWeight.w900,
                      AppColors.primary),
                  txtS(currency, 'Hind', 20, FontWeight.normal, Colors.black)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              dvid(30),
              // txtS('About This Item', 'Hind', 22, FontWeight.w300,
              //     Colors.black45),

              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10,top:5),
                child: Text(widget.emp['des'] ?? '',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyColor.withOpacity(0.6)
                    )),
              ),
              SizedBox(height: 3,),
              (controller.empServices.isEmpty)?
              const Column(
                children: [
                  SizedBox(height: 3,),
                ],
              ):
              Column(
                children: [
                  const SizedBox(height: 2,),
                  (controller.empServices[0]['rate'].length>0)?
                  Center(
                    child: AnimatedRatingStars(
                      initialRating: double.parse(controller.empServices[0]['rate'][0].toString()),
                      minRating: 0.0,
                      maxRating: 5.0,
                      filledColor: Colors.amber,
                      emptyColor: Colors.grey,
                      filledIcon: Icons.star,
                      halfFilledIcon: Icons.star_half,
                      emptyIcon: Icons.star_border,
                      onChanged: (double rating) {
                      },
                      displayRatingValue: true,
                      interactiveTooltips: true,
                      customFilledIcon: Icons.star,
                      customHalfFilledIcon: Icons.star_half,
                      customEmptyIcon: Icons.star_border,
                      starSize: 26.0,
                      animationDuration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      readOnly: true,
                    ),
                  ):const SizedBox(),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            (controller.empServices[0]['comment'].length>0)?
                            Custom_Text(text: 'comments'.tr,
                              fontSize: 20,
                            ):const SizedBox(),
                            (controller.empServices[0]['comment'].length>0)?
                            Custom_Text(text: controller.empServices[0]['comment'][0].toString()):const SizedBox(),


                            (controller.empServices[0]['comment'].length>1)?
                            Custom_Text(text: controller.empServices[0]['comment'][1].toString()):const SizedBox(),

                            (controller.empServices[0]['comment'].length>2)?
                            Custom_Text(text: controller.empServices[0]['comment'][2].toString()):const SizedBox(),
                            const Divider(),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),


              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Custom_Text(text: 'myWork'.tr,
                fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                 //  physics: const NeverScrollableScrollPhysics(),
                   // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.emp['images2'].length,
                      itemBuilder: (context,index){
                        return   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: SizedBox(
                                height: 100,
                                width: 90,
                                child: Container(
                                  decoration:BoxDecoration(
                                    color:Colors.white,
                                    borderRadius:BorderRadius.circular(16)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(widget.emp['images2'][index],
                                    fit:BoxFit.fill,
                                    ),
                                  ),
                                )),
                            onTap:(){
                              Get.to(ImageView(image: widget.emp['images2'][index]));
                            },
                          ),
                        );
                  }),
                ),
              ),

              const SizedBox(height: 120,)

              //for(int i=0;i<emp['images'].length;i++)


            ]);
          }
        ),
      ),
    );
  }
}

animBtn(void Function() function, String txt, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: function,
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          width: 250,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              txt,
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      )
    ],
  );
}

dvid(double num) {
  return SizedBox(
      height: num,
      child: const Divider(
        indent: 40,
        endIndent: 40,
        color: Color.fromARGB(50, 0, 0, 0),
      ));
}

txtS(String txt, String style, double size, FontWeight w, Color color) {
  return Text(
    txt,
    style: GoogleFonts.cairo(fontSize: size, fontWeight: w, color: color),
  );
}
