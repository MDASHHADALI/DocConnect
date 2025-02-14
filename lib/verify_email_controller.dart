import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:health_app/common/widgets/success_screen/success_screen.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/constants/text_strings.dart';
import 'package:health_app/utils/popup/loaders.dart';

import 'data/repositories/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user=FirebaseAuth.instance.currentUser;
      if(user?.emailVerified??false)
        {
          timer.cancel();
          Get.off(()=>SuccessScreen(image: TImages.successfullyRegisterAnimation,
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
          ) );
        }
    });
  }
  ///Manually Check if Email is verified
  checkEmailVerificationStatus() async
  {
    final currentUser= FirebaseAuth.instance.currentUser;
    if(currentUser !=null && currentUser.emailVerified)
      {
        Get.off(
            ()=> SuccessScreen(image: TImages.successfullyRegisterAnimation,
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: ()=> AuthenticationRepository.instance.screenRedirect(),
            )
        );
      }
  }
}
