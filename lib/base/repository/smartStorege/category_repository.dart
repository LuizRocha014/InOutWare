import 'package:flutter_app/base/models/smartStorege/category/category.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/icategory_repository.dart';

class CategoryRepository extends BaseRepository<Category>
    implements ICategoryRepository {
  CategoryRepository(super.infosTableDatabase, super.fromJson);

  @override
  Future<List<Category>> getAllListCategory() async {
    try {
      final query =
          '''SELECT * FROM ${infosTableDatabase.tableName} order by description asc''';
      final entity = await context.rawQuery(query);
      if (entity.isNullOrEmpty) return <Category>[];
      final list = entity.map((e) => Category.fromJson(e)).toList();
      return list;
    } catch (_) {
      return [];
    }
  }
}
