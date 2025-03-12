import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:health_app/common/widgets/screens/profile.dart';
import 'package:health_app/data/repositories/user/user_repository.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:health_app/utils/helpers/network_manager.dart';
import 'package:health_app/utils/popup/full_screen_loader.dart';
import 'package:health_app/utils/popup/loaders.dart';

class UpdateNameController extends GetxController
{
  static UpdateNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName= TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    // TODO: implement onInit
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async
  {
   try{
     TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected)
       {
         TFullScreenLoader.stopLoading();
         return;
       }
     // Form Validation
     if(!updateUserNameFormKey.currentState!.validate())
       {
         TFullScreenLoader.stopLoading();
         return;
       }
     // Update user's first and last name in Firebase Firestore
     Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
     await userRepository.updateSingleField(name);
     // Update the Rx User value
     userController.user.value.firstName= firstName.text.trim();
     userController.user.value.lastName= lastName.text.trim();

     // Remove Loader
     TFullScreenLoader.stopLoading();
     Get.back();
     // Show Success Message
     TLoaders.successSnackBar(title: 'Congratulations ', message: 'Your name has been updated.');
     // Move to previous Screen
     userController.user.refresh();
   }
   catch(e)
    {
      TFullScreenLoader.stopLoading();
      print("hi");
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}