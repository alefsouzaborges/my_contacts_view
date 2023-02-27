// ignore_for_file: sort_child_properties_last, file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

class CustomButtons {

  static customButtonsMain({required Function() onPressed, required String title}){
    return Container(
      height: 55,
      margin: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
        onPressed: onPressed, 
        child: CustomText.customTextMain(text: title, fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        style: ElevatedButton.styleFrom(
          primary: CustomColors.PRIMARYCOLOR
        ),
        ),
    );
  }

   static customButtonsSearch({required Function() onPressed, required IconData icon,required bool isLoading}){
    return Container(
      height: 55,
      margin: const EdgeInsets.only(top: 5),
      child: ElevatedButton(
        onPressed: isLoading ? (){} : onPressed, 
        child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)) : Icon(icon, size: 30),
        style: ElevatedButton.styleFrom(
          primary: CustomColors.PRIMARYCOLOR
        ),
        ),
    );
  }

   static customButtonsText({required Function() onPressed, required String title}){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 5),
      child: TextButton(
        onPressed: onPressed, 
        child: CustomText.customTextMain(text: title, fontSize: 18, fontWeight: FontWeight.w400),
        ),
    );
  }

}