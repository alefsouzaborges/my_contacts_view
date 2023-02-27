// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_contacts_view/database/database.dart';
import 'package:my_contacts_view/modules/auth/model/auth_model.dart';
import 'package:my_contacts_view/modules/contacts/model/adress_model.dart';
import 'package:my_contacts_view/modules/contacts/model/contact_model.dart';
import 'package:my_contacts_view/server/dioConnect.dart';
import 'package:my_contacts_view/shared/config.dart';
import 'package:sqflite/sqflite.dart';

import '../../../widgets/dialogs/customDialogs.dart';

class RegisterContactsController extends GetxController {

    Set<Marker> markers = Set<Marker>();

    @override
    void onInit() {
      sexoController.text = 'M';
      getAllContacts();
      connection = Dio(dioConnect.baseOptions);
      connection.options.baseUrl = 'https://viacep.com.br/ws/';
      super.onInit();
    }
    
    TextEditingController nomeController = TextEditingController();
    TextEditingController cpfController = TextEditingController();
    TextEditingController sexoController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController cepController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();
    TextEditingController complementoController = TextEditingController();
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    TextEditingController ufController = TextEditingController();
    AuthModel authModel = AuthModel();
    RxString gender = ''.obs;
    RxString nameResumed = ''.obs;
    RxBool isLoading = false.obs;
    RxBool isEditing = false.obs;
    RxInt id = 0.obs;
    AdressModel adressModel = AdressModel();
    List<dynamic> placesList = [];
    FocusNode focusGoogleSearch = FocusNode();

    final _dataBase = DatabaseLocal();

    RxList<ContactModel> listContacts = RxList<ContactModel>();
    Dio connection = Dio();
    RxString url = ''.obs;
    final dioConnect = Get.put(DioConnectController());

       var cpfMaskFormater = MaskTextInputFormatter(
    mask: '###.###.###-##', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
    );

    var phoneMaskFormater = MaskTextInputFormatter(
    mask: '(##) - # ####-####', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
    );

    var cepMaslFormater = MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
    );

    addContact({required BuildContext context}) async {
      authModel = await ConfigStorageController.getAuthStorage();
      if(nomeController.text.isEmpty || cpfController.text.isEmpty || 
         phoneController.text.isEmpty || cepController.text.isEmpty || sexoController.text.isEmpty || 
         latitudeController.text.isEmpty || longitudeController.text.isEmpty){
         return CustomDialogs.customDialogAuth(
          title: 'Verifique os campos', 
          subtitle: 'Preencha todos os campos corretamente.',
          context: context,
        );
      }
      else{
        if(CPFValidator.isValid(cpfController.text)){
          try {
            ContactModel model = ContactModel();
            model.nome = nomeController.text;
            model.cpf= cpfController.text;
            model.sexo = sexoController.text;
            model.telefone = phoneController.text;
            model.cep = cepController.text;
            model.endereco = enderecoController.text;
            model.complemento = complementoController.text;
            model.uf = ufController.text;
            model.latitude = latitudeController.text.isEmpty ? '' : latitudeController.text;
            model.longitude = longitudeController.text;
            await _dataBase.addContact(model: model, email_cadastro: authModel.email.toString());
            return CustomDialogs.customDialogAuth(
            title: 'Sucesso', 
            subtitle: 'Contato cadastrado com sucesso.',
            context: context,
            onPressed: (){
              Get.back();
              Get.back();
              getAllContacts();
            }
            );
          } on DatabaseException catch (e) {
           if(e.isUniqueConstraintError()){
            return CustomDialogs.customDialogAuth(
            title: 'Falha no cadastro', 
            subtitle: 'CPF já cadastrado para um contato',
            context: context
            );
           }else{
            return CustomDialogs.customDialogAuth(
            title: 'Erro desconhecido', 
            subtitle: e.toString(),
            context: context
            );
           }
          }
        }else{
          return CustomDialogs.customDialogAuth(
          title: 'CPF inválido!', 
          subtitle: 'Digite um CPF válido!',
          context: context,
        );
        }
      }
    }

    getAllContacts() async {
      List<ContactModel> result = await _dataBase.getAllContacts();
      if(result.isNotEmpty){
        listContacts.value = result.obs;
        result.forEach((element) async {
          markers.add(Marker(markerId: MarkerId(element.nome!),
          position: LatLng(double.parse(element.latitude.toString()), double.parse(element.longitude.toString())),
          onTap: (){},
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              size: Size.fromHeight(10)
            ),
            element.sexo == 'M' ? 'assets/icons/male.png' : 'assets/icons/female.png'
          )
          ));
        });
        clearInputs();
      }
    }

    getContactByCpfOrEmail({required String search}) async {
    List<ContactModel> result = await _dataBase.getContactsByCpfOrName(search: search);
    if(result.isNotEmpty){
      listContacts.value = result.obs;
    }
  }

   getNameResumed({required String nome}) async {
      List fullName = nome.split(' ');
      if(fullName.length >= 2){
        nameResumed.value = '${fullName[0].toLowerCase()}_${fullName[1].substring(0,1).toLowerCase()}';
      }else{
        nameResumed.value = fullName[0].toLowerCase();
      }
    }

    getAdressByCep({required BuildContext context}) async {
      if(cepController.text.isNotEmpty){
        isLoading.value = true;
     try {
      url.value = connection.options.baseUrl;
      Response result = await connection.get('${url+'/'}${cepController.text}/json');
      adressModel = AdressModel.fromJson(result.data);
      isLoading.value = false;
      if(adressModel.uf != null){
        enderecoController.text = adressModel.logradouro.toString();
        complementoController.text = adressModel.complemento.toString();
        ufController.text = adressModel.uf.toString();
      }else{
         enderecoController.clear();
         complementoController.clear();
         ufController.clear();
         return CustomDialogs.customDialogAuth(
          title: 'Falha ao buscar endereço', 
          subtitle: 'Endereço não encontrado.',
          context: context
          );
      }
     } on DioError catch (e) {
         isLoading.value = false;
         return CustomDialogs.customDialogAuth(
          title: 'Falha ao buscar endereço', 
          subtitle: e.message.toString(),
          context: context);
     }
      }else{
         return CustomDialogs.customDialogAuth(
          title: 'Campo inválido', 
          subtitle: 'Preencha o cep corretamente',
          context: context);
      }
    }

    populateInputs({required ContactModel model, required BuildContext context}){
      id.value = int.parse(model.id.toString());
      nomeController.text = model.nome.toString();
      cpfController.text = model.cpf.toString();
      sexoController.text = model.sexo.toString();
      phoneController.text = model.telefone.toString();
      cepController.text = model.cep.toString();
      enderecoController.text = model.endereco.toString();
      complementoController.text = model.complemento.toString();
      ufController.text = model.uf.toString();
      latitudeController.text = model.latitude!.isEmpty ? '' : model.latitude.toString();
      longitudeController.text =  model.longitude!.isEmpty ? '' : model.longitude.toString();
    }

    editContact({required BuildContext context}) async {
      isEditing.value = true;
       if(nomeController.text.isEmpty || cpfController.text.isEmpty || 
         phoneController.text.isEmpty || cepController.text.isEmpty || sexoController.text.isEmpty ||
         latitudeController.text.isEmpty || longitudeController.text.isEmpty){
         return CustomDialogs.customDialogAuth(
          title: 'Verifique os campos', 
          subtitle: 'Preencha todos os campos corretamente.',
          context: context,
        );
      }
      else{
        if(CPFValidator.isValid(cpfController.text)){
          try {
            ContactModel model = ContactModel();
            model.id = id.toInt();
            model.nome = nomeController.text;
            model.cpf= cpfController.text;
            model.sexo = sexoController.text;
            model.telefone = phoneController.text;
            model.cep = cepController.text;
            model.endereco = enderecoController.text;
            model.complemento = complementoController.text;
            model.uf = ufController.text;
            model.latitude = latitudeController.text;
            model.longitude = longitudeController.text;
            await _dataBase.updateContact(model: model);
            return CustomDialogs.customDialogAuth(
            title: 'Sucesso', 
            subtitle: 'Contato atualizado com sucesso.',
            context: context,
            onPressed: (){
              Get.back();
              Get.back();
              getAllContacts();
            }
            );
          } on DatabaseException catch (e) {
           if(e.isUniqueConstraintError()){
            return CustomDialogs.customDialogAuth(
            title: 'Falha no cadastro', 
            subtitle: 'CPF já cadastrado para um contato',
            context: context
            );
           }else{
            return CustomDialogs.customDialogAuth(
            title: 'Erro desconhecido', 
            subtitle: e.toString(),
            context: context
            );
           }
          }
        }else{
          return CustomDialogs.customDialogAuth(
          title: 'CPF inválido!', 
          subtitle: 'Digite um CPF válido!',
          context: context,
        );
        }
      }
    }

    deleteContact({required BuildContext context}) async {
      try {
        ContactModel model = ContactModel();
        model.id = id.toInt();
        await _dataBase.deleteontact(model: model);
        return CustomDialogs.customDialogAuth(
        title: 'Sucesso', 
        subtitle: 'Contato excluido com sucesso.',
        context: context,
        onPressed: (){
          Get.back();
          Get.back();
          getAllContacts();
          clearInputs();
        }
        );
      } on DatabaseException catch (e) {
        if(e.isUniqueConstraintError()){
        return CustomDialogs.customDialogAuth(
        title: 'Falha na exclusão', 
        subtitle: 'CPF já removido.',
        context: context
        );
        }else{
        return CustomDialogs.customDialogAuth(
        title: 'Erro desconhecido', 
        subtitle: e.toString(),
        context: context
        );
        }
      }
    }

    clearInputs(){
      nomeController.clear();
      cpfController.clear();
      sexoController.text = 'M';
      phoneController.clear();
      cepController.clear();
      enderecoController.clear();
      complementoController.clear();
      latitudeController.clear();
      longitudeController.clear();
      ufController.clear();
    }

    loadContactsMarker() async {

      var contacts = await getAllContacts();

      log(contacts.toString());

    }


}