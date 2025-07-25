import 'package:flutter_app/modules/produtos/controller/produto_controller.dart';
import 'package:flutter_app/utils/backgrounds/background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends MState<ProdutosPage, ProdutoController> {
  @override
  void initState() {
    super.registerController(ProdutoController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      titulo: "Produtos",
      child: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextWidget(
                "PRODUTOS",
                textColor: textGray,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 1,
              decoration: const BoxDecoration(color: lightGray),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Obx(
              () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listProdutos.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.02),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    decoration: BoxDecoration(
                      color: branco,
                      border: Border.all(color: gray),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                "", // controller.listProdutos[index].name"",
                                fontSize: font_16,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                              TextWidget(
                                "" // controller.listProdutos[index].totalAmount
                                    .toString(),
                                fontSize: font_16,
                                textColor: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
