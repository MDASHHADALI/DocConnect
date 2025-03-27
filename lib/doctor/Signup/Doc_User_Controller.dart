import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/data/repositories/user/user_repository.dart';
import 'package:health_app/usermodel.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'DocUserModel.dart';
import 'Doc_User_Repository.dart';
class DocUserController extends GetxController
{
  static DocUserController get instance => Get.find();
  Rx<DocUserModel> user = DocUserModel.empty().obs;
  final imageUploading= false.obs;
  final userRepository= Get.put(DocUserRepository());


  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }
  Future<void> fetchUserRecord() async
  {
    try{
      final user=await userRepository.fetchUserDetails();
      this.user(user);
    }
    catch(e)
    {
      user(DocUserModel.empty());
    }
  }


  Future<void> saveUserRecord(UserCredential? userCredentials) async
  {
    try
    {
      //Refresh User Record
      await fetchUserRecord();
      if(user.value.id.isEmpty==false) {
        return ;
      }
      if(userCredentials!=null)
      {
        //Convert Name to First and Last Name
        final nameParts=UserModel.nameParts(userCredentials.user!.displayName??'');
        final username=UserModel.generateUsername(userCredentials.user!.displayName??'');
        //Map Data
        final user = DocUserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length>1?nameParts.sublist(1).join(' '):'',
          username: username,
          email: userCredentials.user!.email??'',
          phoneNumber: userCredentials.user!.phoneNumber ??'',
          profilePicture: userCredentials.user!.photoURL ??'',
          degree: '',
          licenseNumber: '',
          location: '',
          specialization: '',
          yearOfExp: '',
        );
        await userRepository.saveUserRecord(user);
      }
    }
    catch(e)
    {
      TLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }
  uploadUserProfilePicture() async
  {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,);
      if (image != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: image!.path,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 100,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
              ],
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioPresets: [
                CropAspectRatioPreset.square,

              ],
            ),
          ],
        );
        if (croppedFile != null) {
          imageUploading.value = true;
          final imageUrl = await userRepository.uploadImage(
              'Users/Images/', XFile(croppedFile.path));
          //Update User Image Record
          Map<String, dynamic> json = {'ProfilePicture': imageUrl};
          await userRepository.updateSingleField(json);
          user.value.profilePicture = imageUrl;
          user.refresh();
          TLoaders.successSnackBar(title: 'Congratulations',
              message: 'Your Profile Picture has been updated!');
        }
      }
    } catch(e)
    {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong $e');
    }
    finally{
      imageUploading.value=false;
    }
  }
}