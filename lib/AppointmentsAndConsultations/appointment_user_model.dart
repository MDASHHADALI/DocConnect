
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/utils/formatters/formatter.dart';

/// Model class representing user data
class AppointmentUserModel
{
  final String id;
  String firstName;
  String lastName;
  final String userid;
  final String doctorId;
  final String dob;
  final String symptoms;
  final String habits;
  final String selDoctor;
  final String degree;
  final String specialization;
  final String date;
  final String time;
  final String link;
  final String gender;
  final String status;
  /// Constructor for UserModel.
  AppointmentUserModel( {
    required this.degree,
    required this.specialization,
    required this.dob,
    required this.symptoms,
    required this.habits,
    required this.selDoctor,
    required this.link,
    required this.date,
    required this.time,
    required this.gender,
    required this.status,
    required this.id,
    required this.userid,
    required this.doctorId,
    required this.firstName,
    required this.lastName,
  });
  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';
  /// Static function to split full name into first and last name,
  static List<String> nameParts(fullName)=> fullName.split(" ");
  /// Static function to extract all symptoms and lifestyle.
  static List<String> allSymptomsOrLifestyle(sl)=> sl.split(",");
  /// Static function to create an empty user model.
  static AppointmentUserModel empty() => AppointmentUserModel(id: '', firstName: '',lastName: '',userid: '', doctorId: '', dob: '', symptoms: '', habits: '', selDoctor: '', date: '', time: '', gender: '', status: '', degree: '', specialization: '', link: '');
  /// Convert model to JSON structure for storing data in Firebase
  Map<String,dynamic> toJson()
  {
    return {
      'UserID': userid,
      'DoctorID': doctorId,
      'FirstName': firstName,
      'LastName': lastName,
      'Specialization': specialization,
      'Degree': degree,
      'DateOfBirth': dob,
      'Gender': gender,
      'Symptoms': symptoms,
      'LifestyleAndHabits': habits,
      'SelectedDoctorName':selDoctor,
      'DateOfAppointment':date,
      'TimeOfAppointment':time,
      'Status':status,
    };
  }
  ///Factory method to create a UserModel from a Firebase document snapshot.
  factory AppointmentUserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
  {
    if(document.data() != null)
    {
      final data= document.data()!;
      return AppointmentUserModel(id: document.id,
        firstName: data['FirstName']??'',
        lastName: data['LastName']??'',
        userid: data['UserID']??'',
        doctorId: data['DoctorID']??'',
        dob: data['DateOfBirth']??'',
        symptoms: data['Symptoms']??'',
        habits: data['LifestyleAndHabits']??'',
        selDoctor: data['SelectedDoctorName']??'',
        date: data['DateOfAppointment']??'',
        time: data['TimeOfAppointment']??'',
        gender: data['Gender']??'',
        status: data['Status']??'',
        degree: data['Degree']??'',
        specialization: data['Specialization']??'',
        link: data['Link']??'',
      );
    }
    else
    {
      return AppointmentUserModel.empty();
    }

  }
}