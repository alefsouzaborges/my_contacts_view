// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

import '../../../widgets/buttons/custonButtons.dart';
import '../../../widgets/inputs/customInputs.dart';
import '../controller/auth_controller.dart';

class SignUpPage extends StatelessWidget {

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
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
        title: CustomText.customTextAppBar(text: 'CADASTRAR', color: CustomColors.PRIMARYTEXTCOLOR, fontWeight: FontWeight.w500),
        elevation: 10,
        iconTheme: const IconThemeData(color: CustomColors.ICONCOLORSECONDARY),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                Column(
                  children: [
                CustomText.customTextMain(text: 'Nome', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(controller: controller.nomeController),
                
                CustomText.customTextMain(text: 'E-mail', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(controller: controller.emailController),
                
                CustomText.customTextMain(text: 'Senha', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(controller: controller.senhaController, isPassword: true),
                
                CustomText.customTextMain(text: 'Repetir senha', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(controller: controller.rSenhaController, isPassword: true),
                  ],
                ),
      
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomButtons.customButtonsMain(
                  onPressed: (){
                    controller.signUp(
                      context: context,
                    );
                  }, 
                  title: 'CADASTRAR'),
                ),
      
            ],
          ),
        ),
      ),
    );
  }
}