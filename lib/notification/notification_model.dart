
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/utils/formatters/formatter.dart';

/// Model class representing user data
class NotificationModel
{
  final String id;
  String title;
  String subtitle;
  String picture;
  String seen;
  String personId;
  /// Constructor for UserModel.
  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.picture,
    required this.seen,
    required this.personId,
  });

  /// Static function to create an empty user model.
  static NotificationModel empty() => NotificationModel(id: '', title: '', subtitle: '', picture: '', seen: '', personId: '');
  /// Convert model to JSON structure for storing data in Firebase
  Map<String,dynamic> toJson()
  {
    return {
      'Title': title,
      'Subtitle': subtitle,
      'Picture': picture,
      'Seen': seen,
      'PersonId': personId,

    };
  }
  ///Factory method to create a UserModel from a Firebase document snapshot.
  factory NotificationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document)
  {
    if(document.data() != null)
    {
      final data= document.data()!;
      return NotificationModel(id: document.id,

          title: data['Title']??'',
          subtitle: data['Subtitle']??'',
          picture: data['Picture']??'',
          seen: data['Seen']??'',
          personId: data['PersonId']??'',
      );
    }
    else
    {
      return NotificationModel.empty();
    }

  }
}