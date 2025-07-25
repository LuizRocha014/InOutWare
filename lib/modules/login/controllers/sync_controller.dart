import 'package:flutter_app/modules/menu/pages/home_page.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter_app/modules/login/page/login_page.dart';
import 'package:flutter_app/modules/shere/controllers/base_controller.dart';
import 'package:flutter_app/utils/synchronize.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:get/get.dart';

class SyncController extends BaseController {
  late RxBool teveErro;
  @override
  Future<void> iniciaControlador() async {
    teveErro = false.obs;
    try {
      await instanceManager.get<Synchronism>().fullSync(forcaSincronismo: true);
      if (!teveErro.value) {
        context.pushAndRemoveUntil(const HomePage());
      }
    } catch (e) {
      teveErro.value = true;
      log(e.toString());
    }
  }

  double get progress => instanceManager.get<Synchronism>().progress.value;

  Future<void> backButton() async {
    try {
      final lastTimeUpdated = await secureStorage.readSecureStorage('LastTimeUpdated') ?? "";
      if (lastTimeUpdated.isNotEmpty) {
        context.pushAndRemoveUntil(const HomePage());
      } else {
        context.pushAndRemoveUntil(const LoginPage());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
