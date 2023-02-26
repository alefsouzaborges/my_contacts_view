// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';

class CustomInputs {

  static customInputMain({
    required TextEditingController controller, 
    bool? isPassword, bool? enabled, 
    List<TextInputFormatter>? formatter, 
    bool? readOnly,
    Function()? onTap,
    TextAlign? align}){
    return TextField(
      textAlign: align ?? TextAlign.left,
      onTap: onTap,
      readOnly: readOnly ?? false,
      inputFormatters: formatter,
      enabled: enabled,
      obscureText: isPassword ?? false,
      controller: controller,
      autocorrect: false,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          
        )
      ),
    );

  }

  static customInputSearch({
    Function(String)? onChange, 
    bool? isPassword, bool? enabled, 
    List<TextInputFormatter>? formatter, 
    bool? readOnly,
    Function()? onTap,
    TextAlign? align}){
    return TextField(
      onChanged: onChange,
      textAlign: align ?? TextAlign.left,
      onTap: onTap,
      readOnly: readOnly ?? false,
      inputFormatters: formatter,
      enabled: enabled,
      obscureText: isPassword ?? false,
      autocorrect: false,
      autofocus: false,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(color: CustomColors.PRIMARYCOLOR)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: CustomColors.PRIMARYCOLOR))
      ),
    );

  }

}