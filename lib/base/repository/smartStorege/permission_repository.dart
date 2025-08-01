import 'package:flutter_app/base/models/smartStorege/permission/permission.dart';
import 'package:flutter_app/base/models/smartStorege/userPermission/user_permission.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ipermission_repository.dart';

class PermissionRepository extends BaseRepository<Permission>
    implements IPermissionRepository {
  PermissionRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<bool> validaAcessoUsuario() async {
    try {
      final query = ''' SELECT p.* FROM ${Permission.table.tableName} P
                JOIN ${UserPermission.table.tableName} UP ON P.ID = UP.AcessoId
                WHERE up.Active = 1''';

      final entity = await context.rawQuery(query);
      if (entity.isNullOrEmpty) return false;
      final retorno = entity.map((e) => Permission.fromJson(e)).toList();
      return retorno.any((e) => e.name.contains("AppPermission"));
    } catch (e) {
      return false;
    }
  }
}
