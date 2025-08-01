import 'package:flutter_app/base/models/smartStorege/Core/core.dart';
import 'package:flutter_app/utils/enuns.dart';
import 'package:componentes_lr/componentes_lr.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale extends Core {
  final double valor;
  final String codigoVenda;
  final double? desconto;
  final TipoPagamento tipoPagamento;
  @JsonKey(includeToJson: false)
  String cnpj;
  Sale(
      {required super.id,
      required super.createdAt,
      required super.active,
      required this.valor,
      required this.codigoVenda,
      this.tipoPagamento = TipoPagamento.pix,
      this.desconto,
      this.cnpj = ' - ',
      required super.sync});
  factory Sale.fromJson(Map<String, dynamic> json) =>
      _$SaleFromJson(fromJsonRepository(json));

  Map<String, dynamic> toJson() => toJsonRepository(_$SaleToJson(this));

  static InfosTableDatabase get table {
    final columns = {
      "Valor": "INTEGER",
      "Desconto": "INTEGER",
      "CodigoVenda": "TEXT",
      "TipoPagamento": "INTEGER",
    };
    columns.addAll(Core.table.columns);
    return InfosTableDatabase(tableName: 'Sale', columns: columns);
  }
}
