// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:my_contacts_view/modules/contacts/controller/register_contacts_controller.dart';
import 'package:my_contacts_view/widgets/inputs/customInputs.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

import '../../../utils/colors/customColors.dart';

class SearchApiGoogleSuggestion extends StatelessWidget {

  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterContactsController());
    return Scaffold(
        appBar: AppBar(
         backgroundColor: Colors.white,
        toolbarHeight: 55,
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarBrightness:Brightness.light ,
        statusBarColor: Colors.white,),
        centerTitle: true,
        title: CustomText.customTextAppBar(text: 'ENDEREÇO') ,
        elevation: 10,
        iconTheme: const IconThemeData(color: CustomColors.ICONCOLORSECONDARY),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // CustomInputs.customInputSearchSuggestion(
              // onChange: (value){
              //   controller.placeAutoCompleteRequest(query: value);
              // }),

              
            ],
          ),
        ),
        );
  }
}