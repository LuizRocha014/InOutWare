import 'dart:developer';

import 'package:flutter_app/base/models/dto/list_menu_Iniciar.dart';
import 'package:flutter_app/base/models/smartStorege/Shop/shop.dart';
import 'package:flutter_app/base/models/smartStorege/product/product.dart';
import 'package:flutter_app/base/models/smartStorege/venda/sale.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/isale_repository.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ishop_user_repository.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/iuser_permission_repository.dart';
import 'package:flutter_app/modules/cliente/page/cliente_page.dart';
import 'package:flutter_app/modules/estoque/page/estoque_produto_page.dart';
import 'package:flutter_app/modules/listaVendas/page/lista_vendas_page.dart';
import 'package:flutter_app/modules/menu/pages/menu_principal_page.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/modules/vendas/page/select_itens_list_page.dart';
import 'package:flutter_app/utils/assets.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  late final RxList<ListOpcoesMenu> listMenuInicial;
  late final RxList<Product> listProduto;
  late final RxList<Sale> listSale;
  late RxList<Shop> listShop;
  late RxString contadorValor;

  @override
  Future<void> iniciaControlador() async {
    listMenuInicial = RxList<ListOpcoesMenu>();
    listProduto = RxList<Product>();
    listSale = RxList<Sale>();
    listShop = RxList<Shop>();
    contadorValor = "0".obs;
    carregaFull();
  }

  void carregaFull() async {
    await carregaValorVendas();
    await carregaDados();
    contadorValor.refresh();
    listSale.refresh();
  }

  Future<void> carregaValorVendas() async {
    contadorValor.value =
        await instanceManager.get<ISaleRepository>().getValortotalVendas();
    await instanceManager
        .get<ISaleRepository>()
        .getVendas()
        .then(listSale.call);
    await instanceManager
        .get<IShopUserRepository>()
        .getShop(loggerUser.id)
        .then(listShop.call);

    contadorValor.refresh();
    listSale.refresh();
  }

  List<ListOpcoesMenu> get listOpcaoMenu => listMenuInicial;
  Future<void> carregaDados() async {
    try {
      final listUsuarioAcesso = await instanceManager
          .get<IUserPermissionRepository>()
          .getPermissionUser();
      for (var e in listUsuarioAcesso) {
        switch (e.name) {
          case "EstoquePermission":
            listMenuInicial.add(ListOpcoesMenu(
                nome: 'Estoque',
                gestureCommand: 'GestureEstoque',
                imageString: iconEstoque));
            break;
          case "ProdutosPermission":
            listMenuInicial.add(ListOpcoesMenu(
                nome: 'Produtos',
                gestureCommand: 'GestureProdutos',
                imageString: iconProdutos));
            break;
          case "ClientePermission":
            listMenuInicial.add(ListOpcoesMenu(
                nome: 'Cliente',
                gestureCommand: 'GestureCliente',
                imageString: iconCliente));
        }
      }
    } catch (_) {}
  }

  Future<void> acessaPagina(String index, BuildContext context) async {
    try {
      switch (index) {
        case 'GestureVendas':
          context.push(const ListaVendasPage());
          break;
        case 'GestureHome':
          context.push(const MenuPrincipalPage());
          break;
        case 'GestureEstoque':
          log("Estoque");
          context.push(const EstoqueProdutosPage());
          break;
        case 'GestureProdutos':
          log("Produtos");
          context.push(const SelecaoItensPage(
            tituloPage: "Produtos",
          ));
          break;
        case 'GestureCliente':
          context.push(const ClientePage(false));
          break;
        default:
      }
    } catch (_) {}
  }

  void selectShop() async {
    return await showModalBottomSheet(
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
        height: 30.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025),
                child: TextWidget(
                  "Selecione a loja que deseja acessar",
                  fontSize: font_18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...listShop.map(
                (e) => Column(
                  children: [
                    const Divider(),
                    GestureDetector(
                      onTap: () async {
                        shopUser = e;
                        iniciaControlador();
                        await carregaValorVendas();
                        context.pop();
                      },
                      child: SizedBox(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: TextWidget(
                          e.name,
                          fontSize: font_16,
                        ),
                      )),
                    )
                  ],
                ),
              ),
              const Spacer(),
              ButtonWidget(
                onPressed: () {
                  iniciaControlador();
                  Navigator.pop(context);
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
}
