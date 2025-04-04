import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/common/widgets/loginorsignupwidgets/formDivider.dart';
import 'package:health_app/common/widgets/loginorsignupwidgets/socialButtons.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/constants/text_strings.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'docSignUpForm.dart';

class DocSignupScreen extends StatelessWidget {
  const DocSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?Colors.white:Colors.black ),onPressed: ()=>Get.back(),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const DocSignUpForm(),

            ],
          ),
        ),
      ),
    );
  }
}

