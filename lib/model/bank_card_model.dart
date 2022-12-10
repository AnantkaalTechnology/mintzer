// // To parse this JSON data, do
// //
// //     final bankCardsModel = bankCardsModelFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// BankCardsModel bankCardsModelFromJson(String str) => BankCardsModel.fromJson(json.decode(str));
//
// String bankCardsModelToJson(BankCardsModel data) => json.encode(data.toJson());
//
// class BankCardsModel {
//   BankCardsModel({
//     required this.result,
//     required this.msg,
//     required this.bankCards,
//     required this.userCardId,
//   });
//
//   int result;
//   String msg;
//   List<BankCard> bankCards;
//   String userCardId;
//
//   factory BankCardsModel.fromJson(Map<String, dynamic> json) => BankCardsModel(
//     result: json["result"],
//     msg: json["msg"],
//     bankCards: List<BankCard>.from(json["bank_cards"].map((x) => BankCard.fromJson(x))),
//     userCardId: json["user_card_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "result": result,
//     "msg": msg,
//     "bank_cards": List<dynamic>.from(bankCards.map((x) => x.toJson())),
//     "user_card_id": userCardId,
//   };
// }
//
// class BankCard {
//   BankCard({
//     required this.id,
//     required this.bankId,
//     required this.cardName,
//     required this.cardImage,
//     required this.dateTime,
//     required this.status,
//     required this.bankName,
//   });
//
//   String id;
//   String bankId;
//   String cardName;
//   String cardImage;
//   DateTime dateTime;
//   String status;
//   BankName bankName;
//
//   factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
//     id: json["id"],
//     bankId: json["bank_id"],
//     cardName: json["card_name"],
//     cardImage: json["card_image"],
//     dateTime: DateTime.parse(json["date_time"]),
//     status: json["status"],
//     bankName: bankNameValues.map[json["bank_name"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "bank_id": bankId,
//     "card_name": cardName,
//     "card_image": cardImage,
//     "date_time": dateTime.toIso8601String(),
//     "status": status,
//     "bank_name": bankNameValues.reverse[bankName],
//   };
// }
//
// enum BankName { HDFC_BANK, AXIS_BANK, STATE_BANK_OF_INDIA, ICICI }
//
// final bankNameValues = EnumValues({
//   "Axis Bank": BankName.AXIS_BANK,
//   "HDFC Bank": BankName.HDFC_BANK,
//   "ICICI": BankName.ICICI,
//   "State bank of india": BankName.STATE_BANK_OF_INDIA
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
