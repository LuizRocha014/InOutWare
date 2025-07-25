import 'package:flutter_app/base/models/smartStorege/Shop/shop.dart';
import 'package:flutter_app/base/models/smartStorege/ShopUser/shop_user.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ishop_user_repository.dart';

class ShopUserRepository extends BaseRepository<ShopUser>
    implements IShopUserRepository {
  ShopUserRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<Shop> getShopUserId(String userId) async {
    final query = '''SELECT S.* FROM ${ShopUser.table.tableName} US
                    JOIN ${Shop.table.tableName} S ON US.shopId = S.ID
                     WHERE us.USERID = '$userId' and us.userMainShop = 1 ''';
    final entity = await context.rawQuery(query);
    return Shop.fromJson(entity.first);
  }

  @override
  Future<List<Shop>> getShop(String userId) async {
    final query = '''SELECT S.* FROM ${ShopUser.table.tableName} US
                    JOIN ${Shop.table.tableName} S ON US.shopId = S.ID
                     WHERE USERID = '$userId' ''';
    final entity = await context.rawQuery(query);
    final shop = entity.map((e) => Shop.fromJson(e)).toList();
    return shop;
  }
}
