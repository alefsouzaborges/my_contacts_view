// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_contacts_view/modules/auth/controller/auth_controller.dart';
import 'package:my_contacts_view/modules/contacts/controller/register_contacts_controller.dart';
import 'package:my_contacts_view/widgets/dialogs/customDialogs.dart';
import '../../../utils/colors/customColors.dart';
import '../../../widgets/buttons/custonButtons.dart';
import '../../../widgets/inputs/customInputs.dart';
import '../../../widgets/text/customText.dart';

class PerfilPage extends StatelessWidget {

  final _controller = Get.put(AuthController());
  final _controllerRegister = Get.put(RegisterContactsController());

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
        title: CustomText.customTextAppBar(text: 'PERFIL', color: CustomColors.PRIMARYTEXTCOLOR, fontWeight: FontWeight.w500),
        elevation: 10,
        iconTheme: const IconThemeData(color: CustomColors.ICONCOLORSECONDARY),
      ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Column(
                          children: [
                            CustomText.customTextMain(text: 'Nome', alignment: Alignment.centerLeft),
                            CustomInputs.customInputMain(controller: _controller.nomeController, enabled: false),

                            CustomText.customTextMain(text: 'E-mail', alignment: Alignment.centerLeft),
                            CustomInputs.customInputMain(controller: _controller.emailController, enabled: false),
          
                            CustomText.customTextMain(text: 'Senha', alignment: Alignment.centerLeft),
                            CustomInputs.customInputMain(controller: _controller.senhaController, isPassword: true, enabled: false),
          
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: CustomButtons.customButtonsMain(
                              onPressed: (){
                                //Get.to(() => HomePage());
                                CustomDialogs.customDialogConfirm(
                                  title: 'Excluir conta?', 
                                  context: context, 
                                  subtitle: 'Tem certeza de que deseja excluir sua conta?',
                                  onPressedConfirm: () async {
                                    await _controller.deleteAccount(context: context);
                                    await _controllerRegister.getAllContacts();
                                    _controllerRegister.listContacts.clear();
                                  });
                                  
                              }, 
                              title: 'EXCLUIR CONTA'),
                            ),                  
                          ],
                        ),
                      )
                    ),
                  )
              ],
            ),
          ),
      );
  }
}