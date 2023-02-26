// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

class CustomCards {

 static customCardStatusContacts({required BuildContext context, required Widget container}){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
      color: Colors.white,
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 173, 173, 173),
            offset: Offset(1,5),
            blurRadius: 2,
            spreadRadius: 0
          )
        ]
      ),
      child: container,
    );
  }

}