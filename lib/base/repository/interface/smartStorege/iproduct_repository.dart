import 'package:flutter_app/base/models/dto/product_dto/product_dto.dart';
import 'package:flutter_app/base/models/smartStorege/product/product.dart';
import 'package:componentes_lr/componentes_lr.dart';

abstract class IProductRepository extends IBaseRepository<Product> {
  Future<List<ProdutctDto>> getProdutos();
  Future<List<Product>> getItensAsync();
}
