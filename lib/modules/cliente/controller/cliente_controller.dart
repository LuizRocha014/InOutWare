import 'package:flutter_app/base/models/smartStorege/Customer/costumer.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/icostumer_repository.dart';
import 'package:flutter_app/base/service/interface/icostumer_service.dart';
import 'package:flutter_app/modules/cliente/page/novo_cliente_page.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ClienteController extends BaseController {
  late RxList<Costumer> listCostumer;
  late Costumer? selectCostumer;
  @override
  void iniciaControlador() {
    selectCostumer = null;
    listCostumer = RxList();
    carregaDados();
  }

  Future<void> carregaDados() async {
    try {
      isLoading = true;
      await instanceManager.get<ICostumerService>().getAll();
      listCostumer.value =
          await instanceManager.get<ICostumerRepository>().getCostumers();
      listCostumer.refresh();
    } catch (_) {
    } finally {
      isLoading = false;
    }
  }

  void novoCliente() {
    try {
      context.push(const NovoClientePage());
    } catch (_) {}
  }

  void selectItem(Costumer item) {
    try {
      context.pop(item);
    } catch (_) {}
  }
}
