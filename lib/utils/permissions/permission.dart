import 'package:my_contacts_view/utils/enumerations/enumerations.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{

  static requestPermission({required PermissionType permissionType})async{

    switch(permissionType){
      case PermissionType.CAMERA:
        await Permission.camera.request();
        break;

      case PermissionType.STORAGE:
        await Permission.camera.isDenied;
        await Permission.storage.request();
        break;

      case PermissionType.AUDIO:
        await Permission.microphone.request();
        break;

      case PermissionType.BLUETOOTH:
        await Permission.bluetooth.request();
        break;

      case PermissionType.LOCATION:
        await Permission.location.request();
        break;

      case PermissionType.LOCATION_ALWAYS:
        await Permission.locationAlways.request();
        break;

      case PermissionType.LOCATION_IN_USE:
        await Permission.locationWhenInUse.request();
        break;

      case PermissionType.PHOTOS:
        await Permission.photos.request();
        break;

    }
  }


  static verifyPermission({required PermissionType permissionType})async{
    bool permission = false;
    switch(permissionType){
      case PermissionType.CAMERA:
        permission = await Permission.camera.isGranted;
        break;
      case PermissionType.STORAGE:
        permission = await Permission.storage.isGranted;
        break;
      case PermissionType.AUDIO:
        permission = await Permission.microphone.isGranted;
        break;
      case PermissionType.BLUETOOTH:
        permission = await Permission.bluetooth.isGranted;
        break;
      case PermissionType.LOCATION:
        permission = await Permission.location.isGranted;
        break;
      case PermissionType.LOCATION_ALWAYS:
        permission = await Permission.locationAlways.isGranted;
        break;
      case PermissionType.LOCATION_IN_USE:
        permission = await Permission.locationWhenInUse.isGranted;
        break;
      case PermissionType.PHOTOS:
        permission = await Permission.photos.isGranted;
        break;
    }
    return permission;
  }
}
