import 'package:flutter_app/base/models/smartStorege/Customer/costumer.dart';
import 'package:flutter_app/base/models/smartStorege/File/file.dart';
import 'package:flutter_app/base/models/smartStorege/ProductFile/product_file.dart';
import 'package:flutter_app/base/models/smartStorege/Shop/shop.dart';
import 'package:flutter_app/base/models/smartStorege/ShopProduct/shop_product.dart';
import 'package:flutter_app/base/models/smartStorege/ShopUser/shop_user.dart';
import 'package:flutter_app/base/models/smartStorege/Transaction/transaction.dart';
import 'package:flutter_app/base/models/smartStorege/category/category.dart';
import 'package:flutter_app/base/models/smartStorege/permission/permission.dart';
import 'package:flutter_app/base/models/smartStorege/product/product.dart';
import 'package:flutter_app/base/models/smartStorege/shopCustomer/shop_costumer.dart';
import 'package:flutter_app/base/models/smartStorege/user/user.dart';
import 'package:flutter_app/base/models/smartStorege/userPermission/user_permission.dart';
import 'package:flutter_app/base/models/smartStorege/venda/sale.dart';
import 'package:componentes_lr/componentes_lr.dart';

class AppContext extends Context {
  AppContext()
      : super.nonFactoryConstructor(
          nameDatabase: _nameDatabase,
          version: _version,
          tables: _tables,
        );
  static String get _nameDatabase => "App_estoque";
  static int get _version => 1;
  static List<InfosTableDatabase> get _tables => [
        User.table,
        UserPermission.table,
        Permission.table,
        Category.table,
        Product.table,
        ShopUser.table,
        ShopProduct.table,
        Shop.table,
        FileIMG.table,
        ProductFile.table,
        ShopCostumer.table,
        Costumer.table,
        Sale.table,
        Transactions.table
      ];
}
