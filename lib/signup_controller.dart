import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:health_app/common/widgets/signupwidgets/verifyemail.dart';
import 'package:health_app/data/repositories/authentication/authentication_repository.dart';
import 'package:health_app/data/repositories/user/user_repository.dart';
import 'package:health_app/usermodel.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hidePassword=true.obs;
  final privacyPolicy=true.obs;
  final email=TextEditingController();
  final lastName=TextEditingController();
  final username=TextEditingController();
  final password=TextEditingController();
  final firstName=TextEditingController();
  final phoneNumber=TextEditingController();
  GlobalKey<FormState> signupFormKey= GlobalKey<FormState>();
  void signup() async{
    try{

      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected)
        {
          TFullScreenLoader.stopLoading();
          return;
        }
      if(!signupFormKey.currentState!.validate())
        {
          TFullScreenLoader.stopLoading();
          return;
        }
      if(!privacyPolicy.value)
        {

          TLoaders.warningSnackBar(
              title: 'Accept Privacy Policy',
              message: 'In order to create account, you must have to read and accept the Privacy Policy & Term of Use');
          return;
        }
      //Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential=await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
      //Save Authenticated user data in the Firebase Firestore
      final newUser= UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: ''
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Congratulations',message: 'Your account has been created! Verify email to continue.');
      Get.to(()=>  VerifyEmail(email: email.text.trim(),));
    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }

  }
}