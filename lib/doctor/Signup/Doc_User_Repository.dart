
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_app/data/repositories/authentication/authentication_repository.dart';
import 'package:health_app/usermodel.dart';
import 'package:health_app/utils/constants/image_strings.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import 'DocUserModel.dart';

class DocUserRepository extends GetxController
{
  static DocUserRepository get instance => Get.find();
  final FirebaseFirestore _db= FirebaseFirestore.instance;
  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(DocUserModel user) async
  {
    try{
      await _db.collection("Doctors").doc(user.id).set(user.toJson());
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to fetch user details based on user ID.
  Future<DocUserModel> fetchUserDetails() async
  {
    try{
      final documentSnapsot=await _db.collection("Doctors").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapsot.exists)
      {
        return DocUserModel.fromSnapshot(documentSnapsot);
      }
      else
      {
        return DocUserModel.empty();
      }
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to update user data in Firestore .
  Future<void> updateUserDetails(DocUserModel updatedUser) async
  {
    try{
      await _db.collection("Doctors").doc(updatedUser.id).update(updatedUser.toJson());
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String,dynamic>json) async
  {
    try{
      await _db.collection("Doctors").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to remove user data from firestore.
  Future<void> removeUserRecord(String userId) async
  {
    try{
      await _db.collection("Doctors").doc(userId).delete();
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to upload image to firebase.
  Future<String> uploadImage(String path, XFile image) async
  {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url =await ref.getDownloadURL();
      return url;
    }on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    } on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }

}