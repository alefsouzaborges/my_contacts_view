// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/buttons/custonButtons.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

class CustomDialogs {


  static customDialogAuth({
    required String title, 
    required BuildContext context,
    required String subtitle,
    Function()? onPressed }){
    return Get.defaultDialog(
      contentPadding: EdgeInsets.all(20),
      radius: 10,
     // backgroundColor: DefaultColors.COLORDIALOGMODAL,
      title: title,
      titleStyle: TextStyle(
        color:CustomColors.PRIMARYTEXTCOLOR,
        fontSize: 18,
      ),
      content: WillPopScope(
        onWillPop: () async => true,
        child: Column(
          children: [
            CustomText.customTextAppBar(text: subtitle),
        SizedBox(height: 20),
        CustomButtons.customButtonsMain(
          onPressed: onPressed ?? (){
            Get.back();
          }, 
          title: 'Voltar'
          )
          ],
        ),
      )
    );
  }

  static customDialogGender({
    required String title, 
    Function()? onPressedMask,
    Function()? onPressedFem }){
    return Get.defaultDialog(
      contentPadding: EdgeInsets.all(20),
      radius: 10,
     // backgroundColor: DefaultColors.COLORDIALOGMODAL,
      title: title,
      titleStyle: TextStyle(
        color:CustomColors.PRIMARYTEXTCOLOR,
        fontSize: 18,
      ),
      content: WillPopScope(
        onWillPop: () async => true,
        child: Column(
          children: [
        SizedBox(height: 20),
        CustomButtons.customButtonsMain(
          onPressed: onPressedMask ?? (){
            Get.back();
          }, 
          title: 'MASCULINO'
          ),
          CustomButtons.customButtonsMain(
          onPressed: onPressedFem ?? (){
            Get.back();
          }, 
          title: 'FEMININO'
          )
          ]
          ,
        ),
      )
    );
  }

   static customDialogConfirm({
    required String title, 
    required BuildContext context,
    required String subtitle,
    Function()? onPressedConfirm }){
    return Get.defaultDialog(
      contentPadding: EdgeInsets.all(20),
      radius: 10,
     // backgroundColor: DefaultColors.COLORDIALOGMODAL,
      title: title,
      titleStyle: TextStyle(
        color:CustomColors.PRIMARYTEXTCOLOR,
        fontSize: 18,
      ),
      content: WillPopScope(
        onWillPop: () async => true,
        child: Column(
          children: [
            CustomText.customTextAppBar(text: subtitle),
            SizedBox(height: 20),
             Row(
              children: [
              Expanded(child: CustomButtons.customButtonsMain(
                onPressed: (){
                  Get.back();
                }, 
                title: 'Voltar'
                ),),
            SizedBox(width: 20),
             Expanded(child:  CustomButtons.customButtonsMain(
                onPressed: onPressedConfirm ?? (){
                  Get.back();
                }, 
                title: 'Confirmar'
                ))
              ],
             )
              ],
            ),
      )
    );
  }

  // static customDialog({required String title, required String subtitle, required BuildContext context, required Function() confirm,  required Function() cancel, required String titleButtonConfirm,required String titleButtonCancel}){
  //   return Get.defaultDialog(
  //     barrierDismissible: false,
  //     contentPadding: EdgeInsets.all(20),
  //     radius: 10,
  //     backgroundColor: DefaultColors.COLORDIALOGMODAL,
  //     title: title,
  //     titleStyle: TextStyle(
  //       color: DefaultColors.COLORTEXTPRIMARY,
  //       fontSize: 18,
  //     ),
  //     content: WillPopScope(
  //       onWillPop: () async => false,
  //       child: Column(
  //         children: [
  //         SizedBox(height: 20),
  //         CustomText.customTextDefault(title: subtitle),
  //         SizedBox(height: 40),
  //         Row(
  //           children: [
  //             Expanded(
  //             child: CustomButtom.customButtonModal(
  //             context: context, 
  //             title: titleButtonCancel, onTap: cancel),),
  //             SizedBox(width: 10),
  //             Expanded(child: CustomButtom.customButtonModal(
  //             context: context, 
  //             title: titleButtonConfirm, onTap: confirm),),
  //           ],
  //         )
  //         ],
  //       ),
  //     ));  
  // }

  // static customDialogError({required String title, required String subtitle, required BuildContext context, required Function() confirm, String? placeholder}){
  //   return Get.defaultDialog(
  //     barrierDismissible: false,
  //     contentPadding: EdgeInsets.all(20),
  //     radius: 10,
  //     backgroundColor: DefaultColors.COLORDIALOGMODAL,
  //     title: title,
  //     titleStyle: TextStyle(
  //       color: DefaultColors.COLORTEXTPRIMARY,
  //       fontSize: 18,
  //     ),
  //     content: WillPopScope(
  //       onWillPop: () async => false,
  //       child: Column(
  //         children: [
  //         SizedBox(height: 20),
  //         CustomText.customTextDefault(title: subtitle),
  //         SizedBox(height: 40),
  //         Row(
  //           children: [
  //             Expanded(child: CustomButtom.customButtonModal(
  //             context: context, 
  //             title: 'VOLTAR', onTap: confirm),),
  //           ],
  //         )
  //         ],
  //       ),
  //     ));  
  // }

  // static customDialogLoading({required String title,required BuildContext context}){
  //   return Get.defaultDialog(
  //     barrierDismissible: false,
  //     contentPadding: EdgeInsets.all(20),
  //     radius: 10,
  //     backgroundColor: DefaultColors.COLORDIALOGMODAL,
  //     title: title,
  //     titleStyle: TextStyle(
  //       color: DefaultColors.COLORTEXTPRIMARY,
  //       fontSize: 18,
  //     ),
  //     content: WillPopScope(
  //       onWillPop: () async => false,
  //       child: Column(
  //         children: [
  //         SizedBox(height: 20),
  //         CustomText.customTextDefault(title: title),
  //         SizedBox(height: 40),
  //         CircularProgressIndicator(color: DefaultColors.COLOSECUNDARY,)
         
  //         ],
  //       ),
  //     ));  
  // }
  
}