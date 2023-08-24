import 'package:json_annotation/json_annotation.dart';
part 'wallet.g.dart';
@JsonSerializable()
class WalletModel {
  String id;
  String user;
  int deposit;
  int debit;
  String createdAt;
  String updatedAt;
  int v;
  WalletModel({
    required this.id,
    required this.user,
    required this.deposit,
    required this.debit,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
