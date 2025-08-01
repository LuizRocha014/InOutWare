import 'package:flutter_app/base/models/smartStorege/permission/permission.dart';
import 'package:flutter_app/base/models/smartStorege/userPermission/user_permission.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/iuser_permission_repository.dart';

class UserPermissionRepository extends BaseRepository<UserPermission>
    implements IUserPermissionRepository {
  UserPermissionRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<List<Permission>> getPermissionUser() async {
    try {
      final query =
          '''SELECT Permission.* FROM ${UserPermission.table.tableName} UserPermission
                    JOIN ${Permission.table.tableName} Permission ON  UserPermission.acessoId = Permission.id''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return [];
      final entityRetorno = entity.map((e) => Permission.fromJson(e)).toList();

      return entityRetorno;
    } catch (_) {
      return [];
    }
  }
}
