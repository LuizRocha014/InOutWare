import 'package:flutter_app/base/models/smartStorege/Core/core.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop extends Core {
  final String companyId;
  final String name;
  final String location;
  Shop({
    required super.id,
    required super.createdAt,
    required super.active,
    required this.companyId,
    required this.name,
    required this.location,
    required super.sync,
  });

  factory Shop.fromJson(Map<String, dynamic> json) =>
      _$ShopFromJson(fromJsonRepository(json));

  Map<String, dynamic> toJson() => toJsonRepository(_$ShopToJson(this));

  static InfosTableDatabase get table {
    final columns = {
      "CompanyId": "TEXT",
      "Name": "TEXT",
      "Location": "TEXT",
    };
    columns.addAll(Core.table.columns);
    return InfosTableDatabase(tableName: 'Shop', columns: columns);
  }
}
