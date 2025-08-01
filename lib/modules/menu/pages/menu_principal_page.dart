import 'package:flutter_app/modules/menu/controllers/menu_principal_controller.dart';
import 'package:flutter_app/utils/assets.dart';
import 'package:flutter_app/utils/backgrounds/background_principal.dart';
import 'package:flutter_app/utils/cores_do_aplicativo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPrincipalPage extends StatefulWidget {
  const MenuPrincipalPage({super.key});

  @override
  State<MenuPrincipalPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<MenuPrincipalPage> {
  late final MenuPrincipalController controller;
  @override
  void initState() {
    controller = Get.put(MenuPrincipalController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      enableBackButton: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        tooltip: 'Increment Counter',
        child: Image.asset(
          iconAdicionarVenda,
          height: 30,
        ),
      ),
      titulo: 'Home',
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView(
          children: [
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                //itemCount: controller.listMenuInicial.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
//onTap: () => controller.acessaPagina(index, context),
                        // child: CardListMenuPrincipalWidget(
                        //  tituloCard: controller.listMenuInicial[index].nome,
//imageAssets: controller.listMenuInicial[index].image),
                        )),
          ],
        ),
      ),
    );
  }
}
