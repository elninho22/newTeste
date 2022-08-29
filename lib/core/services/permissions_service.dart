import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<PermissionStatus> requestPermission(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      return PermissionStatus.permanentlyDenied;
    }

    if (permissionStatus.isDenied) {
      permissionStatus = await permission.request();

      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        return PermissionStatus.permanentlyDenied;
      }

      return permissionStatus;
    }

    return PermissionStatus.granted;
  }

  Future openAppSettings() async {
    await openAppSettings();
  }

  Future<bool> readPermisssions() async {
    try {
      return (await Permission.camera.isGranted) &&
          (await Permission.location.isGranted);
    } catch (e) {
      rethrow;
    }
  }
}
