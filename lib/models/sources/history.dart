import 'package:json_annotation/json_annotation.dart';
part 'history.g.dart';
@JsonSerializable()
class HistoryModel {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "transaction")
  String transactionId;
  String status;
  @JsonKey(name: "created_at")
   final DateTime createdAt ;
  @JsonKey(name: "updated_at")
  final DateTime updatedAt;

  HistoryModel({
    required this.id,
    required this.transactionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
