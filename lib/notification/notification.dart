import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_app/AppointmentsAndConsultations/MeetingScreen/meetingScreen.dart';
import 'package:health_app/doctor/linkPage.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';
import 'package:health_app/utils/popup/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

import '../circular_image.dart';
import '../data/repositories/authentication/authentication_repository.dart';


class Notification extends StatelessWidget {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthenticationRepository.instance;
    final FirebaseFirestore _db= FirebaseFirestore.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          leading: const Center(child: Icon(Icons.video_camera_front_outlined,color: Colors.blue,size: 30,)),
          title: const Text('Notifications',style: TextStyle(color: Colors.blueAccent),),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _db.collection("Notifications").where('PersonId',isEqualTo: _auth.authUser!.uid).snapshots(),
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
                                    data['Title'],
                                    style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.red),
                                  ),
                                  subtitle:  Text( "Date - ${data['DateOfAppointment']}\nTime - ${data['TimeOfAppointment']}",style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black87),),
                                  // trailing: const Icon(Iconsax.arrow_right),
                                  onTap: ()  {
                                    Get.to(()=>LinkPage(patientId: data.id,));
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
