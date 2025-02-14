import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/login_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color:TColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: ()=>controller.googleSignIn(), icon: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage("assets/logos/google-icon.png"),
          )),
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(border: Border.all(color:TColors.grey),borderRadius: BorderRadius.circular(100)),
          child: IconButton(onPressed: (){}, icon: const Image(
            width: TSizes.iconMd,
            height: TSizes.iconMd,
            image: AssetImage("assets/logos/facebook-icon.png"),
          )),
        ),
      ],
    );
  }
}
