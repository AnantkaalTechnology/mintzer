// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WalletModel walletModelFromJson(String str) => WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    required this.result,
    required this.msg,
    required this.user,
    required this.totalEarnings,
    required this.totalBalance,
    required this.wallet,
    required this.orders,
  });

  int result;
  String msg;
  List<User> user;
  int totalEarnings;
  String totalBalance;
  String wallet;
  List<Order> orders;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    result: json["result"],
    msg: json["msg"],
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    totalEarnings: json["total_earnings"],
    totalBalance: json["total_balance"],
    wallet: json["wallet"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "msg": msg,
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
    "total_earnings": totalEarnings,
    "total_balance": totalBalance,
    "wallet": wallet,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    required this.id,
    required this.isReadyForPayout,
    required this.isPayoutRequested,
    required this.dateTime,
    required this.isPayout,
    required this.orderStatus,
    required this.orderId,
    required this.orderStart,
    required this.dealTitle,
    required this.dealImage,
    required this.youWillSpend,
    required this.storeName,
    required this.totalEarnings,
  });

  String id;
  String isReadyForPayout;
  String isPayoutRequested;
  DateTime dateTime;
  String isPayout;
  String orderStatus;
  String orderId;
  DateTime orderStart;
  String dealTitle;
  String dealImage;
  String youWillSpend;
  String storeName;
  String totalEarnings;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    isReadyForPayout: json["is_ready_for_payout"],
    isPayoutRequested: json["is_payout_requested"],
    dateTime: DateTime.parse(json["date_time"]),
    isPayout: json["is_payout"],
    orderStatus: json["order_status"],
    orderId: json["order_id"],
    orderStart: DateTime.parse(json["order_start"]),
    dealTitle: json["deal_title"],
    dealImage: json["deal_image"],
    youWillSpend: json["you_will_spend"],
    storeName: json["store_name"],
    totalEarnings: json["total_earnings"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_ready_for_payout": isReadyForPayout,
    "is_payout_requested": isPayoutRequested,
    "date_time": dateTime.toIso8601String(),
    "is_payout": isPayout,
    "order_status": orderStatus,
    "order_id": orderId,
    "order_start": orderStart.toIso8601String(),
    "deal_title": dealTitle,
    "deal_image": dealImage,
    "you_will_spend": youWillSpend,
    "store_name": storeName,
    "total_earnings": totalEarnings,
  };
}

class User {
  User({
    required this.bankAccountNumber,
    required this.bankName,
  });

  String bankAccountNumber;
  String bankName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    bankAccountNumber: json["bank_account_number"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "bank_account_number": bankAccountNumber,
    "bank_name": bankName,
  };
}
