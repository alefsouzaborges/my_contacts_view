// ignore_for_file: prefer_const_constructors

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_contacts_view/modules/contacts/controller/register_contacts_controller.dart';
import 'package:my_contacts_view/modules/contacts/view/search_api_google.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/dialogs/customDialogs.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

import '../../../widgets/buttons/custonButtons.dart';
import '../../../widgets/inputs/customInputs.dart';

class RegisterContactsPage extends StatelessWidget {

  final controller = Get.put(RegisterContactsController());

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
        title: CustomText.customTextAppBar(text: controller.isEditing.value ? 'ATUALIZAR DADOS' : 'CADASTRAR', color: CustomColors.PRIMARYTEXTCOLOR, fontWeight: FontWeight.w500),
        elevation: 10,
        iconTheme: const IconThemeData(color: CustomColors.ICONCOLORSECONDARY),
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                CustomText.customTextMain(text: 'NOME', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(controller: controller.nomeController),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'CPF', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(
                            controller: controller.cpfController,
                            formatter: [
                              controller.cpfMaskFormater
                            ]),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'SEXO', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(
                            align: TextAlign.center,
                            controller: controller.sexoController, 
                            readOnly: true,
                            onTap: (){
                              CustomDialogs.customDialogGender(
                                title: 'Selecione um genêro',
                                onPressedMask: (){
                                  controller.sexoController.text = 'M';
                                  Get.back();
                                },
                                onPressedFem: (){
                                  controller.sexoController.text = 'F';
                                  Get.back();
                                });
                            }),
                        ],
                      ),
                    ),
                  ],
                ),

                CustomText.customTextMain(text: 'TELEFONE', alignment: Alignment.centerLeft),
                CustomInputs.customInputMain(
                  controller: controller.phoneController,
                  formatter: [
                    controller.phoneMaskFormater
                  ]),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'CEP', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(
                            controller: controller.cepController,
                            formatter: [
                              controller.cepMaslFormater
                            ]),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 65,
                            child: Obx(() {
                              return CustomButtons.customButtonsSearch(
                              isLoading: controller.isLoading.value,
                              onPressed: () async {
                                await controller.getAdressByCep(context: context);
                                controller.focusGoogleSearch.requestFocus();
                              }, 
                              icon: Icons.search
                              );
                            },)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                CustomText.customTextMain(text: 'ENDEREÇO', alignment: Alignment.centerLeft),
                CustomInputs.customInputSearchSuggestion(),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'COMPLEMENTO', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(controller: controller.complementoController),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                      Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'UF', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(controller: controller.ufController), 
                        ],
                      ),
                    ),
                  ],
                ),
                 Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'LATITUDE', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(
                            controller: controller.latitudeController,
                            readOnly: true),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                      Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText.customTextMain(text: 'LONGITUDE', alignment: Alignment.centerLeft),
                          CustomInputs.customInputMain(
                            controller: controller.longitudeController,
                            readOnly: true),
                        ],
                      ),
                    ),
                    
                  ],
                ),
                if(!controller.isEditing.value)...[
                  Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomButtons.customButtonsMain(
                  onPressed: () async {
                    await controller.addContact(context: context);
                  }, 
                  title: 'CADASTRAR'),
                ),
                ]else
                 Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomButtons.customButtonsMain(
                  onPressed: () async {
                    await controller.editContact(context: context);
                  }, 
                  title: 'ATUALIZAR CONTATO'),
                ),
                if(controller.isEditing.value)...[
                  Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomButtons.customButtonsMain(
                  onPressed: () async {
                    return CustomDialogs.customDialogConfirm(
                      title: 'Remover contato', 
                      context: context, 
                      subtitle: 'Deseja remover o contato selecionado?',
                      onPressedConfirm: () async {
                        await controller.deleteContact(context: context);
                        Get.back();
                      });
                  }, 
                  title: 'REMOVER CONTATO'),
                ),
                ]
            ],
          ),
        ),
      ),
    );
  }
}