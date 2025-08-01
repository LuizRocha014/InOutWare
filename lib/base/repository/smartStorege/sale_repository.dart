import 'dart:convert';

import 'package:flutter_app/base/models/smartStorege/Customer/costumer.dart';
import 'package:flutter_app/base/models/smartStorege/File/file.dart';
import 'package:flutter_app/base/models/smartStorege/ProductFile/product_file.dart';
import 'package:flutter_app/base/models/smartStorege/Transaction/transaction.dart';
import 'package:flutter_app/base/models/smartStorege/product/product.dart';
import 'package:flutter_app/base/models/smartStorege/venda/sale.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/isale_repository.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:componentes_lr/componentes_lr.dart';

class SaleRepository extends BaseRepository<Sale> implements ISaleRepository {
  SaleRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<String> getValortotalVendas() async {
    try {
      final query = '''
        SELECT SUM(S.VALOR) as Valor FROM ${infosTableDatabase.tableName} s
                      ''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return "0";
      //return entity.
      final retorn = entity.first['Valor'].toString();
      return retorn.contains("null") ? "0" : retorn;
    } catch (_) {
      return "0";
    }
  }

  @override
  Future<List<Sale>> getVendas() async {
    final query = ''' SELECT  c.cnpj, s.* FROM ${infosTableDatabase.tableName} s
                      JOIN ${Transactions.table.tableName} t on t.SaleId = s.id
                      JOIN ${Costumer.table.tableName} c on t.CustomerId = c.id
                      WHERE C.SHOPID = '${shopUser.id}'
                      group by s.id
                      ORDER BY S.createdAt DESC
                      ''';
    final entity = await context.rawQuery(query);
    if (entity.isEmpty) return [];
    //return entity.
    final returo = entity.map((e) => Sale.fromJson(e)).toList();
    return returo;
  }

  @override
  Future<List<Product>> getProduct(String saleId) async {
    final query = ''' SELECT P.*, 
                      f.base64Arquiv as base64Image,
                      T.numberProd AS numbProduct FROM ${infosTableDatabase.tableName} s
                      JOIN ${Transactions.table.tableName} t on t.SaleId = s.id
                      JOIN ${Product.table.tableName} P ON T.ProductId = P.ID
                      LEFT JOIN ${ProductFile.table.tableName} PDF ON PDF.productId = P.ID
                      LEFT JOIN ${FileIMG.table.tableName} F ON PDF.fileId = F.ID
                      WHERE S.ID = '$saleId'
                      ORDER BY S.createdAt DESC
                      ''';
    final entity = await context.rawQuery(query);
    if (entity.isEmpty) return [];
    //return entity.
    final returo = entity.map((e) => Product.fromJson(e)).toList();

    for (var e in returo) {
      if (e.base64Image != null) {
        e.image = base64Decode(e.base64Image!);
      }
    }
    Future.delayed(const Duration(seconds: 2));
    return returo;
  }

  @override
  Future<List<Sale>> getItensAsync() async {
    try {
      final query = '''SELECT * FROM ${Sale.table.tableName} WHERE Sync = 0''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return [];
      final entityList = entity.map((e) => Sale.fromJson(e)).toList();
      return entityList;
    } catch (_) {
      return [];
    }
  }
}
