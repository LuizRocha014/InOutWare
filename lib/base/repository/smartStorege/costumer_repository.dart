import 'package:flutter_app/base/models/smartStorege/Customer/costumer.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/icostumer_repository.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:componentes_lr/componentes_lr.dart';

class CostumerRepository extends BaseRepository<Costumer>
    implements ICostumerRepository {
  CostumerRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<List<Costumer>> getCostumers() async {
    try {
      final query = '''SELECT * FROM ${Costumer.table.tableName} 
                        WHERE SHOPID = '${shopUser.id}' and active = 1
                        ORDER BY nome ASC''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return [];
      final listEntity = entity.map((e) => Costumer.fromJson(e)).toList();
      return listEntity;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<Costumer>> getCustomerSync() async {
    try {
      final query = '''SELECT * FROM ${Costumer.table.tableName}
                        WHERE Sync = 0''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return [];
      final listEntity = entity.map((e) => Costumer.fromJson(e)).toList();
      return listEntity;
    } catch (_) {
      return [];
    }
  }
}
