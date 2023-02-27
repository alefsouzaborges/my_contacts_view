// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, file_names


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:my_contacts_view/modules/contacts/controller/register_contacts_controller.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';

class CustomInputs {

  static customInputMain({
    required TextEditingController controller, 
    bool? isPassword, bool? enabled, 
    List<TextInputFormatter>? formatter, 
    TextInputType? textInputType,
    bool? readOnly,
    Function()? onTap,
    TextAlign? align}){
    return TextField(
      keyboardType: textInputType,
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

  static customInputSearchSuggestion(){
    final _controller = Get.put(RegisterContactsController());
    return  GooglePlaceAutoCompleteTextField(
              textEditingController: _controller.enderecoController,
              googleAPIKey: "AIzaSyDT-8nXeXAGZC04-N84jS5K2WHRCrK-x-M",
              inputDecoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on, color: CustomColors.ICONCOLOR),
                border: OutlineInputBorder()
              ),
              debounceTime: 600, // default 600 ms,
              countries: const ["br"],// optional by default null is set
              isLatLngRequired:true,// if you required coordinates from place detail
              getPlaceDetailWithLatLng: (Prediction prediction) {
              _controller.latitudeController.text = prediction.lat.toString();
              _controller.longitudeController.text = prediction.lng.toString();
              }, // this callback is called when isLatLngRequired is true
              itmClick: (Prediction prediction) {
                _controller.enderecoController.text = prediction.description.toString();
                _controller.enderecoController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
              },
              );
  }

}