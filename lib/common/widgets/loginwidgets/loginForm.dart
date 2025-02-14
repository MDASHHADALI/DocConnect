import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:health_app/common/widgets/signupwidgets/signupform.dart';
import 'package:iconsax/iconsax.dart';
import 'package:health_app/common/widgets/passwordconfiguration/forgot_password.dart';
import 'package:health_app/login_controller.dart';
import 'package:health_app/navigation_menu.dart';
import 'package:health_app/signup.dart';
import 'package:health_app/utils/validators/validation.dart';

import '../../../doctor/Signup/DocSignUpScreen.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value)=>TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
                  ()=> TextFormField(
                controller: controller.password,
                validator: (value)=>TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration:  InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () =>controller.hidePassword.value=!controller.hidePassword.value,
                        icon:  Icon(controller.hidePassword.value?Iconsax.eye_slash:Iconsax.eye))),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(()=> Checkbox(value: controller.rememberMe.value,
                        onChanged: (value)=>controller.rememberMe.value=!controller.rememberMe.value)),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () =>Get.to(()=>const ForgotPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(width: double.infinity,child: ElevatedButton(onPressed: ()=>controller.emailAndPasswordSignIn(), child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems,),
            SizedBox(width: double.infinity,child: OutlinedButton(onPressed: ()=>
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sign up '),
                      content: Text('Are you a Doctor',style: Theme.of(context).textTheme.bodyMedium,),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Get.to(()=>const DocSignupScreen());
                      },
                          child: Text('Yes'),
                        ),
                        FilledButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            Get.to(()=> const SignupScreen());},
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                ),
            child: const Text(TTexts.createAccount))),

          ],
        ),
      ),
    );
  }
}


