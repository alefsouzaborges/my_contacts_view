// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_contacts_view/modules/home/controller/home_controller.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/inputs/customInputs.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

class CustomAppBar {

  static customAppBarSearch({required BuildContext context,required Function(String)? onChanged}){
  final controller = Get.put(HomeController());
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(!controller.isSearch.value)...[
            Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 30),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: CustomText.customTextAppBar(text: 'MEUS CONTATOS'))),
          Container(
            child: IconButton(
            onPressed: (){
              controller.isSearch.value = !controller.isSearch.value;
            }, 
            icon: const Icon(Icons.search, color: CustomColors.ICONCOLOR,)),
          )
          ],
         if(controller.isSearch.value)...[
           Expanded(
             child: AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5),
               duration: const Duration(seconds: 5),
               width: 200,
               child: CustomInputs.customInputSearch(
                onChange:onChanged
               ),
             ),
           ),
          Container(
            child: IconButton(
            onPressed: (){
              controller.isSearch.value = !controller.isSearch.value;
            }, 
            icon: const Icon(Icons.close, color: CustomColors.ICONCOLOR)),
          )
         ]
        ],
      ),
    );
  }

}