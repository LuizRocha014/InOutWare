import 'package:flutter_app/base/models/smartStorege/Core/core.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_user.g.dart';

@JsonSerializable()
class ShopUser extends Core {
  final String userId;
  final String shopId;
  @JsonKey(fromJson: fromJsonBoolean)
  final bool userMainShop;
  ShopUser({
    required this.userId,
    required this.shopId,
    required this.userMainShop,
    required super.id,
    required super.createdAt,
    required super.active,
    required super.sync,
  });

  factory ShopUser.fromJson(Map<String, dynamic> json) =>
      _$ShopUserFromJson(fromJsonRepository(json));

  Map<String, dynamic> toJson() => toJsonRepository(_$ShopUserToJson(this));

  static InfosTableDatabase get table {
    final columns = {
      "userId": "TEXT",
      "shopId": "TEXT",
      "userMainShop": "INTEGER",
    };
    columns.addAll(Core.table.columns);
    return InfosTableDatabase(tableName: 'ShopUser', columns: columns);
  }
}
