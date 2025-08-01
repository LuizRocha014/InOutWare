import 'package:flutter_app/base/models/smartStorege/userPermission/user_permission.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/iuser_permission_repository.dart';
import 'package:flutter_app/base/service/base_service.dart';
import 'package:flutter_app/base/service/interface/iuser_permission_service.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPermissionService extends BaseService
    implements IUserPermissionService {
  @override
  Future<List<UserPermission>> getAll({bool alteracaoNula = false}) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String urlApi = "$url/api/UserPermission/GetAll";
      final ultimaData =
          sharedPreferences.getString("UserPermissionUltimaData") ?? "";
      final retorno = await get(urlApi,
          query: {'userId': loggerUser.id, 'ultData': ultimaData});
      if (temErroRequisicao(retorno)) throw Exception();
      final list = (retorno.body as List)
          .map((e) => UserPermission.fromJson(e as Map<String, dynamic>))
          .toList();
      await instanceManager
          .get<IUserPermissionRepository>()
          .createList(list.map((e) => e.toJson()));
      sharedPreferences.setString(
          "UserPermissionUltimaData", "${DateTime.now()}");
      return list;
    } catch (_) {
      return [];
    }
  }
}
