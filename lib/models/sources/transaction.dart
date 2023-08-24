import 'package:json_annotation/json_annotation.dart';
import 'package:zen8app/models/sources/user.dart';
part 'transaction.g.dart';
@JsonSerializable()
class TransactionData {
  @JsonKey(name: "_id")
  final String id;
  final User buyer;
  final User seller;
  final String goods;
  @JsonKey(name: "transaction_money")
  final double transactionMoney;
  final double deposit;
  @JsonKey(name: "is_deleted")
  final bool isDeleted;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  TransactionData({
    required this.id,
    required this.buyer,
    required this.seller,
    required this.goods,
    required this.transactionMoney,
    required this.deposit,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });


  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);
  }
