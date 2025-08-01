import 'package:flutter_app/base/models/smartStorege/permission/permission.dart';
import 'package:flutter_app/base/models/smartStorege/userPermission/user_permission.dart';
import 'package:componentes_lr/componentes_lr.dart';

abstract class IUserPermissionRepository
    extends IBaseRepository<UserPermission> {
  Future<List<Permission>> getPermissionUser();
}
