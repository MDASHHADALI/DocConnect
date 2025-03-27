import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
class User {
  final String symptom;
  final int id;

  User({required this.symptom, required this.id});

  @override
  String toString() {
    return symptom;
  }
}
class User2 {
  final String lifestyle;
  final int id;

  User2({required this.lifestyle, required this.id});

  @override
  String toString() {
    return lifestyle;
  }
}
class AppointmentController extends GetxController
{
  static AppointmentController get instance => Get.find();
  final dob=TextEditingController();
  final lastName=TextEditingController();
  final firstName=TextEditingController();
  final controller = MultiSelectController<User>();
  final controller2 = MultiSelectController<User2>();
  late String habits;
  late String symptoms;
  late String selDoctor;
  late String degreeOfDoctor;
  late String doctorSpecialization;
  late String doctorId;
  late String date;
  late String time;
  late String gender;
  GlobalKey<FormState> patientFormKey= GlobalKey<FormState>();
}