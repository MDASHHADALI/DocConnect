

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_app/common/widgets/signupwidgets/verifyemail.dart';
import 'package:health_app/doctor/Signup/doc_navigation_page.dart';
import 'package:health_app/doctor/Signup/doctor_homepage.dart';
import 'package:health_app/login.dart';
import 'package:health_app/navigation_menu.dart';
import 'package:health_app/onboardingscreen.dart';
import 'package:health_app/services/notification_service.dart';
import 'package:health_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:health_app/utils/exceptions/firebase_exceptions.dart';
import 'package:health_app/utils/exceptions/format_exceptions.dart';
import 'package:health_app/utils/exceptions/platform_exceptions.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/popup/full_screen_loader.dart';
class AuthenticationRepository extends GetxController
{
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage= GetStorage();
  final _auth=FirebaseAuth.instance;
  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;
  /// Called from main.dart on app launch
  @override
  void onReady()
  {
    FlutterNativeSplash.remove();
   screenRedirect();
  }
  /// Function to Show Relevant Screen
  screenRedirect() async
  {
    TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);
    final user= _auth.currentUser;
    if(user!=null)
      {
        if(user.emailVerified){
          final fcmToken= await FirebaseMessaging.instance.getToken();
          final documentSnapsot=await FirebaseFirestore.instance.collection("Doctors").doc(AuthenticationRepository.instance.authUser?.uid).get();
          if(documentSnapsot.exists)
            {
              await FirebaseFirestore.instance.collection('Doctors').doc(user.uid).update(({'FCMToken':fcmToken}));
              TFullScreenLoader.stopLoading();
              Get.offAll(()=> const DocNavigationMenu());
            }
          else{
            await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({'FCMToken':fcmToken});
            TFullScreenLoader.stopLoading();
          Get.offAll(()=> const NavigationMenu( ));

          }
        }
        else
          {
            TFullScreenLoader.stopLoading();
            Get.offAll(()=>VerifyEmail(email: _auth.currentUser?.email,));
          }
      }
    else
      {
        deviceStorage.writeIfNull('isFirstTime', true);
        deviceStorage.read('isFirstTime')!=true?Get.offAll(()=> const LoginScreen()):Get.offAll(()=>const OnBoardingScreen());
      }

  }
  screenRedirectByAshhad() async
  {
    final user= _auth.currentUser;
    if(user!=null)
    {
      if(user.emailVerified){
        final fcmToken= await FirebaseMessaging.instance.getToken();
        final documentSnapsot=await FirebaseFirestore.instance.collection("Doctors").doc(AuthenticationRepository.instance.authUser?.uid).get();
        if(documentSnapsot.exists)
        {
          await FirebaseFirestore.instance.collection('Doctors').doc(user.uid).update({'FCMToken':fcmToken});
          TFullScreenLoader.stopLoading();
          Get.offAll(()=> const DocNavigationMenu());
        }
        else{
          await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({'FCMToken':fcmToken});
          TFullScreenLoader.stopLoading();
          Get.offAll(()=> const NavigationMenu( ));
        }
      }
      else
      {
        TFullScreenLoader.stopLoading();
        Get.offAll(()=>VerifyEmail(email: _auth.currentUser?.email,));
      }
    }
    else
    {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime')!=true?Get.offAll(()=> const LoginScreen()):Get.offAll(()=>const OnBoardingScreen());
    }

  }

  /// [EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(String email,String password) async
  {
    try{
      return await _auth.signInWithEmailAndPassword(email:email,password:password);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async
  {
    try
        {
          return await _auth.createUserWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  ///[EmailVerification] - MAIL VERIFICATION
   Future<void> sendEmailVerification() async
   {
     try{
       await _auth.currentUser?.sendEmailVerification();
     } on FirebaseAuthException catch (e){
       throw TFirebaseAuthException(e.code).message;
     } on FirebaseException catch (e){
       throw TFirebaseException(e.code).message;
     } on FormatException catch (_){
       throw const TFormatException();
     } on PlatformException catch (e){
       throw TPlatformException(e.code).message;
     } catch (e){
       throw 'Something went wrong. Please try again';
     }
   }
   ///[EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async
  {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
   ///[LogoutUser] - Valid for any authentication.
  Future<void> logout() async
  {
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(()=> const LoginScreen());
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /*----------------------------Federate identity & social sign-in-------------------------------*/
  ///[GoogleAuthentication] - GOOGLE
  Future<UserCredential?>

  signInWithGoogle() async
  {
    try{
      //Trigger the authentication flow
    final GoogleSignInAccount?userAccount=await GoogleSignIn().signIn();
    //Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth= await userAccount?.authentication;
    //Create an new credential
    final credentials= GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    //Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      if(kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

}