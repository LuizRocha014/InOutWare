import 'package:flutter_app/modules/estoque/widget/card_item_select_widget.dart';
import 'package:flutter_app/modules/vendas/controller/select_itens_list_controller.dart';

import 'package:flutter_app/utils/backgrounds/background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/utils/synchronize.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelecaoItensPage extends StatefulWidget {
  final String tituloPage;
  const SelecaoItensPage({super.key, required this.tituloPage});

  @override
  State<SelecaoItensPage> createState() => _SelecaoItensPageState();
}

class _SelecaoItensPageState
    extends MState<SelecaoItensPage, SelectItensController> {
  @override
  void initState() {
    super.registerController(SelectItensController());
    super.initState();
    deleteController = true;
  }

  // @override
  // void dispose() {
  //   instanceManager.get<Synchronism>().fullSync();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      titulo: widget.tituloPage,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Obx(
              () => controller.listProdutos.isEmpty && !controller.isLoading
                  ? const Center(
                      child: TextWidget(
                        "Nenhum produto encontrado",
                        textColor: lightGray,
                      ),
                    )
                  : controller.listProdutos.isEmpty && controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.listProdutos.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: TextWidget(
                                    fontSize: font_16,
                                    fontWeight: FontWeight.w500,
                                    controller
                                        .listProdutos[index].categoriaName!,
                                    textColor: preto,
                                  ),
                                ),
                              ),
                              controller.listProdutos[index].listProduct!
                                      .isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.listProdutos[index]
                                          .listProduct!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context,
                                              int indexProd) =>
                                          CardItemSelectWidget(
                                        imagem: controller.listProdutos[index]
                                            .listProduct![indexProd].image,
                                        titulo: controller
                                            .listProdutos[index]
                                            .listProduct![indexProd]
                                            .description,
                                        valor: controller.listProdutos[index]
                                            .listProduct![indexProd].price
                                            .toString(),
                                        quantidade: controller
                                            .listProdutos[index]
                                            .listProduct![indexProd]
                                            .numbProduct
                                            .toString(),
                                        onTapMore: () =>
                                            controller.adicionaItemCompra(
                                                index, indexProd),
                                        onTapless: () => controller
                                            .removeItemCompra(index, indexProd),
                                      ),
                                    )
                                  : const Align(
                                      alignment: Alignment.center,
                                      child: TextWidget(
                                        "Nenhum Produto encontrado",
                                        textColor: lightGray,
                                      )),
                            ],
                          ),
                        ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => Visibility(
                visible: controller.contador > 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: ButtonWidget(
                    borderRadius: 5.h,
                    width: 60.w,
                    onPressed: () => controller.avancaPaginaItens(),
                    title: '(${controller.contador}) AVANÇAR',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//CardItemSelectWidget(
                      //   titulo: controller.listProdutos[index].name,
                      //   valor:
                      //       controller.listProdutos[index].salePrice.toString(),
                      //   quantidade: controller.listProdutos[index].numbProduct
                      //       .toString(),
                      //   onTapMore: () => controller.adicionaItemCompra(index),
                      //   onTapless: () => controller.removeItemCompra(index),
                      // ),