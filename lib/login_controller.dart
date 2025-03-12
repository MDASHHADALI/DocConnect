import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/data/repositories/authentication/authentication_repository.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';
class LoginController extends GetxController
{
  ///Variables
  final rememberMe=false.obs;
  final hidePassword=true.obs;
  final localStorage=GetStorage();
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginFormKey=GlobalKey<FormState>();
  final userController=Get.put(UserController());
  Future<void> emailAndPasswordSignIn() async
  {
    try{
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);
      final isConnected=await NetworkManager.instance.isConnected();
      if(!isConnected)
        {
          TFullScreenLoader.stopLoading();
          return;
        }
      if(!loginFormKey.currentState!.validate())
        {
          TFullScreenLoader.stopLoading();
          return;
        }
      if(rememberMe.value)
        {
          localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
          localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        }
      final userCredentials=await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirectByAshhad();
    } catch(e)
    {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
  Future<void> googleSignIn() async
  {
    try{
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);
      //Check Internet Connectivity
      final isConnected= await NetworkManager.instance.isConnected();
      if(!isConnected)
        {
          TFullScreenLoader.stopLoading();
          return;
        }
      //Google Authentication
      final userCredentials=await AuthenticationRepository.instance.signInWithGoogle();
      // Save User Record
      await userController.saveUserRecord(userCredentials);
      // Remove Loader
     // TFullScreenLoader.stopLoading();
      //Redirect
      AuthenticationRepository.instance.screenRedirectByAshhad();
    }catch(e)
    {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}