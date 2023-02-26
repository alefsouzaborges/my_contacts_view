// ignore_for_file: unnecessary_new

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_contacts_view/database/database.dart';
import 'package:my_contacts_view/modules/auth/model/auth_model.dart';
import 'package:my_contacts_view/modules/home/view/home_page.dart';
import 'package:my_contacts_view/shared/config.dart';
import 'package:my_contacts_view/widgets/dialogs/customDialogs.dart';
import 'package:sqflite/sqflite.dart';

import '../view/auth_view.dart';

class AuthController extends GetxController {

  @override
  void onInit() {
    _database.init();
    automaticAuth();
    super.onInit();
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController rSenhaController = TextEditingController();
  AuthModel user = AuthModel();
  RxList<AuthModel> AuthList = RxList<AuthModel>();
  final _database = DatabaseLocal();



  auth({required BuildContext context}) async {
   if(emailController.text.isEmpty || senhaController.text.isEmpty){
    return CustomDialogs.customDialogAuth(
        title: 'Campos inválidos.', 
        subtitle: 'Preencha todos os campos correamente.',
        context: context,
        );
   }else{
      AuthModel model = AuthModel();
      model.nome = nomeController.text;
      model.email = emailController.text;
      model.senha = senhaController.text;
      List result = await _database.auth(model: model);
    if(result.isEmpty){
      CustomDialogs.customDialogAuth(
        title: 'Falha no login', 
        subtitle: 'Usuário ou senha inválidos.',
        context: context,
        );
    }else{
      ConfigStorageController.saveAuthStorage(model: model);
      Get.to(() => HomePage());
    }
   }
  }

  signUp({required BuildContext context}) async {
   try {
      AuthModel model = AuthModel();
    model.nome = nomeController.text;
    model.email = emailController.text;
    model.senha = senhaController.text;
    await _database.signUp(model: model);
    return  CustomDialogs.customDialogAuth(
        title: 'Sucesso', 
        subtitle: 'Cadastro realizado com sucesso! faça login!',
        context: context,
        onPressed: (){
          Get.back();
          Get.back();
        }
        );
    
   } on DatabaseException catch (e) {
     if(e.isUniqueConstraintError()){
      return  CustomDialogs.customDialogAuth(
        title: 'Falha no cadastro', 
        subtitle: 'E-mail ja cadastrado no sistema.',
        context: context,
        );
     }
       return  CustomDialogs.customDialogAuth(
        title: 'Falha no cadastro', 
        subtitle: e.toString(),
        context: context,
        );
   }
  }

  deleteAccount({required BuildContext context}) async {
    try {
      await ConfigStorageController.logoutAuthStorage();
      await _database.deleteAccount();
      clearInputs();
      Get.off(() => AuthPage());
    } catch (e) {
       return  CustomDialogs.customDialogAuth(
        title: 'Falha', 
        subtitle: e.toString(),
        context: context,
        );
    }
  }

  automaticAuth() async {
    user = await ConfigStorageController.getAuthStorage();
    if(user.email != null) {
      nomeController.text = user.nome.toString();
      emailController.text = user.email.toString();
      senhaController.text = user.senha.toString();
      Get.to(() => HomePage());
    }
  }

  clearInputs(){
    nomeController.clear();
    emailController.clear();
    senhaController.clear();
    rSenhaController.clear();
    
  }
  
}