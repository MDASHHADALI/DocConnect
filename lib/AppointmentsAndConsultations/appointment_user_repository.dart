import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_app/AppointmentsAndConsultations/appointment_user_model.dart';
import 'package:health_app/data/repositories/authentication/authentication_repository.dart';


import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AppointmentUserRepository extends GetxController
{
  static AppointmentUserRepository get instance => Get.find();
  final FirebaseFirestore _db= FirebaseFirestore.instance;
  /// Function to save patient data to Firestore.
  Future<void> saveUserRecord(AppointmentUserModel user) async
  {
    try{
      await _db.collection("Patients").doc(user.id).set(user.toJson());
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
  /// Function to fetch patient details based on user ID.
  Future<List<AppointmentUserModel>> fetchUserDetailsByUser(String userId, String status) async
  {
    try{
      final querySnapshot=await _db.collection("Patients").where('UserID',isEqualTo: userId).where('Status',isEqualTo: status).get();
      final userdata= querySnapshot.docs.map((e)=>AppointmentUserModel.fromSnapshot(e)).toList();
      return userdata;
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
  /// Function to update patient data in Firestore .
  Future<void> updateUserDetails(AppointmentUserModel updatedUser) async
  {
    try{
      await _db.collection("Patients").doc(updatedUser.id).update(updatedUser.toJson());
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
  /// Function to remove patient data from firestore.
  Future<void> removeUserRecord(String userId) async
  {
    try{
      await _db.collection("Patients").doc(userId).delete();
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