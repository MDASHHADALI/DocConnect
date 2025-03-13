import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../circular_image.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';
class SpecialistPage extends StatefulWidget {
  const SpecialistPage({super.key, required this.currentIndex});

  final int currentIndex ;
  @override
  State<SpecialistPage> createState() => _SpecialistPageState();
}

class _SpecialistPageState extends State<SpecialistPage> {
  var controller = ItemScrollController();
  var C = [TColors.white,TColors.grey,TColors.grey,TColors.grey,TColors.grey];
  var prof="";
  var st=["Cardiologist","Physician","Pediatrician","Neurologist","Dentist"];
  var selIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    C[widget.currentIndex]=Colors.blue;
    selIndex=widget.currentIndex;
    prof=st[widget.currentIndex];
    WidgetsBinding.instance!.addPostFrameCallback((_)=>controller.jumpTo(index: widget.currentIndex));
  }
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
     appBar: AppBar(
       leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?TColors.white:TColors.black ),onPressed: ()=>Get.back(),),
       title: Text('Specialist',style: Theme.of(context).textTheme.headlineSmall,),
     ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ScrollablePositionedList.builder(
                  itemCount: 5,
                  itemScrollController: controller,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return  GestureDetector(
                        onTap: ()=>{

                          setState(() {
                            print(selIndex);
                            C[selIndex]=TColors.grey;
                            selIndex=index;
                            print(selIndex);
                            C[index]=Colors.blue;
                            prof=st[index];
                          })
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: C[index],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: darkMode?TColors.light:TColors.dark),
                            ),
                            child:  Center(child: Text(st[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: index==selIndex?Colors.white:Colors.black),)),
                          ),
                        ),
                      );

                  }
                  ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
             ListView.builder(
                   physics: const ScrollPhysics(),
                  itemCount: 15,
                  shrinkWrap: true,
                  itemBuilder: (_,index){
                    return ListTile(
                       leading: CircularImage(image: "assets/user/1024.png",padding: 0,),
                        title: Text(
                          "Dr Akash Verma",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( "$prof | MBBS | MD | DM",style: Theme.of(context).textTheme.labelMedium,),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.yellow,size: 20,),
                                Text('4.9',style: Theme.of(context).textTheme.labelSmall,),
                                SizedBox(width: TSizes.spaceBtwSections,),
                                Text("(2130 Reviews)",style: Theme.of(context).textTheme.labelSmall),
                              ],
                            )
                          ],
                        ),
                        trailing: Icon(Iconsax.arrow_right),
                        onTap: (){},
                      );

              }),

          ],
        ) ,
        ),
      ),
    );
  }
}
