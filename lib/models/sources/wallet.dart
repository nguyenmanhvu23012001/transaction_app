import 'package:json_annotation/json_annotation.dart';
import 'package:zen8app/models/sources/user.dart';
part 'wallet.g.dart';
@JsonSerializable()
class WalletModel {
  @JsonKey(name: "_id")
  String id;
  final User user;
  double deposit;
  double debit;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  WalletModel({
    required this.id,
    required this.user,
    required this.deposit,
    required this.debit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
  Map<String, dynamic> toJson() => _$WalletModelToJson(this);
}
