import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:health_app/data/repositories/user/user_repository.dart';
import 'package:health_app/usermodel.dart';
import 'package:health_app/utils/popup/loaders.dart';
class UserController extends GetxController
{
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository= Get.put(UserRepository());


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
      user(UserModel.empty());
    }
  }


  Future<void> saveUserRecord(UserCredential? userCredentials) async
  {
    try
        {
             if(userCredentials!=null)
               {
                 //Convert Name to First and Last Name
                 final nameParts=UserModel.nameParts(userCredentials.user!.displayName??'');
                 final username=UserModel.generateUsername(userCredentials.user!.displayName??'');
                 //Map Data
                 final user = UserModel(
                     id: userCredentials.user!.uid,
                     firstName: nameParts[0],
                     lastName: nameParts.length>1?nameParts.sublist(1).join(' '):'',
                     username: username,
                     email: userCredentials.user!.email??'',
                     phoneNumber: userCredentials.user!.phoneNumber ??'',
                     profilePicture: userCredentials.user!.photoURL ??'',
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
}