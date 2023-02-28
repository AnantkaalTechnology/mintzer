// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  OrdersModel({
    required this.result,
    required this.msg,
    required this.orders,
    required this.currentDateTime,
  });

  int result;
  String msg;
  List<Order> orders;
  DateTime currentDateTime;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    result: json["result"],
    msg: json["msg"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    currentDateTime: DateTime.parse(json["current_date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "msg": msg,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "current_date_time": currentDateTime.toIso8601String(),
  };
}

class Order {
  Order({
    required this.orderEnd,
    required this.orderStatus,
    required this.orderId,
    required this.id,
    required this.orderStart,
    required this.storeOrderId,
    required this.orderCourierId,
    required this.orderTrackingId,
    required this.dealTitle,
    required this.dealImage,
    required this.storeId,
    required this.dealerId,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.image,
    required this.bankId,
    required this.offerTitle,
    required this.offerText,
    required this.dealersPrice,
    required this.youWillSpend,
    required this.cashback,
    required this.totalYouWillReceive,
    required this.totalEarnings,
    required this.offerLink,
    required this.orderQuantity,
    required this.dealStatus,
    required this.dateTime,
    required this.status,
    required this.storeName,
    required this.discount,
  });

  DateTime orderEnd;
  String orderStatus;
  String orderId;
  String id;
  DateTime orderStart;
  String storeOrderId;
  String orderCourierId;
  String orderTrackingId;
  String dealTitle;
  String dealImage;
  String storeId;
  String dealerId;
  String title;
  String shortDescription;
  String description;
  String image;
  String bankId;
  String offerTitle;
  String offerText;
  String dealersPrice;
  String youWillSpend;
  String cashback;
  String totalYouWillReceive;
  String totalEarnings;
  String offerLink;
  String orderQuantity;
  String dealStatus;
  DateTime dateTime;
  String status;
  String storeName;
  String discount;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderEnd: DateTime.parse(json["order_end"]),
    orderStatus: json["order_status"],
    orderId: json["order_id"],
    id: json["id"],
    orderStart: DateTime.parse(json["order_start"]),
    storeOrderId: json["store_order_id"],
    orderCourierId: json["order_courier_id"],
    orderTrackingId: json["order_tracking_id"],
    dealTitle: json["deal_title"],
    dealImage: json["deal_image"],
    storeId: json["store_id"],
    dealerId: json["dealer_id"],
    title: json["title"],
    shortDescription: json["short_description"],
    description: json["description"],
    image: json["image"],
    bankId: json["bank_id"],
    offerTitle: json["offer_title"],
    offerText: json["offer_text"],
    dealersPrice: json["dealers_price"],
    youWillSpend: json["you_will_spend"],
    cashback: json["cashback"],
    totalYouWillReceive: json["total_you_will_receive"],
    totalEarnings: json["total_earnings"],
    offerLink: json["offer_link"],
    orderQuantity: json["order_quantity"],
    dealStatus: json["deal_status"],
    dateTime: DateTime.parse(json["date_time"]),
    status: json["status"],
    storeName: json["store_name"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "order_end": orderEnd.toIso8601String(),
    "order_status": orderStatus,
    "order_id": orderId,
    "id": id,
    "order_start": orderStart.toIso8601String(),
    "store_order_id": storeOrderId,
    "order_courier_id": orderCourierId,
    "order_tracking_id": orderTrackingId,
    "deal_title": dealTitle,
    "deal_image": dealImage,
    "store_id": storeId,
    "dealer_id": dealerId,
    "title": title,
    "short_description": shortDescription,
    "description": description,
    "image": image,
    "bank_id": bankId,
    "offer_title": offerTitle,
    "offer_text": offerText,
    "dealers_price": dealersPrice,
    "you_will_spend": youWillSpend,
    "cashback": cashback,
    "total_you_will_receive": totalYouWillReceive,
    "total_earnings": totalEarnings,
    "offer_link": offerLink,
    "order_quantity": orderQuantity,
    "deal_status": dealStatus,
    "date_time": dateTime.toIso8601String(),
    "status": status,
    "store_name": storeName,
    "discount": discount,
  };
}
