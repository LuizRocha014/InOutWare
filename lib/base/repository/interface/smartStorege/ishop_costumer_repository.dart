import 'package:flutter_app/base/models/smartStorege/shopCustomer/shop_costumer.dart';
import 'package:componentes_lr/componentes_lr.dart';

abstract class IShopCostumerRepository extends IBaseRepository<ShopCostumer> {
  Future<List<ShopCostumer>> getShopCustomerSync();
}
