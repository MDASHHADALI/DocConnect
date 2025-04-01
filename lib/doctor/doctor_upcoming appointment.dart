import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/doctor/linkPage.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../circular_image.dart';
import '../data/repositories/authentication/authentication_repository.dart';
import '../utils/constants/colors.dart';


class DoctorUpcomingAppointment extends StatelessWidget {
  const DoctorUpcomingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthenticationRepository.instance;
    final FirebaseFirestore _db= FirebaseFirestore.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          leading: Center(child: Icon(Icons.video_camera_front_outlined,color: darkMode?Colors.lightGreenAccent:Colors.green.shade600,size: 30,)),
          title: Text('Video Consultations',style: TextStyle(color: darkMode?Colors.white:Colors.black87),),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _db.collection("Patients").where('DoctorID',isEqualTo: _auth.authUser!.uid).where('Status',isEqualTo: 'Upcoming').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  SizedBox(
                          height: MediaQuery.of(context).size.height-140,
                          child: const Center(
                              child: Text("Loading....")
                          )
                      );
                    }
                    return (snapshot.data!.docs.isEmpty)?SizedBox(
                      height: MediaQuery.of(context).size.height-140,
                      child: const Center(child: Text("No Data Found")),
                    ):ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_,index){
                          var data=snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 2.0),
                            child: Card(
                              color: Colors.yellow,
                              child: ListTile(
                                  trailing: const Icon(Icons.video_call,color:Colors.red),
                                  leading: const CircularImage(image: "assets/user/as.png",padding: 0,fit: BoxFit.fill,),
                                  title: Text(
                                    "${data['FirstName']} ${data['LastName']}",
                                    style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red),
                                  ),
                                  subtitle:  Text( "Date - ${data['DateOfAppointment']}\nTime - ${data['TimeOfAppointment']}",style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black87),),
                                  // trailing: const Icon(Iconsax.arrow_right),
                                  onTap: ()  {
                                   Get.to(()=>LinkPage(patientId: data.id,userId: data['UserID'],));
                                  }
                              ),
                            ),
                          );

                        });
                  }
              ),
            ],
          ),
        )
    );
  }
}
