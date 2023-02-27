// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

class CustomAvatar {

  static customAvatarStatus({required BuildContext context, required String image, required String nome, required Function() onTap}){
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundColor: CustomColors.PRIMARYCOLOR,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                color: CustomColors.SECUNDARYCOLOR,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Image.asset(image),
              )
            ),
          ),
          Expanded(child: CustomText.customTextAppBar(text: nome, fontSize: 15))
        ],
      ),
    );
  }

}