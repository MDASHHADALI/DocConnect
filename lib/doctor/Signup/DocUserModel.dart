
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/utils/formatters/formatter.dart';

/// Model class representing user data
class DocUserModel
{
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  final String licenseNumber;
  String location;
  String specialization;
  String yearOfExp;
  String phoneNumber;
  String profilePicture;
  /// Constructor for UserModel.
  DocUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.licenseNumber,
    required this.location,
    required this.specialization,
    required this.yearOfExp,
  });
  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';
  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);
  /// Static function to split full name into first and last name,
  static List<String> nameParts(fullName)=> fullName.split(" ");
  /// Static function to generate a username from the full name.
  static String generateUsername(fullName)
  {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length >1?nameParts[1].toLowerCase():"";
    String camelCaseUsername= "$firstName$lastName"; //Combine first and last name
    String usernameWithPrefix= "cwt_$camelCaseUsername"; //Add "cwt_" prefix
    return usernameWithPrefix;
  }
  /// Static function to create an empty user model.
  static DocUserModel empty() => DocUserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', licenseNumber: '',specialization: '', location: '', yearOfExp: '', profilePicture: '');
  /// Convert model to JSON structure for storing data in Firebase
  Map<String,dynamic> toJson()
  {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'LicenseNumber': licenseNumber,
      'Specialization':specialization,
      'LocationOfClinic':location,
      'YearOfExperience':yearOfExp,
      'ProfilePicture': profilePicture,
    };
  }
  ///Factory method to create a UserModel from a Firebase document snapshot.
  factory DocUserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
  {
    if(document.data() != null)
    {
      final data= document.data()!;
      return DocUserModel(id: document.id,
          firstName: data['FirstName']??'',
          lastName: data['LastName']??'',
          username: data['UserName']??'',
          email: data['Email']??'',
          phoneNumber: data['PhoneNumber']??'',
          licenseNumber: data['LicenseNumber']??'',
          specialization: data['Specialization']??'',
          location: data['LocationOfClinic']??'',
          yearOfExp: data['YearOfExperience']??'',
          profilePicture: data['ProfilePicture']??'',
      );
    }
    else
    {
      return DocUserModel.empty();
    }

  }
}