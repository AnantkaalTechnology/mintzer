import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mintzer/api/local_storage.dart';
import 'package:mintzer/main.dart';
import 'package:mintzer/util/colors.dart';

import '../api/database_api.dart';
import '../globalVariable.dart';
import '../util/constants.dart';

class OrderApi {
  ///---------------------Orders-----------------
  static List<String> orderId = [];
  static List<String> orderTitle = [];
  static List<String> orderImage = [];
  static List<String> orderYouSpend = [];
  static List<String> orderStoreName = [];
  static List<String> orderTotalEarning = [];
  static List<String> orderStatus = [];
  static List<String> orderMainId = [];

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
      final jsonData = jsonDecode(value.data)["orders"];
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      orderId.clear();
      orderTitle.clear();
      orderImage.clear();
      orderYouSpend.clear();
      orderStoreName.clear();
      orderTotalEarning.clear();
      orderStatus.clear();
      orderMainId.clear();
      for (int i = 0; i < len; i++) {
        orderId.add(jsonData[i]["order_id"].toString());
        orderTitle.add(jsonData[i]["deal_title"].toString());
        orderImage
            .add(DatabaseApi.imageUrl + jsonData[i]["deal_image"].toString());
        orderYouSpend.add(jsonData[i]["you_will_spend"].toString());
        orderStoreName.add(jsonData[i]["store_name"].toString());
        orderTotalEarning.add(jsonData[i]["total_earnings"].toString());
        orderStatus.add(jsonData[i]["order_status"].toString());
        orderMainId.add(jsonData[i]["id"].toString());
      }
      customPrint("orderMainId :: $orderMainId");
    });
  }

  // static String orderMainId = "NA";

  static Future<void> getOrdersByOrderId(
      BuildContext context, String orderId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "order_id": orderId,
    };

    customPrint("jsonData :: $jsonData");

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
      // int len = getJsonLength(jsonData);
      // customPrint("len :: $len");

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
      String orderDeliveryOtp) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "store_order_id": storeOrderId,//-------1
      "order_delivery_otp": orderDeliveryOtp,//--------3
      "order_tracking_id": orderTrackingId,//----------2
      "order_courier_id": orderCourierId,
      "order_gst": orderGst,
    };

    customPrint("jsonData :: $jsonData");

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
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      return "1";
    });
  }
}
