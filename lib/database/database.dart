// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_contacts_view/modules/auth/model/auth_model.dart';
import 'package:my_contacts_view/modules/contacts/model/contact_model.dart';
import 'package:path/path.dart'; //used to join paths
import 'dart:async';

import 'package:sqflite/sqflite.dart';



class DatabaseLocal {
  Database? database;
  var databasesPath;

  Future init() async {
    databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'databaseLocal.db');
    // open the database
    database = await openDatabase(path, version: 1, onCreate: _oncreate);
    return database;
  }

  _oncreate(Database db, int version) async {
    
    log('Banco de dados criado');
    List<String> tables = [
      'CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY, nome TEXT, email TEXT unique, senha TEXT)',
      'CREATE TABLE IF NOT EXISTS contatos (id INTEGER PRIMARY KEY, nome TEXT, cpf TEXT unique, sexo TEXT, telefone TEXT, cep TEXT, endereco TEXT, uf TEXT ,complemento TEXT, latitude TEXT, longitude TEXT)',
     // 'CREATE TABLE IF NOT EXISTS auditoria_itens (id INTEGER PRIMARY KEY, codbarras TEXT, qtde TEXT, id_auditoria INTEGER, auditoria_cega TEXT)'
    ];
    for (String table in tables) {
      await db.execute(table);
    }
  }

  Future auth({required AuthModel model}) async {
    RxList data = RxList();
    await init();
    await database!.transaction((txn) async {
      await txn
          .rawQuery("SELECT * FROM usuarios where email = ? and senha = ?", [
            model.email, 
            model.senha
          ])
          .then((value) => {data = value.obs});
    });
    return data.map((e) => AuthModel.fromJson(e)).toList();
  }

  Future signUp({required AuthModel model}) async {
    await init();
   try {
      RxList data = RxList();
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO usuarios(nome, email, senha) VALUES(?,?,?)', [
        model.nome,
        model.email,
        model.senha
       ]).then((value) => {
       });
    });
   } on DatabaseException catch (e) {
    throw e;
   }
  }

  Future deleteAccount() async {
    await init();
   try {
      RxList data = RxList();
    await database!.transaction((txn) async {
      await txn.rawInsert('DELETE FROM usuarios', [
       ]).then((value) => {
        log(value.toString()),
       });
    });
   } on DatabaseException catch (e) {
    throw e;
   }
  }

  Future addContact({required ContactModel model}) async {
    await init();
   try {
    RxList data = RxList();
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO contatos(nome, cpf, sexo, telefone, cep, endereco, uf, complemento, latitude, longitude) VALUES(?,?,?,?,?,?,?,?,?,?)', [
        model.nome,
        model.cpf,
        model.sexo,
        model.telefone,
        model.cep,
        model.endereco,
        model.uf,
        model.complemento,
        model.latitude,
        model.longitude
        ]).then((value) => {
        getAllContacts()
       });
    });
   } on DatabaseException catch (e) {
    throw e;
   }
  }

   Future updateContact({required ContactModel model}) async {
    await init();
   try {
    RxList data = RxList();
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'UPDATE contatos SET nome = ?, cpf = ?, sexo = ?, telefone = ?, cep = ?, endereco = ?, uf = ?, complemento = ?,latitude = ?, longitude = ? WHERE id = ?', [
        model.nome,
        model.cpf,
        model.sexo,
        model.telefone,
        model.cep,
        model.endereco,
        model.uf,
        model.complemento,
        model.latitude,
        model.longitude,
        model.id
        ]).then((value) => {
        getAllContacts()
       });
    });
   } on DatabaseException catch (e) {
    throw e;
   }
  }

  Future deleteontact({required ContactModel model}) async {
    await init();
   try {
    RxList data = RxList();
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'DELETE FROM contatos WHERE id = ?', [
        model.id
        ]).then((value) => {
        getAllContacts()
       });
    });
   } on DatabaseException catch (e) {
    throw e;
   }
  }

  Future getAllContacts() async {
   try {
      RxList data = RxList();
    await init();
    await database!.transaction((txn) async {
      await txn.rawQuery("SELECT * FROM contatos")
          .then((value) => {data = value.obs});
    });
    return data.map((e) => ContactModel.fromJson(e)).toList();
   } catch (e) {
     throw ContactModel();
   }
  }

  Future getContactsByCpfOrName({required String search}) async {
   try {
    RxList data = RxList();
    await init();
    await database!.transaction((txn) async {
      await txn.rawQuery("SELECT * FROM contatos WHERE nome like '%$search%';")
          .then((value) => {data = value.obs});
    });
    return data.map((e) => ContactModel.fromJson(e)).toList();
   } catch (e) {
     throw ContactModel();
   }
  }

}
