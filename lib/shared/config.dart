import 'dart:convert';

import 'package:my_contacts_view/modules/auth/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigStorageController {

 static saveAuthStorage({required AuthModel model}) async {
    final authShared = await SharedPreferences.getInstance();
    authShared.setString('authStorage', json.encode(model));
  }

 static getAuthStorage() async {
    final authShared = await SharedPreferences.getInstance();
    return AuthModel.fromJson(json.decode(authShared.getString('authStorage')!));
  }

 static logoutAuthStorage() async {
   final authShared = await SharedPreferences.getInstance(); 
   await authShared.clear();
 }

}