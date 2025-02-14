import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/utils/constants/sizes.dart';
import 'package:health_app/utils/constants/text_strings.dart';
import 'package:health_app/utils/styles/styles.dart';

import 'common/widgets/loginorsignupwidgets/formDivider.dart';
import 'common/widgets/loginorsignupwidgets/socialButtons.dart';
import 'common/widgets/loginwidgets/loginForm.dart';
import 'common/widgets/loginwidgets/loginHeader.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginForm(),
              FormDivider(formDividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections,),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}




