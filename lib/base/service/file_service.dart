import 'package:flutter_app/base/models/smartStorege/File/file.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ifile_repository.dart';
import 'package:flutter_app/base/service/base_service.dart';
import 'package:flutter_app/base/service/interface/ifile_service.dart';
import 'package:flutter_app/utils/utils_exports.dart';
import 'package:componentes_lr/componentes_lr.dart';

class FileService extends BaseService implements IFileService {
  @override
  Future<bool> postMethod() async {
    try {
      final repository = instanceManager.get<IFileRepository>();
      final list = await repository.getItensSync();
      final listMap = list.map((e) => e.toJson()).toList();
      if (list.isEmpty) return false;
      final String urlApi = "$url/api/File/PostAll";
      post(
        urlApi,
        listMap,
      ).then((retorno) {
        if (!temErroRequisicao(retorno)) {
          // e.sync = true;
          // repository.createOrReplace(e.toJson());
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<FileIMG>> getAll({bool alteracaoNula = false}) async {
    try {
      List<FileIMG> list = [];
      final lastUpdate =
          sharedPreferences.getString("LastUpdate$runtimeType") ?? "";
      final repository = instanceManager.get<IFileRepository>();
      final String urlApi = "$url/api/File/GetAll";
      final retorno = await get(urlApi, query: {"ultDate": ""});
      if (retorno.body == null) return [];
      var category = (retorno.body as List).map((e) => FileIMG.fromJson(e));
      list.addAll(category);
      await repository.createList(list.map((e) => e.toJson()));
      sharedPreferences.setString(
          "LastUpdate$runtimeType", DateTime.now().toIso8601String());
      return list;
    } catch (_) {
      return [];
    }
  }
}
