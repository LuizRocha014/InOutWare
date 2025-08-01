import 'dart:developer';

import 'package:flutter_app/modules/menu/controllers/new_menu_inicial_controller.dart';
import 'package:flutter_app/modules/vendas/page/finalizacao_venda_page.dart';
import 'package:flutter_app/modules/vendas/page/select_itens_list_page.dart';

import 'package:flutter_app/utils/assets.dart';
import 'package:flutter_app/utils/backgrounds/new_background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/utils/infos_statica.dart';
import 'package:flutter_app/widget/rich_text_widet.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends MState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    super.deleteController = false;
    super.registerController(HomeController());
    controller.carregaValorVendas();
  }

  @override
  Widget build(BuildContext context) {
    return NewBackGroundDefault(
      widgetContainer: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                      height: MediaQuery.of(context).size.width * 0.08,
                      width: MediaQuery.of(context).size.width * 0.08,
                      iconApp),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    child: TextWidget(
                      "Bem Vindo ${loggerUser.name}",
                      fontSize: font_16,
                      textColor: branco,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  controller.selectShop();
                },
                child: Image.asset(
                  height: 4.h,
                  iconComprador,
                  color: branco,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.08),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: branco,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.width * 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWidget(
                          "Minhas Vendas",
                          textColor: lightGray,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(
                              () => TextWidget(
                                doubleToFormattedReal(double.parse(
                                    controller.contadorValor.value)),
                                fontSize: font_28,
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.04),
                      child: GestureDetector(
                        onTap: () => context.push(const SelecaoItensPage(
                          tituloPage: "Produtos",
                        )),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(color: lightGray),
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.01),
                          ),
                          child: Image.asset(
                              height: MediaQuery.of(context).size.height * 0.01,
                              width: MediaQuery.of(context).size.width * 0.01,
                              iconMore),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: secundaryColor
                    .withOpacity(0.9), // Cor de fundo similar à da imagem
                hintText: 'Busque uma venda',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: GestureDetector(
                    onTap: () {
                      log("Scan");
                    },
                    child: const Icon(Icons.qr_code_scanner)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              ),
            ),
          ),
        ],
      ),
      widget: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              "Funções",
              fontSize: font_18,
              fontWeight: FontWeight.w600,
            ),
            Obx(
              () => Visibility(
                visible: controller.listOpcaoMenu.isNotEmpty,
                replacement: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: const Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      "Nenhum acesso encontrado",
                      textColor: cinzaIperClato,
                    ),
                  ),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: controller.listMenuInicial.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () => controller.acessaPagina(
                        controller.listMenuInicial[index].gestureCommand,
                        context),
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.015),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.01,
                        width: MediaQuery.of(context).size.width * 0.01,
                        decoration: BoxDecoration(
                            color: branco,
                            border: Border.all(color: lightGray),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              controller.listMenuInicial[index].imageString,
                              height: 40,
                            ),
                            TextWidget(controller.listMenuInicial[index].nome)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  "Vendas",
                  fontSize: font_18,
                  fontWeight: FontWeight.w600,
                ),
                //const TextWidget("Ver tudo", textColor: lightGray)
              ],
            ),
            Obx(
              () => controller.listSale.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: TextWidget(
                            textAlign: TextAlign.center,
                            "Nenhuma venda encontrado",
                            textColor: lightGray,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listSale.length,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        child: GestureDetector(
                          onTap: () {
                            context.push(FinalizacaoVendaPage(
                              saleId: controller.listSale[index].id,
                              resume: true,
                            ));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                                color: branco,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.015),
                                border: Border.all(color: lightGray)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: secundaryColor,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                      border: Border.all(color: secundaryColor),
                                    ),
                                    child: Image.asset(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        iconItemProduto),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.02),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        controller.listSale[index].codigoVenda
                                            .toUpperCase(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: font_14,
                                      ),
                                      CustomRich("Cliente: ",
                                          controller.listSale[index].cnpj),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
