import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mintzer/api/local_storage.dart';
import 'package:mintzer/main.dart';
import 'package:mintzer/util/colors.dart';

import '../api/database_api.dart';
import '../globalVariable.dart';
import '../model/orders_model.dart';
import '../util/constants.dart';

class OrderApi {
  ///---------------------Orders-----------------
  static List<String> orderId = [];
  static List<String> orderTitle = [];
  static List<String> orderImage = [];
  static List<String> orderYouSpend = [];
  static List<String> orderStoreName = [];
  static List<String> orderTotalEarning = [];
  // static List<String> orderStatus = [];
  static List<String> orderMainId = [];
  static List<String> orderstoreTitle = [];
  static List<String> storeOrderIdList = [];


  static String storeOrderId = "";
  static String trackingId = "";
  static String shippedOtp = "";
  static String deliveredStatus = "";
  static String orderDate = "";
  static String orderTransactionId = "";
  static String isPayoutRequested = "";
  static String isPayout = "";
  static String storeTitle = "";

  static OrdersModel? ordersModel;

  static Future<void> getOrders(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getOrders,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getOrders :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
    ordersModel = ordersModelFromJson(value.data);

    });
  }

  // static String orderMainId = "NA";

  static Future<void> getOrdersByOrderId(
      BuildContext context, String orderId,) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "order_id": orderId,
    };

    customPrint("getOrdersByOrderId Body :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getOrderDetailsById,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getOrdersByOrderId :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["order"];
      final jsonDataDeal = jsonDecode(value.data)["deal"];
      // int len = getJsonLength(jsonData);
      // customPrint("len :: $len");

      storeOrderId = jsonData["store_order_id"].toString();
      trackingId = jsonData["order_tracking_id"].toString();
      shippedOtp = jsonData["order_delivery_otp"].toString();
      deliveredStatus = jsonData["order_status"].toString();
      orderDate = jsonData["date_time"].toString();
      orderTransactionId = jsonData["transaction_id"].toString();
      isPayoutRequested = jsonData["is_payout_requested"].toString();
      storeTitle = jsonDataDeal["store_title"].toString();
      isPayout = jsonData["is_payout"].toString();
      customPrint("storeOrderId :: $storeOrderId");
      customPrint("deliveredStatus :: $deliveredStatus");
      customPrint("orderDate :: $orderDate");
      customPrint("orderTransactionId :: $orderTransactionId");
      customPrint("isPayoutRequested :: $isPayoutRequested");
      customPrint("isPayout :: $isPayout");
      customPrint("storeTitle :: $storeTitle");
      // orderId = jsonData["order_id"].toString();
      // orderId = jsonData["order_id"].toString();
      // orderId = jsonData["order_id"].toString();
      // orderMainId = jsonData["id"].toString();
    });
  }

  static Future<String> completeOrder(BuildContext context, String storeOrderId,
      String yourMobileNumber, String orderId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "store_order_id": storeOrderId,
      "your_mobile": yourMobileNumber,
      "order_id": orderId,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.completeTheOrder,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("completeOrder :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      final jsonData = jsonDecode(value.data)["orders"];
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      return "1";
    });
  }

  static Future<String> updateOrderForm(
      BuildContext context,
      String storeOrderId,
      String orderTrackingId,
      String orderCourierId,
      String orderGst,
      String orderDeliveryOtp,String orderId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "store_order_id": storeOrderId,//-------1
      "order_delivery_otp": orderDeliveryOtp,//--------3
      "order_tracking_id": orderTrackingId,//----------2
      "order_courier_id": orderCourierId,
      "order_gst": orderGst,
      "order_id": orderId,
    };

    customPrint("jsonData updateOrderForm :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.updateOrderForm,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("updateOrderForm :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      final jsonData = jsonDecode(value.data)["orders"];

      // storeOrderId = jsonData["store_order_id"].toString();

      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      return "1";
    });
  }
}
