import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'MyApp.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';
Future<void> main() async {
  //Widget Binding
  final WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
  //GetX Local Storage
  await GetStorage.init();
  //Await Splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform).then(
        (FirebaseApp value)=> Get.put(AuthenticationRepository()),

  );
  runApp(const MyApp());
}

