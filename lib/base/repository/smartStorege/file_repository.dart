import 'package:flutter_app/base/models/smartStorege/File/file.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:flutter_app/base/repository/interface/smartStorege/ifile_repository.dart';

class FileRepository extends BaseRepository<FileIMG>
    implements IFileRepository {
  FileRepository(super.infosTableDatabase, super.fromJson);
  @override
  Future<List<FileIMG>> getItensSync() async {
    try {
      final query =
          '''SELECT * FROM ${FileIMG.table.tableName} WHERE Sync = 0 ''';
      final entity = await context.rawQuery(query);
      if (entity.isEmpty) return [];
      final entityList = entity.map((e) => FileIMG.fromJson(e)).toList();
      return entityList;
    } catch (_) {
      return [];
    }
  }
}
