import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();
  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;



  Future<void> initialize() async
  {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //Request permission
    await requestPermission();
    // Setup message handlers
    await _setupMessageHandlers();
  }

 Future<void> requestPermission() async{
   final settings = await _messaging.requestPermission(
     alert: true,
     badge: true,
     sound: true,
     provisional: false,
     announcement: false,
     carPlay: false,
     criticalAlert: false,
   );
   debugPrint("Permission status: ${settings.authorizationStatus}");
 }
 Future<void> setupFlutterNotifications() async {
   if(_isFlutterLocalNotificationsInitialized)
     {
       return;
     }
   const channel = const AndroidNotificationChannel(
     'high_importance_channel', // id
     'High Importance Notifications', // title
     description:
     'This channel is used for important notifications.', // description
     importance: Importance.high,
   );

   await _localNotifications
       .resolvePlatformSpecificImplementation<
       AndroidFlutterLocalNotificationsPlugin>()
       ?.createNotificationChannel(channel);

   const initializationSettingsAndroid= AndroidInitializationSettings('@drawable/splash');
   //ios setting
   const initializationSettingsDarwin = DarwinInitializationSettings();
   const initializationSettings = InitializationSettings(
     android:  initializationSettingsAndroid,
     iOS: initializationSettingsDarwin,
   );
   await _localNotifications.initialize(initializationSettings,
   onDidReceiveNotificationResponse: (details)
   {

   });
   _isFlutterLocalNotificationsInitialized=true;
 }
 Future<void> showNotification(RemoteMessage message) async{
   RemoteNotification? notification = message.notification;
   AndroidNotification? android = message.notification?.android;
   if(notification!=null && android !=null)
     {
       await _localNotifications.show(
           notification.hashCode,
           notification.title,
           notification.body,
           const NotificationDetails(
             android: AndroidNotificationDetails('high importance channel',
                 'High importance Notifications',
                 channelDescription: 'This channel is used for important notifications',
                 importance: Importance.high,
                 priority: Priority.high,
                 icon: '@drawable/splash',
             ),
             iOS: DarwinNotificationDetails(
               presentAlert: true,
               presentBadge: true,
               presentSound: true,
             ),
           ),
       payload: message.data.toString(),
       );
     }
 }
 Future<void> _setupMessageHandlers() async{
   //Foreground message
   FirebaseMessaging.onMessage.listen((message){
     showNotification(message);
   });
   //Background message
   FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
   // opened app
   final initialMessage = await _messaging.getInitialMessage();
   if(initialMessage!=null)
     {
       _handleBackgroundMessage(initialMessage);
     }
 }
 void _handleBackgroundMessage(RemoteMessage message) {
   print("Background Message: ${message.notification?.title}");
 }


}