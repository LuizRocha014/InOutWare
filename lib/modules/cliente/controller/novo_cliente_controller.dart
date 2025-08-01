import 'package:flutter_app/base/models/smartStorege/Customer/costumer.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/icostumer_repository.dart';
import 'package:flutter_app/base/service/interface/iuser_service.dart';
import 'package:flutter_app/modules/cliente/controller/cliente_controller.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:uuid/uuid.dart';

class NovoClienteControlle extends BaseController {
  final PageController pageController = PageController();
  late RxString _textButton;
  late TextEditingController controllerNome;
  late TextEditingController controllerCnpjCpf;
  late TextEditingController controllerEmail;
  late TextEditingController controllerTelefone;
  late TextEditingController controllerDataNascimento;
  late TextEditingController controllerCep;
  late TextEditingController controllerEndereco;
  late TextEditingController controllerBairro;
  late TextEditingController controllerPontoReferencia;
  late TextEditingController controlleraddressNumber;
  @override
  void iniciaControlador() {
    _textButton = 'PROXIMO'.obs;
    controllerNome = TextEditingController();
    controllerCnpjCpf = TextEditingController();
    controllerEmail = TextEditingController();
    controllerTelefone = TextEditingController();
    controllerDataNascimento = TextEditingController();
    controllerCep = TextEditingController();
    controllerEndereco = TextEditingController();
    controllerBairro = TextEditingController();
    controllerPontoReferencia = TextEditingController();
    controlleraddressNumber = TextEditingController();
  }

  String get textButton => _textButton.value;

  Future<void> buttonVoltar() async {
    if (pageController.page == 1) {
      pageController.animateToPage(
        -1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _textButton.value = 'PROXIMO';
      _textButton.refresh();
    } else {
      context.pop();
    }
  }

  Future<void> goToPage(int value) async {
    if (value == 1 && _textButton.contains('SALVAR')) {
      createObj();
    } else {
      switch (value) {
        case 1:
          pageController.animateToPage(
            value + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          _textButton.value = 'SALVAR';
          _textButton.refresh();
          break;
      }
    }
  }

  void carregaCep(String cep) async {
    final endereco = await instanceManager.get<IUserService>().carregaCep(cep);
    if (endereco != null) {
      controllerBairro.text = endereco.bairro;
      controllerEndereco.text = endereco.logradouro;
    }
  }

  Future<void> createObj() async {
    try {
      final clienteId = const Uuid().v4();
      final cliente = Costumer(
          id: clienteId,
          nome: controllerNome.text,
          cnpj: controllerCnpjCpf.text,
          email: controllerEmail.text,
          addressNumber: controlleraddressNumber.text,
          address: controllerEndereco.text,
          zipCode: controllerCep.text,
          phone: controllerTelefone.text,
          sync: false,
          createdAt: DateTime.now(),
          active: true,
          shopId: shopUser.id);
      // final shopCostumer = ShopCostumer(
      //     id: const Uuid().v4(),
      //     sync: false,
      //     createdAt: DateTime.now(),
      //     active: true,
      //     customerId: clienteId,
      //     shopId: shopUser.shopId);

      await instanceManager
          .get<ICostumerRepository>()
          .createOrReplace(cliente.toJson());
      // await instanceManager
      //     .get<IShopCostumerRepository>()
      //     .createOrReplace(shopCostumer.toJson());
      instanceManager.get<ClienteController>().carregaDados();
      // ignore: use_build_context_synchronously
      context.pop();
    } catch (_) {}
  }
}
