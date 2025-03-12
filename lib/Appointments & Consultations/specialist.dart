import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  var C = [Colors.green,Colors.green,Colors.green].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    C[widget.currentIndex]=Colors.blue;
    WidgetsBinding.instance!.addPostFrameCallback((_)=>controller.jumpTo(index: widget.currentIndex));
  }
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    var st=["Cardiologist","Physician","Pediatrician","Neurologist","Dentist"];
    var selIndex=widget.currentIndex.obs;
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
                  itemCount: 3,
                  itemScrollController: controller,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return  Obx(
                        ()=> GestureDetector(
                        onTap: ()=>{
                          C[selIndex.toInt()]=Colors.green,
                          selIndex=index.obs,
                        C[index]=Colors.blue,
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                              color: C[index],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child:  Center(child: Text(st[index],style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.white),)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ) ,
        ),
      ),
    );
  }
}
