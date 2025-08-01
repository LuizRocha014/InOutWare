import 'package:flutter_app/modules/estoque/widget/card_item_select_widget.dart';
import 'package:flutter_app/modules/vendas/controller/finalizacao_venda_controller.dart';
import 'package:flutter_app/utils/backgrounds/background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';

class FinalizacaoVendaPage extends StatefulWidget {
  final String? saleId;
  final bool resume;
  const FinalizacaoVendaPage({super.key, this.saleId, this.resume = false});

  @override
  State<FinalizacaoVendaPage> createState() => _MyWidgetState();
}

class _MyWidgetState
    extends MState<FinalizacaoVendaPage, FinalizacaoVendaController> {
  @override
  void initState() {
    super.registerController(FinalizacaoVendaController(
        saleId: widget.saleId, resume: widget.resume));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      titulo: "Checkout",
      child: Stack(
        children: [
          Obx(
            () => SizedBox(
              height: 55.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView.builder(
                  itemCount: controller.listProdutosSelecionados.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: CardItemSelectWidget(
                      imagem: controller.listProdutosSelecionados[index].image,
                      titulo: controller
                          .listProdutosSelecionados[index].description,
                      valor: controller.listProdutosSelecionados[index].price
                          .toString(),
                      quantidade: controller
                          .listProdutosSelecionados[index].numbProduct
                          .toString(),
                      onTapMore: () => controller.adicionaItemCompra(index),
                      onTapless: () => controller.removeItemCompra(index),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 33.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2.h),
                      topRight: Radius.circular(2.h))),
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: !widget.resume
                                ? () => controller.inserirDesconto()
                                : () {},
                            child: const Icon(
                              FontAwesomeIcons.percent,
                              color: branco,
                            ),
                          )),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            "Subtotal:",
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          ),
                          TextWidget(
                            doubleToFormattedReal(
                              double.parse(controller.valorCompra.value),
                            ),
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            "Desconto:",
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          ),
                          TextWidget(
                            doubleToFormattedReal(
                              double.parse(0.toString()),
                            ),
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            "Total:",
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          ),
                          TextWidget(
                            doubleToFormattedReal(
                              double.parse(controller.valorCompra.value),
                            ),
                            textColor: branco,
                            fontSize: font_16,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(
                      color: branco,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: !widget.resume
                            ? () => controller.selectTypeBuy()
                            : () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  controller.tipoPagamentoSelect.value.icon,
                                  height: 4.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: TextWidget(
                                    controller.tipoPagamentoSelect.value.name,
                                    textColor: branco,
                                    fontSize: font_16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              size: font_13,
                              color: branco,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Obx(
                () => LoadingButtonWidget(
                    title: "FINALIZAR",
                    color: secundaryColor,
                    onPressed:
                        !widget.resume ? () => controller.createObj() : () {},
                    mostraTexto: !controller.isLoading,
                    isLoading: controller.isLoading),
              ),
            ),
          )
        ],
      ),
    );
  }
}
