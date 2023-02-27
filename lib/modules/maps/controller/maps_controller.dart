import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/dialogs/customDialogs.dart';

class MapsController extends GetxController {

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  late GoogleMapController mapController;

  Future<Position> _positionActual({required BuildContext context}) async {
      LocationPermission permissao;
      bool ativado = await Geolocator.isLocationServiceEnabled();

      if(!ativado){
         return CustomDialogs.customDialogAuth(
          title: 'Localização desativada', 
          subtitle: 'Por favor habilite a localização no seu smartphone.',
          context: context
          );
      }

      permissao = await  Geolocator.checkPermission();
      if(permissao == LocationPermission.denied){
        permissao = await Geolocator.requestPermission();

        if(permissao == LocationPermission.denied){
          return CustomDialogs.customDialogAuth(
          title: 'Localização desativada', 
          subtitle: 'Por favor habilite a localização no seu dispositivo.',
          context: context
          );
      }
      }
      
      if(permissao == LocationPermission.deniedForever){
         return CustomDialogs.customDialogAuth(
          title: 'Localização desativada', 
          subtitle: 'Por favor autorize o acesso a localização na configuração do dispositivo',
          context: context
          );
      }
      return await Geolocator.getCurrentPosition();
    }

 Future getPosition({required BuildContext context}) async {
    try {
      final posicao = await _positionActual(context: context);
      latitude.value = posicao.latitude;
      longitude.value = posicao.longitude;
      mapController.animateCamera(CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
    } catch (e) {
        return CustomDialogs.customDialogAuth(
        title: 'Erro desconhecido', 
        subtitle: e.toString(),
        context: context
        );
    }
    }



}