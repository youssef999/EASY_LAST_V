// ignore_for_file: deprecated_member_use, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancerApp/core/resources/app_colors.dart';
import 'package:freelancerApp/core/widgets/custom_image_widget.dart';
import 'package:freelancerApp/features/about/about_view.dart';
import 'package:freelancerApp/features/emp/views/emp_near_view.dart';
import 'package:freelancerApp/features/freelancer/orders/views/order_request_view.dart';
import 'package:freelancerApp/features/freelancer/service/views/add_service_view.dart';
import 'package:freelancerApp/features/orders/views/myorder_view.dart';
import 'package:freelancerApp/features/payment/views/pay.dart';
import 'package:freelancerApp/features/settings/views/change_lang_view.dart';
import 'package:freelancerApp/features/settings/views/settings_view.dart';
import 'package:freelancerApp/features/wallet/views/wallet_view.dart';
import 'package:freelancerApp/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/freelancer/service/views/freelancer_services.dart';
import '../../features/payment/views/payment_view.dart';
import '../../features/privacy/privacy_policy.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? roleId;

  @override
  void initState() {
    var box = GetStorage();
    roleId = box.read('roleId');
    String email=box.read('email')??"";
    print("ROLE DRAW ID===$roleId");
    print("EMAIL==NEWWWW=$email");
    data();
    super.initState();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataByEmail(

      String email) async {
    final userRef = FirebaseFirestore.instance
        .collection(roleId == '1' ? 'users' : 'freelancers');
    return await userRef.where('email', isEqualTo: email).get();
  }

  Map<String, dynamic>? userData;

  void data() async {

    final User? currentUser = FirebaseAuth.instance.currentUser;
    //final String? email = currentUser?.email;

    final box=GetStorage();

    String email=box.read('email');

    print('data is oo 1 ${email}');

    if (email != null) {

      final snapshot = await getUserDataByEmail(email);

      print('data is oo 2 ${snapshot.docs}');

      if (snapshot.docs.isNotEmpty) {

        setState(() {
          userData = snapshot.docs.first.data();
          print('data is oo ${userData?['image']}');
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width / 1.34,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            24 * 2,
          ),
        )),
        backgroundColor: AppColors.secondaryLightColor,
        child: ListView(
          children: [
            _userImgWidget(context),
            _userTextwidget(context),
            const Divider(
              color: AppColors.whiteColor,
              endIndent: 5,
              indent: 5,
            ),
            _drawerWidget(context),
          ],
        ),
      ),
    );
  }

  _userImgWidget(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: 24 * 1,
          bottom: 24,
        ),
        height: 12 * 8.3,
        width: 10 * 11.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10 * 1.5),
          color: AppColors.primaryBGLightColor,
          border: Border.all(color: AppColors.primaryBGLightColor, width: 5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: userData?['image'] !=null ? Image.network(
              userData?['image'] ,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ):Image.asset('assets/images/user.png')
        
        ),
      ),
    );
  }

  _userTextwidget(BuildContext context) {
    final box=GetStorage();
    String email=box.read('email')??"";
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            userData?['name'] ?? '',
            textAlign: TextAlign.start,
            style: GoogleFonts.cairo(
              fontSize: 17,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            email,
          //  userData?['email'] ?? 'email@gmail.com',
            textAlign: TextAlign.start,
            style: GoogleFonts.cairo(
              fontSize: 17,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  _drawerWidget(BuildContext context) {

    final box = GetStorage();

    String roleId = box.read('roleId') ?? 'x';
    String email = box.read('email') ?? 'x';
    // ignore: prefer_interpolation_to_compose_strings
    print("ROLEID===" + roleId);
    print("EMAIL=====$email");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (roleId == '2')
            ? _drawerTileWidget(
                icon: 'assets/icon/kyc_verification.svg',
                title: 'myServices'.tr,
                onTap: () {
                  Get.to(const FreelancerServicesView());
                },
              )
            : const SizedBox(),
        //
        // (roleId == '2')
        //     ? _drawerTileWidget(
        //   icon: 'assets/icon/kyc_verification.svg',
        //   title: 'moneyData'.tr,
        //   onTap: () {
        //    // Get.to(const FreelancerServicesView());
        //   },
        // )
        //     : const SizedBox(),


        // (roleId == '2')
        //     ? _drawerTileWidget(
        //         icon: 'assets/icon/kyc_verification.svg',
        //         title: 'orderRequests'.tr,
        //         onTap: () {
        //           Get.to(const OrderRequestView());
        //         })
        //     : const SizedBox(),
        //

        // (roleId == '2')
        //     ? _drawerTileWidget(
        //         icon: 'assets/icon/transactions_log.svg',
        //         title: 'addNewService'.tr,
        //         onTap: () {
        //           Get.to(const AddServicesView());
        //         },
        //       )
        //     : const SizedBox(),


        _drawerTileWidget(
          icon: 'assets/icon/drawer_menu.svg',
          title: 'myOrders'.tr,
          onTap: () {
            Get.to(const MyOrderView());
          },
        ),
        _drawerTileWidget(
          icon: 'assets/icon/my_wallet.svg',
          title: 'wallet'.tr,
          onTap: () {
            Get.to(const WalletView());
          },
        ),
           _drawerTileWidget(
          icon: 'assets/images/america.svg',
          title: 'changeLang'.tr,
          onTap: () {
            Get.to(const ChangeLangView() );
          },
        ),
        //

        //NearEmpView
        _drawerTileWidget(
          icon: 'assets/icon/backward.svg',
          title: 'near'.tr,
          onTap: () {
            Get.to(const NearEmpView());
           // Get.to(const PayView());
          },
        ),
        const Divider(
          color: AppColors.whiteColor,
          endIndent: 50,
          indent: 50,
        ),
        _drawerTileWidget(
          icon: 'assets/icon/about_us.svg',
          title: 'aboutUs'.tr,
          onTap: () {
            Get.to(const AboutView());
          },
        ),
        const Divider(
          color: AppColors.whiteColor,
          endIndent: 50,
          indent: 50,
        ),
        _drawerTileWidget(
          icon: 'assets/icon/my_gift.svg',
          title: 'profEmail'.tr,
          onTap: () async {
            // Email address you want to send to
            const String email = 'multi-services@easyme.org';

            // Subject of the email
            const String subject = '';

            // Body of the email
            const String body = 'Hello!';

            // Construct the mailto URL
            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: email,
              queryParameters: {
                'subject': subject,
                'body': body,
              },
            );

            // Check if the URL can be launched
            if (await canLaunch(_emailLaunchUri.toString())) {
            // Launch the URL
            await launch(_emailLaunchUri.toString());
            } else {
              await launch(_emailLaunchUri.toString());
            // Handle the case where the user cannot launch the URL
            throw 'Could not launch $_emailLaunchUri';
            }
            //launchURL('multi-services@easyme.org');
            //Get.to(const AboutView());
          },
        ),
        _drawerTileWidget(
          icon: 'assets/icon/face.svg',
          title: 'face'.tr,
          onTap: () {
            launchURL('https://www.facebook.com/profile.php?id=61558762799918&amp%3Bmibextid=ZbWKwL');
            //Get.to(const AboutView());
          },
        ),
         _drawerTileWidget(
          icon: 'assets/icon/insta.png',
          title: 'insta'.tr,
          onTap: () {
            launchURL('https://www.instagram.com/easy.freelancers/');
            //Get.to(const AboutView());
          },
        ),
         _drawerTileWidget(
          icon: 'assets/icon/X.svg',
          title: 'X'.tr,
          onTap: () {
            launchURL('https://twitter.com/i/flow/login?redirect_after_login=%2FFreelanceEasy');
            //Get.to(const AboutView());
          },
        ),
        _drawerTileWidget(
          icon: 'assets/icon/privacy.svg',
          title: 'privacy'.tr,
          onTap: () {
            Get.to(const PrivacyPolicy());
          },
        ),
        //PrivacyPolicy
        _drawerTileWidget(
          icon: 'assets/icon/sign_out.svg',
          title: 'logout'.tr,
          color: Colors.red,
          onTap: () {
            final box=GetStorage();
            box.remove('email');
            Get.offAllNamed(Routes.LOGIN);
          },
        )
      ],
    );
  }

launchURL(String url) async {
   
    if (await canLaunch(url)) {
      await launch(url);
    } else {
       await launch(url);
      throw 'Could not launch $url';
    }
  }
  _drawerTileWidget(
      {required VoidCallback onTap,
      required String title,
      required String icon,
      Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15 * 1,
          vertical: 50 * 0.2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 12 * 2.5,
              width: 10 * 3.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * 0.7),
                color: AppColors.whiteColor.withOpacity(0.2),
              ),
              child: Container(
                padding: const EdgeInsets.all(10 * 0.2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10 * 0.7,
                    ),
                    color: AppColors.primaryBGLightColor),
                child: CustomImageWidget(
                  path: icon,
                  height: 12 * 2,
                  width: 10 * 2.2,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  color: color ?? AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
