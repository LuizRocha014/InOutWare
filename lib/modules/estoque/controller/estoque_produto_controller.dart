import 'package:flutter_app/base/models/dto/product_dto/product_dto.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/iproduct_repository.dart';
import 'package:flutter_app/base/service/interface/iproduct_service.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:get/get.dart';

class EstoqueProdutoController extends BaseController {
  late RxList<ProdutctDto> _listProdutos;
  @override
  Future<void> iniciaControlador() async {
    _listProdutos = RxList();
    carregaDados();
  }

  Future<void> carregaDados() async {
    try {
      instanceManager.get<IProductService>().getAll();
      isLoading = true;
      await instanceManager
          .get<IProductRepository>()
          .getProdutos()
          .then(_listProdutos.call);
    } catch (_) {
    } finally {
      isLoading = false;
    }
  }

  List<ProdutctDto> get produtosEstoque => _listProdutos;
}
