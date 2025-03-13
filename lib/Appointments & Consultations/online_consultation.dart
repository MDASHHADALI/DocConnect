import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/helpers/helper_functions.dart';

class OnlineConsultation extends StatelessWidget {
  const OnlineConsultation({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?Colors.white:Colors.black),onPressed: ()=>Get.back(),),
    title:Text( "Online Consultation", style: Theme.of(context).textTheme.labelMedium),
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(TSizes.defaultSpace),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    "Enter the patient Details",
    style: Theme.of(context).textTheme.headlineMedium,
    ),
    const SizedBox(
    height: TSizes.spaceBtwSections,
    ),
    const ConsultationForm(),
    const SizedBox(height: TSizes.spaceBtwSections,),
    FormDivider(formDividerText: TTexts.orSignUpWith.capitalize!),
    const SizedBox(height: TSizes.spaceBtwSections,),
    const SocialButtons(),

    ],
    ),,
    )
    ,
    );
  }
}
