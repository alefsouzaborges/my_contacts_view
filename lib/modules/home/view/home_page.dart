// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:my_contacts_view/modules/auth/controller/auth_controller.dart';
import 'package:my_contacts_view/modules/contacts/controller/register_contacts_controller.dart';
import 'package:my_contacts_view/modules/contacts/view/registerContacts.dart';
import 'package:my_contacts_view/modules/maps/controller/maps_controller.dart';
import 'package:my_contacts_view/modules/perfil/view/perfil_view.dart';
import 'package:my_contacts_view/shared/config.dart';
import 'package:my_contacts_view/utils/colors/customColors.dart';
import 'package:my_contacts_view/utils/enumerations/enumerations.dart';
import 'package:my_contacts_view/utils/permissions/permission.dart';
import 'package:my_contacts_view/widgets/appbar/customAppBar.dart';
import 'package:my_contacts_view/widgets/avatar/customAvatar.dart';
import 'package:my_contacts_view/widgets/cards/customCards.dart';
import 'package:my_contacts_view/widgets/text/customText.dart';

import '../../../widgets/dialogs/customDialogs.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  final _authController = Get.put(AuthController());
  final _registerController = Get.put(RegisterContactsController());
  MapsController _mapsController = Get.put(MapsController());

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.white,
          ),
          elevation: 0,
        ),
        floatingActionButton: _floatinActionButton(context: context),
        body: Column(
          children: [
            Obx(() => CustomAppBar.customAppBarSearch(
                context: context,
                onChanged: (e) {
                  _registerController.getContactByCpfOrEmail(
                      search: e.toString());
                })),
            CustomCards.customCardStatusContacts(
                context: context,
                container: Obx(() {
                  return _registerController.listContacts.isEmpty
                      ? Row(
                          children: [
                            Lottie.asset('assets/animations/add_user.json'),
                            CustomText.customTextAppBar(
                                text: 'Sem nenhum contato.')
                          ],
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _registerController.listContacts.length,
                          itemBuilder: (context, index) {
                            _registerController.getNameResumed(
                                nome: _registerController
                                    .listContacts[index].nome
                                    .toString());
                            return Container(
                                padding: EdgeInsets.all(5),
                                width: 80,
                                child: CustomAvatar.customAvatarStatus(
                                    context: context,
                                    image: _registerController
                                                .listContacts[index].sexo ==
                                            'M'
                                        ? 'assets/icons/male.png'
                                        : 'assets/icons/female.png',
                                    nome: _registerController.nameResumed
                                        .toString(),
                                    onTap: () async {
                                      _mapsController.mapController.animateCamera(CameraUpdate.newLatLng(LatLng(double.parse(_registerController.listContacts[index].latitude.toString()), double.parse(_registerController.listContacts[index].longitude.toString()))));
                                      await _animationController!.forward();
                                      _registerController.isEditing.value = true;
                                      await _registerController.populateInputs(
                                          model: _registerController
                                              .listContacts[index],
                                          context: context);
                                    }));
                          },
                        );
                })),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: Obx(() {
                    return GoogleMap(
                      myLocationEnabled: true,
                      compassEnabled: true,
                      buildingsEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _mapsController.latitude.value,
                            _mapsController.longitude.value),
                          zoom: 18),
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          onMapCreated: onMapCreate
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }

  _floatinActionButton({required BuildContext context}) {
    return Obx(() {
      return FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "Logout",
            iconColor: Colors.white,
            bubbleColor: CustomColors.PRIMARYCOLOR,
            icon: Icons.exit_to_app,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () async {
              await CustomDialogs.customDialogConfirm(
                  title: 'Realizar logout?',
                  subtitle: 'Tem certeza de que deseja sair do sistema?.',
                  context: context,
                  onPressedConfirm: () async {
                    await ConfigStorageController.logoutAuthStorage();
                    await _animationController!.reverse();
                    _authController.clearInputs();
                    Get.back();
                    Get.back();
                  });
            },
          ),
          Bubble(
            title: "Perfil",
            iconColor: Colors.white,
            bubbleColor: CustomColors.PRIMARYCOLOR,
            icon: Icons.account_circle,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () async {
              await _animationController!.reverse();
              Get.to(() => PerfilPage());
            },
          ),
          Bubble(
            title:
                _registerController.isEditing.value ? "Atualizar" : "Adicionar",
            iconColor: Colors.white,
            bubbleColor: CustomColors.PRIMARYCOLOR,
            icon:
                _registerController.isEditing.value ? Icons.edit : Icons.people,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () async {
              await _animationController!.reverse();
              if (_registerController.isEditing.value) {
                Get.to(() => RegisterContactsPage());
              } else {
                _registerController.clearInputs();
                Get.to(() => RegisterContactsPage());
              }
            },
          ),
        ],
        onPress: () {
          _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward();
          _registerController.isEditing.value = false;
        },
        iconColor: CustomColors.ICONCOLOR,
        iconData: Icons.menu,
        backGroundColor: Colors.white,
        animation: _animation!,
      );
    });
  }

  onMapCreate(GoogleMapController gmc) async {
    _mapsController.mapController = gmc;
    _mapsController.getPosition(context: context);
  }
}
