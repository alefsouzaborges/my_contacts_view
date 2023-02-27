// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';

class CustomText {

 static customTextMain({required String text, Color? color, double? fontSize, FontWeight? fontWeight, Alignment? alignment}){
   return Container(
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    alignment: alignment ?? Alignment.center,
     child: Text(
        text,
        style: TextStyle(
          color: color ?? CustomColors.PRIMARYTEXTCOLOR,
          fontSize: fontSize ?? 18,
          fontWeight: fontWeight ?? FontWeight.normal
        ),),
   );
  }

  static customTextAppBar({required String text, Color? color, double? fontSize, FontWeight? fontWeight}){
   return Text(
      text,
      style: TextStyle(
        color: color ?? CustomColors.PRIMARYTEXTCOLOR,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.normal
      ),);
  }


}