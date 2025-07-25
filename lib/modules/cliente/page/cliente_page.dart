import 'package:flutter_app/modules/cliente/controller/cliente_controller.dart';

import 'package:flutter_app/utils/backgrounds/background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/widget/rich_text_widet.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ClientePage extends StatefulWidget {
  final bool selectItem;
  const ClientePage(this.selectItem, {super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends MState<ClientePage, ClienteController> {
  @override
  void initState() {
    super.registerController(ClienteController());
    super.initState();
  }

  // @override
  // void dispose() {
  //   instanceManager.get<Synchronism>().fullSync();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      icon: Icons.add,
      onTap: () => controller.novoCliente(),
      titulo: "Cliente",
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Obx(
          () => controller.listCostumer.isEmpty && !controller.isLoading
              ? Center(
                  child: TextWidget(
                  "Nenhum cliente encontrado",
                  textColor: lightGray,
                  fontSize: font_14,
                ))
              : controller.listCostumer.isEmpty && controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.listCostumer.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          if (widget.selectItem) {
                            controller
                                .selectItem(controller.listCostumer[index]);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 16.w,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(1.h)),
                                    child: Center(
                                      child: TextWidget(
                                        returnInitialsName(controller
                                            .listCostumer[index].nome),
                                        fontSize: font_18,
                                        fontWeight: FontWeight.w500,
                                        textColor: branco,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 65.w,
                                        child: TextWidget(
                                          overflow: TextOverflow.visible,
                                          maxLines: 2,
                                          controller.listCostumer[index].nome,
                                          fontWeight: FontWeight.w500,
                                          fontSize: font_16,
                                        ),
                                      ),
                                      CustomRich("CNPJ: ",
                                          controller.listCostumer[index].cnpj),
                                      CustomRich(
                                          "Telefone: ",
                                          controller
                                                  .listCostumer[index].phone ??
                                              " - "),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 2.h),
                              const Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
