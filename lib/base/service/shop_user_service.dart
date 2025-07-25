import 'package:flutter_app/base/models/smartStorege/ShopUser/shop_user.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ishop_user_repository.dart';
import 'package:flutter_app/base/service/base_service.dart';
import 'package:flutter_app/base/service/interface/ishop_user_service.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/utils/utils_exports.dart';

class ShopUserService extends BaseService implements IShopUserService {
  @override
  Future<List<ShopUser>> getAll({bool alteracaoNula = false}) async {
    try {
      List<ShopUser> list = [];
      final repository = instanceManager.get<IShopUserRepository>();
      final String urlApi = "$url/api/ShopUser/GetAllId";
      final retorno = await get(urlApi, query: {'userId': loggerUser.id});
      if (retorno.body == null) return throw Expando();
      var category = (retorno.body as List).map((e) => ShopUser.fromJson(e));
      list.addAll(category);
      await repository.createList(list.map((e) => e.toJson()));
      return list;
    } catch (_) {
      return [];
    }
  }
}
