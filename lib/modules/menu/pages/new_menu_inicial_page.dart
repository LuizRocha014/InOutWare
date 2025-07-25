import 'package:flutter_app/modules/listaVendas/widget/card_vendas_widget.dart';
import 'package:flutter_app/modules/vendas/page/nova_venda_page.dart';

import 'package:flutter_app/utils/assets.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter_app/utils/fonts.dart';
import 'package:flutter_app/widget/background_menu_widget.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMenuInicialPage extends StatefulWidget {
  const NewMenuInicialPage({super.key});

  @override
  State<NewMenuInicialPage> createState() => _NewMenuInicialPageState();
}

class _NewMenuInicialPageState extends State<NewMenuInicialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundMenuWidget(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Get.to(const NovaVendaPage()),
        child: Image.asset(
            height: MediaQuery.of(context).size.width * 0.07,
            width: MediaQuery.of(context).size.width * 0.07,
            iconSuperMarket),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: TextWidget(
                "VENDAS",
                fontWeight: FontWeight.w500,
                fontSize: font_18,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: ListView.builder(
              itemCount: 15,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  const CardVendasWidget(
                      numVenda: "VENDA N° 225",
                      nomeVendedor: "Osvaldo Cruz",
                      dataString: "12/04/2024",
                      valorVenda: 200),
            ),
          )
        ],
      ),
    );
  }
}
