import 'package:permission_handler/permission_handler.dart';

class ContactUtil{
  // check contacts permission
  static Future<PermissionStatus> getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts];
    } else {
      return permission;
    }
  }
}