// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:my_contacts_view/modules/auth/controller/auth_controller.dart';
import 'package:my_contacts_view/modules/auth/view/signUp.dart';
import 'package:my_contacts_view/widgets/buttons/custonButtons.dart';
import 'package:my_contacts_view/widgets/inputs/customInputs.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

class AuthPage extends StatelessWidget {

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          statusBarBrightness:Brightness.light ,
          statusBarColor: Colors.white,),
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                  Image.asset('assets/images/logo.png', width: 200,height: 150),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Column(
                          children: [
                            CustomText.customTextMain(text: 'E-mail', alignment: Alignment.centerLeft),
                            CustomInputs.customInputMain(controller: controller.emailController),
          
                            CustomText.customTextMain(text: 'Senha', alignment: Alignment.centerLeft),
                            CustomInputs.customInputMain(controller: controller.senhaController, isPassword: true),
          
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: CustomButtons.customButtonsMain(
                              onPressed: (){
                                controller.auth(context: context);
                              }, 
                              title: 'ENTRAR'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: CustomButtons.customButtonsText(
                              title: 'CADASTRE-SE',
                              onPressed: (){
                                Get.to(() => SignUpPage());
                              }, 
                              ),
                            ),
                            SizedBox(height: 50,)
                          ],
                        ),
                      )
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}