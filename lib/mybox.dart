
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:health_app/utils/constants/colors.dart';

import 'AppointmentsAndConsultations/online_consultation.dart';


// ignore: must_be_immutable
class MyBox extends StatelessWidget {
  var i=["assets/images/hsci/grid/g1.jpg","assets/images/hsci/grid/g2.jpg","assets/images/hsci/grid/g3.png","assets/images/hsci/grid/g4.jpg","assets/images/hsci/grid/g5.jpg","assets/images/hsci/grid/gc1.jpeg"],
      index=0,t=["24 x 7 Online","Book & Meet","Buy","Upload","Track your ","Health"],
  t1=["Consultation","Now","Medicines","Prescription","Health","Assistant"],
  lbl=["Consult","Book Now","45% off","Know More","View more","Try now"];
  MyBox(this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        (index==0)? Get.to(()=>const OnlineConsultation()):();
      },

      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          // image: DecorationImage(image: AssetImage(i[index])),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [Expanded(flex: 4,child:
          Stack(
            children:[
              Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(i[index],),
            ),),
               Positioned(
                 bottom: 0,
                 right:15,
                 left: 15,
                 child: Container(
                   width: 50,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(50),
                     color: TColors.primary,
                   ),
                   child: Center(child: Text(lbl[index],style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white),)),
                 ),
               ),
            ],
          ),),
            Expanded(flex: 2,child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(t[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black),),
                  Text(t1[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black),maxLines: 2,),
                ],
              ),
            ),),
           // Expanded(flex: 1,child: Text(t1[index],style: Theme.of(context).textTheme.bodyLarge,maxLines: 2,),),
            ],
        ),
      ),
    );
  }
}
