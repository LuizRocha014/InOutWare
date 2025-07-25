import 'package:flutter_app/base/models/smartStorege/ProductFile/product_file.dart';
import 'package:componentes_lr/componentes_lr.dart';

abstract class IProductFileRepository extends IBaseRepository {
  Future<List<ProductFile>> getItensSync();
}
