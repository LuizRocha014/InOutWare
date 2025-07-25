import 'package:flutter_app/base/models/smartStorege/category/category.dart';
import 'package:componentes_lr/componentes_lr.dart';

abstract class ICategoryRepository extends IBaseRepository<Category> {
  Future<List<Category>> getAllListCategory();
}
