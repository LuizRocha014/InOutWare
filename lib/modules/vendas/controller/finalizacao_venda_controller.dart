import 'dart:math';

import 'package:flutter_app/base/models/smartStorege/Transaction/transaction.dart';
import 'package:flutter_app/base/models/smartStorege/product/product.dart';
import 'package:flutter_app/base/models/smartStorege/venda/sale.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/iproduct_repository.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/isale_repository.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/itransaction_repository.dart';
import 'package:flutter_app/base/service/interface/iproduct_service.dart';
import 'package:flutter_app/modules/menu/pages/home_page.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/modules/vendas/controller/nova_venda_controller.dart';
import 'package:flutter_app/modules/vendas/controller/select_itens_list_controller.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/default_popup.dart';
import 'package:flutter_app/utils/enuns.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:uuid/uuid.dart';

class FinalizacaoVendaController extends BaseController {
  late RxList<Product> listProdutosSelecionados;
  late bool resume;
  late RxString valorCompra;
  late String? saleId;
  late TextEditingController valorDesconto;
  late Rx<TipoPagamento> tipoPagamentoSelect;
  @override
  void iniciaControlador() async {
    valorCompra = RxString("0");
    listProdutosSelecionados = RxList();
    tipoPagamentoSelect = Rx<TipoPagamento>(TipoPagamento.pix);
    valorDesconto = TextEditingController(text: "");
    if (!resume) {
      final controller = instanceManager.get<SelectItensController>();
      listProdutosSelecionados = RxList(controller.itemSelecionado);
      tipoPagamentoSelect = Rx<TipoPagamento>(TipoPagamento.pix);
    } else {
      listProdutosSelecionados.value =
          await instanceManager.get<ISaleRepository>().getProduct(saleId!);
      final venda =
          await instanceManager.get<ISaleRepository>().getById(saleId!);
      tipoPagamentoSelect.value = venda!.tipoPagamento;
      listProdutosSelecionados.refresh();
      tipoPagamentoSelect.refresh();
    }
    calculaValoCompra();
  }

  FinalizacaoVendaController({this.resume = false, this.saleId});
  void adicionaItemCompra(int index) {
    try {
      if (!resume) {
        final item = listProdutosSelecionados[index];
        item.numbProduct++;
        calculaValoCompra();
        listProdutosSelecionados.refresh();
      }
    } catch (_) {}
  }

  void removeItemCompra(int index) {
    try {
      if (!resume) {
        final item = listProdutosSelecionados[index];
        if (item.numbProduct > 0) {
          item.numbProduct--;
        } else if (item.numbProduct == 0) {
          removeItem(listProdutosSelecionados[index]);
        }
        calculaValoCompra();
        listProdutosSelecionados.refresh();
      }
    } catch (_) {}
  }

  void calculaValoCompra() {
    try {
      valorCompra.value = "0";
      for (var element in listProdutosSelecionados) {
        final valor = (element.numbProduct * element.price!);
        valorCompra.value =
            (double.parse(valorCompra.string) + valor).toString();
      }

      valorCompra.refresh();
    } catch (_) {}
  }

  void removeItem(Product item) {
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: branco,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.h), topRight: Radius.circular(2.h))),
        width: double.infinity,
        height: 24.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025),
                child: TextWidget(
                  "Atenção !",
                  fontSize: font_18,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: const TextWidget("Deseja mesmo remover este item?"),
              ),
              const Spacer(),
              ButtonWidget(
                onPressed: () => Navigator.pop(context),
                borderRadius: 2.h,
                title: "CANCELAR",
                borderColor: primaryColor,
                color: branco,
                fontColor: primaryColor,
              ),
              ButtonWidget(
                onPressed: () {
                  listProdutosSelecionados.remove(item);
                  context.pop();
                },
                borderRadius: 2.h,
                title: "CONFIRMAR",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void inserirDesconto() {
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: branco,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.h), topRight: Radius.circular(2.h))),
        width: double.infinity,
        height: 27.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025),
                child: TextWidget(
                  "Insira o desconto desejado",
                  fontSize: font_18,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: TextFieldWidget(
                      controller: valorDesconto,
                      internalLabel: "Insira o desconto",
                      externalLabel: "Desconto",
                      borderColor: gray,
                      keyboardType: TextInputType.number,
                      externalLabelColor: preto,
                      labelInterno: "Insira o desconto")),
              const Spacer(),
              ButtonWidget(
                onPressed: () {
                  calculaValoCompra();
                  Navigator.pop(context);
                },
                borderRadius: 2.h,
                title: "SALVAR",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createObj() async {
    isLoading = true;
    if (listProdutosSelecionados.isEmpty) {
      return poPupErrorDefault(context, "Atenção!",
          "Nenhum produto foi selecionado, volte e selecione ao menos um produto");
    }
    final sales = Sale(
        id: const Uuid().v4(),
        sync: false,
        createdAt: DateTime.now(),
        codigoVenda: gerarCodigoRandomico(),
        active: true,
        tipoPagamento: tipoPagamentoSelect.value,
        desconto: double.tryParse(valorDesconto.text),
        valor: double.parse(valorCompra.value));
    List<Transactions> list = [];
    for (var element in listProdutosSelecionados) {
      list.add(Transactions(
          type: TipoTransacao.sale,
          sync: false,
          customerId:
              instanceManager.get<NovaVendaController>().costumerSelected?.id,
          productId: element.id,
          numberProd: element.numbProduct,
          saleId: sales.id,
          originCompanyId: shopUser.id,
          userId: loggerUser.id,
          id: const Uuid().v4(),
          createdAt: DateTime.now(),
          active: true));
      element.quantity = (element.quantity! - element.numbProduct);
      element.sync = false;
      await instanceManager
          .get<IProductRepository>()
          .createOrReplace(element.toJson());
      await instanceManager.get<IProductService>().updateItem(element);
    }
    await instanceManager
        .get<ISaleRepository>()
        .createOrReplace(sales.toJson());
    await instanceManager
        .get<ITransactionRepository>()
        .createList(list.map((e) => e.toJson()));
    // ignore: use_build_context_synchronously
    //instanceManager.get<HomeController>().carregaDados();
    context.pushAndRemoveUntil(const HomePage());
    isLoading = false;
  }

  String gerarCodigoRandomico() {
    const caracteres =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return List.generate(
        8, (index) => caracteres[random.nextInt(caracteres.length)]).join();
  }

  void selectTypeBuy() {
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: branco,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.h), topRight: Radius.circular(2.h))),
        width: double.infinity,
        height: 40.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025),
                child: TextWidget(
                  "Selecione a forma de pagamento",
                  fontSize: font_18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...TipoPagamento.values.map((e) => Column(
                    children: [
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          tipoPagamentoSelect.value = e;
                          tipoPagamentoSelect.refresh();
                          context.pop();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              e.icon,
                              height: 4.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 2.w),
                              child: TextWidget(e.name),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              const Spacer(),
              ButtonWidget(
                onPressed: () => Navigator.pop(context),
                borderRadius: 2.h,
                title: "ENTENDI",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
