import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mintzer/api/local_storage.dart';
import 'package:mintzer/main.dart';
import 'package:mintzer/util/colors.dart';

import '../api/database_api.dart';
import '../globalVariable.dart';
import '../util/constants.dart';

class HomeApi {
  ///---------------------Feeds-----------------
  static List<String> feedTitle = [];
  static List<String> feedDescription = [];
  static List<String> feedImage = [];
  static List<String> feedStatus = [];
  static List<String> feedDateTime = [];

  static Future<void> getFeeds(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getFeeds,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getFeeds :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["feeds"];
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      feedTitle.clear();
      feedDescription.clear();
      feedImage.clear();
      feedDateTime.clear();
      feedStatus.clear();
      for (int i = 0; i < len; i++) {
        feedTitle.add(jsonData[i]["title"].toString());
        feedDescription.add(jsonData[i]["short_description"].toString());
        feedImage.add(DatabaseApi.imageUrl + jsonData[i]["image"].toString());
        feedDateTime.add(jsonData[i]["date_time"].toString());
        feedStatus.add(jsonData[i]["status"].toString());
      }
    });
  }

  ///--------------------------Notification--------------------------
  static List<String> notificationTitle = [];
  static List<String> notificationSubTitle = [];

  static Future<void> getNotification(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getUserNotifications,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getNotification :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonDataNewNoti = jsonDecode(value.data)["new_notifications"];
      final jsonDataOldNoti = jsonDecode(value.data)["old_notifications"];
      int lenNew = getJsonLength(jsonDataNewNoti);
      int lenOld = getJsonLength(jsonDataOldNoti);
      customPrint("lenNew :: $lenNew");
      customPrint("lenOld :: $lenOld");
      notificationTitle.clear();
      notificationSubTitle.clear();
      for (int i = 0; i < lenNew; i++) {
        notificationTitle.add(jsonDataNewNoti[i]["name"].toString());
        notificationSubTitle.add(jsonDataNewNoti[i]["content"].toString());
      }

      for (int i = 0; i < lenOld; i++) {
        notificationTitle.add(jsonDataOldNoti[i]["name"].toString());
        notificationSubTitle.add(jsonDataOldNoti[i]["content"].toString());
      }
    });
  }

  ///deal
  static List<String> dealId = [];
  static List<String> dealStoreId = [];
  static List<String> dealerId = [];
  static List<String> dealTitle = [];
  static List<String> dealShortDescription = [];
  static List<String> dealDescription = [];
  static List<String> dealImage = [];
  static List<String> dealTotalEarnings = [];
  static List<String> dealOfferTitle = [];
  static List<String> dealOfferText = [];
  static List<String> dealerPrice = [];
  static List<String> dealYouSpend = [];
  static List<String> dealCashback = [];
  static List<String> dealYouReceive = [];
  static List<String> dealOfferLink = [];
  static List<String> dealOrderQuantity = [];
  static List<String> dealStatus = [];
  static List<String> dealStoreLogo = [];

  static Future<void> getDealsByStores(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getDealsByStores,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getDealsByStore :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["deals"];
      int len = getJsonLength(jsonData);
      customPrint("DealsByStore len :: $len");
      dealStoreId.clear();
      dealId.clear();
      dealerId.clear();
      dealTitle.clear();
      dealShortDescription.clear();
      dealDescription.clear();
      dealImage.clear();
      dealTotalEarnings.clear();
      dealOfferTitle.clear();
      dealOfferText.clear();
      dealerPrice.clear();
      dealYouSpend.clear();
      dealCashback.clear();
      dealYouReceive.clear();
      dealOfferLink.clear();
      dealOrderQuantity.clear();
      dealStatus.clear();
      dealStoreLogo.clear();
      for (int i = 0; i < len; i++) {
        dealId.add(jsonData[i]["id"].toString());
        dealStoreId.add(jsonData[i]["store_id"].toString());
        dealerId.add(jsonData[i]["dealer_id"].toString());
        dealTitle.add(jsonData[i]["title"].toString());
        dealShortDescription.add(jsonData[i]["short_description"].toString());
        dealDescription.add(jsonData[i]["description"].toString());
        dealImage.add(DatabaseApi.imageUrl + jsonData[i]["image"].toString());
        dealOfferTitle.add(jsonData[i]["offer_title"].toString());
        dealOfferText.add(jsonData[i]["offer_text"].toString());
        dealerPrice.add(jsonData[i]["dealers_price"].toString());
        dealYouSpend.add(jsonData[i]["you_will_spend"].toString());
        dealCashback.add(jsonData[i]["cashback"].toString());
        dealYouReceive.add(jsonData[i]["total_you_will_receive"].toString());
        dealTotalEarnings.add(jsonData[i]["total_earnings"].toString());
        dealOfferLink.add(jsonData[i]["offer_link"].toString());
        dealOrderQuantity.add(jsonData[i]["order_quantity"].toString());
        dealStatus.add(jsonData[i]["deal_status"].toString());
        dealStoreLogo
            .add(DatabaseApi.imageUrl + jsonData[i]["store_logo"].toString());
      }
    });
  }

  /// Get Deals by Store Id
  static Future<void> getDealsByStoresId(
      BuildContext context, String storeId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "store_id": storeId,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getDealsByStore,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getDealsByStoresId :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["deals"];
      int len = getJsonLength(jsonData);
      customPrint("DealsByStore len :: $len");
      dealStoreId.clear();
      dealId.clear();
      dealerId.clear();
      dealTitle.clear();
      dealShortDescription.clear();
      dealDescription.clear();
      dealImage.clear();
      dealTotalEarnings.clear();
      dealOfferTitle.clear();
      dealOfferText.clear();
      dealerPrice.clear();
      dealYouSpend.clear();
      dealCashback.clear();
      dealYouReceive.clear();
      dealOfferLink.clear();
      dealOrderQuantity.clear();
      dealStatus.clear();
      dealStoreLogo.clear();
      for (int i = 0; i < len; i++) {
        dealId.add(jsonData[i]["id"].toString());
        dealStoreId.add(jsonData[i]["store_id"].toString());
        dealerId.add(jsonData[i]["dealer_id"].toString());
        dealTitle.add(jsonData[i]["title"].toString());
        dealShortDescription.add(jsonData[i]["short_description"].toString());
        dealDescription.add(jsonData[i]["description"].toString());
        dealImage.add(DatabaseApi.imageUrl + jsonData[i]["image"].toString());
        dealOfferTitle.add(jsonData[i]["offer_title"].toString());
        dealOfferText.add(jsonData[i]["offer_text"].toString());
        dealerPrice.add(jsonData[i]["dealers_price"].toString());
        dealYouSpend.add(jsonData[i]["you_will_spend"].toString());
        dealCashback.add(jsonData[i]["cashback"].toString());
        dealYouReceive.add(jsonData[i]["total_you_will_receive"].toString());
        dealTotalEarnings.add(jsonData[i]["total_earnings"].toString());
        dealOfferLink.add(jsonData[i]["offer_link"].toString());
        dealOrderQuantity.add(jsonData[i]["order_quantity"].toString());
        dealStatus.add(jsonData[i]["deal_status"].toString());
        dealStoreLogo
            .add(DatabaseApi.imageUrl + jsonData[i]["store_logo"].toString());
      }
    });
  }

  ///-----------card
  static List<String> cardName = [];
  static List<String> cardImage = [];
  static List<String> cardId = [];
  static List<String> cardBankId = [];
  static List<String> cardDateTime = [];
  static List<String> cardBankName = [];

  ///SBI
  static List<String> cardSBI = [];
  static List<String> cardSBIName = [];
  static List<String> cardSBIImage = [];
  static List<String> cardSBIId = [];
  static List<String> cardSBIBankId = [];
  static List<String> cardSBIDateTime = [];

  ///HDFC
  static List<String> cardHDFC = [];
  static List<String> cardHDFCName = [];
  static List<String> cardHDFCImage = [];
  static List<String> cardHDFCId = [];
  static List<String> cardHDFCBankId = [];
  static List<String> cardHDFCDateTime = [];

  ///Axis
  static List<String> cardAxis = [];
  static List<String> cardAxisName = [];
  static List<String> cardAxisImage = [];
  static List<String> cardAxisId = [];
  static List<String> cardAxisBankId = [];
  static List<String> cardAxisDateTime = [];

  ///ICICI
  static List<String> cardICICI = [];
  static List<String> cardICICIName = [];
  static List<String> cardICICIImage = [];
  static List<String> cardICICIId = [];
  static List<String> cardICICIBankId = [];
  static List<String> cardICICIDateTime = [];

  static Future<void> getBankCards(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getBankCards,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getBankCards :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["bank_cards"];
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      cardName.clear();
      cardImage.clear();
      cardId.clear();
      cardDateTime.clear();
      cardBankId.clear();
      cardBankName.clear();
      for (int i = 0; i < len; i++) {
        switch (jsonData[i]["bank_name"].toString()) {
          case "State bank of india":
            cardSBIId.add(jsonData[i]["id"].toString());
            cardSBIBankId.add(jsonData[i]["bank_id"].toString());
            cardSBIImage.add(
                DatabaseApi.imageUrl + jsonData[i]["card_image"].toString());
            cardSBIName.add(jsonData[i]["card_name"].toString());
            cardSBIDateTime.add(jsonData[i]["date_time"].toString());
            cardSBI.add(jsonData[i]["bank_name"].toString());
            break;
          case "Axis Bank":
            cardAxisId.add(jsonData[i]["id"].toString());
            cardAxisBankId.add(jsonData[i]["bank_id"].toString());
            cardAxisImage.add(
                DatabaseApi.imageUrl + jsonData[i]["card_image"].toString());
            cardAxisName.add(jsonData[i]["card_name"].toString());
            cardAxisDateTime.add(jsonData[i]["date_time"].toString());
            cardAxis.add(jsonData[i]["bank_name"].toString());
            break;
          case "HDFC Bank":
            cardHDFCId.add(jsonData[i]["id"].toString());
            cardHDFCBankId.add(jsonData[i]["bank_id"].toString());
            cardHDFCImage.add(
                DatabaseApi.imageUrl + jsonData[i]["card_image"].toString());
            cardHDFCName.add(jsonData[i]["card_name"].toString());
            cardHDFCDateTime.add(jsonData[i]["date_time"].toString());
            cardHDFC.add(jsonData[i]["bank_name"].toString());
            break;
          case "ICICI":
            cardICICIId.add(jsonData[i]["id"].toString());
            cardICICIBankId.add(jsonData[i]["bank_id"].toString());
            cardICICIImage.add(
                DatabaseApi.imageUrl + jsonData[i]["card_image"].toString());
            cardICICIName.add(jsonData[i]["card_name"].toString());
            cardICICIDateTime.add(jsonData[i]["date_time"].toString());
            cardICICI.add(jsonData[i]["bank_name"].toString());
            break;
        }

        cardId.add(jsonData[i]["id"].toString());
        cardBankId.add(jsonData[i]["bank_id"].toString());
        cardImage
            .add(DatabaseApi.imageUrl + jsonData[i]["card_image"].toString());
        cardName.add(jsonData[i]["card_name"].toString());
        cardDateTime.add(jsonData[i]["date_time"].toString());
        cardBankName.add(jsonData[i]["bank_name"].toString());
      }
      customPrint("cardSBI :: $cardSBI");
    });
  }

  ///Update Cards
  static Future<String> updateBankCard(
      BuildContext context, String cardId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "card_id": cardId,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.updateBankCard,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("updateBankCard :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      // final jsonData = jsonDecode(value.data)["orders"];
      // int len = getJsonLength(jsonData);
      // customPrint("len :: $len");
      return "1";
    });
  }

  ///wallet
  static String walletTotalEarnings = "NA";
  static String walletTotalBalance = "NA";
  static String walletBalance = "NA";

  static Future<void> getWalletDetails(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getWalletDetails,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getWalletDetails :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data);
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      walletTotalBalance = jsonData["total_balance"].toString();
      walletTotalEarnings = jsonData["total_earnings"].toString();
      walletBalance = jsonData["wallet"].toString();

      // walletBankName.add(jsonData[i]["bank_name"].toString());
      // walletBankAccountNumber.add(jsonData[i]["bank_account_number"].toString());
    });
  }

  /// Create Order

  static String orderId = "NA";
  static String orderDealerId = "NA";
  static String orderFullName = "NA";
  static String orderAddressLine1 = "NA";
  static String orderAddressLine2 = "NA";
  static String orderPincode = "NA";
  static String orderCity = "NA";
  static String orderState = "NA";
  static String orderCountry = "NA";
  static String orderGst = "NA";

  static Future<void> createOrder(String dealId, BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "deal_id": dealId
    };
    customPrint("jsonData :: $jsonData");
    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.createAOrder,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("createOrder :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data);
      final jsonAddressData = jsonDecode(value.data)["deal_address_details"];

      orderId = jsonData["order_id"].toString();
      orderDealerId = jsonAddressData["dealer_id"].toString();
      orderFullName = jsonAddressData["full_name"].toString();
      orderAddressLine1 = jsonAddressData["address1"].toString();
      orderAddressLine2 = jsonAddressData["address2"].toString();
      orderCity = jsonAddressData["city"].toString();
      orderState = jsonAddressData["state"].toString();
      orderPincode = jsonAddressData["pincode"].toString();
      orderCountry = jsonAddressData["country"].toString();
      orderGst = jsonData["gst_number"].toString();
    });
  }

  ///Withdraw to bank account
  static Future<String> withdrawalRequests(
      BuildContext context, String orderId) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "order_id": orderId,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.withdrawalRequests,
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

  ///Support
  static Future<String> supportForm(
      BuildContext context, String subject, String message) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "subject": subject,
      "message": message,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.supportForm,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("supportForm :: ${value.data}");
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

  ///Update Bank Details
  static Future<String> updateBankDetails(
      BuildContext context,
      String bankFullName,
      String bankName,
      String bankAccountNumber,
      String bankIfsc) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "bank_fullname": bankFullName,
      "bank_name": bankName,
      "bank_account_number": bankAccountNumber,
      "bank_ifsc": bankIfsc,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.updateBankDetails,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("updateBankDetails :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      return "1";
    });
  }

  ///Update Address Details
  static Future<String> updateAddressDetails(
      BuildContext context,
      String address1,
      String address2,
      String landmark,
      String city,
      String pincode) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "address": address1,
      "address2": address2,
      "landmark": landmark,
      "city": city,
      "pincode": pincode,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.updateMyAddress,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("updateAddressDetails :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      return "1";
    });
  }

  ///Update Address Details
  static Future<String> updatePassword(BuildContext context, String password,
      String newPassword, String confirmPassword) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
      "password": password,
      "new_password": newPassword,
      "confirm_new_password": confirmPassword,
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.updatePassword,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("updatePassword :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return "0";
      }
      return "1";
    });
  }

  ///--------------------------Get Stores List--------------------------
  static List<String> storeId = [];
  static List<String> storeImage = [];

  static Future<void> getStoresList(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getStores,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getStoresList :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["stores"];
      int len = getJsonLength(jsonData);
      customPrint("len :: $len");
      storeId.clear();
      storeImage.clear();
      for (int i = 0; i < len; i++) {
        storeId.add(jsonData[i]["id"].toString());
        storeImage.add(DatabaseApi.imageUrl + jsonData[i]["image"].toString());
      }

      customPrint("storeImage :: $storeImage");
    });
  }
}

class UserDetails {
  ///User Details
  static String firstName = "NA";
  static String lastName = "NA";
  static String phoneNumber = "NA";
  static String email = "NA";
  static String profilePicture = "NA";
  static String pan = "NA";
  static String wallet = "NA";
  static String bankFullName = "NA";
  static String bankName = "NA";
  static String bankAccountNumber = "NA";
  static String bankAccountIfsc = "NA";
  static String addressLine1 = "NA";
  static String addressLine2 = "NA";
  static String landmark = "NA";
  static String city = "NA";
  static String pincode = "NA";
  static String playerId = "NA";
  static String cardId = "NA";

  static Future<void> getUserDetails(BuildContext context) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": prefs.getString(LocalStorage.userAuth) ?? "",
    };

    customPrint("jsonData :: $jsonData");

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.getNavbarData,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("getUserDetails :: ${value.data}");
      if (jsonDecode(value.data)["result"].toString() == "0") {
        showSnackbar(
            context, "Error : ${jsonDecode(value.data)["msg"]}", colorError);
        return;
      }
      final jsonData = jsonDecode(value.data)["user_data"];

      firstName = jsonData["first_name"].toString();
      lastName = jsonData["last_name"].toString();
      phoneNumber = jsonData["phone_number"].toString();
      email = jsonData["email"].toString();
      profilePicture = jsonData["profile_picture"].toString();
      pan = jsonData["pan"].toString();
      wallet = jsonData["wallet"].toString();
      bankFullName = jsonData["bank_fullname"].toString();
      bankName = jsonData["bank_name"].toString();
      bankAccountNumber = jsonData["bank_account_number"].toString();
      bankAccountIfsc = jsonData["bank_ifsc"].toString();
      addressLine1 = jsonData["address"].toString();
      addressLine2 = jsonData["address2"].toString();
      landmark = jsonData["landmark"].toString();
      city = jsonData["city"].toString();
      pincode = jsonData["pincode"].toString();
      cardId = jsonData["card_id"].toString();
      playerId = jsonData["player_id"].toString();
    });
  }
}
