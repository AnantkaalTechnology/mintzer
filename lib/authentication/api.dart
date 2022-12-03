import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mintzer/api/database_api.dart';
import 'package:mintzer/globalVariable.dart';
import 'package:mintzer/util/constants.dart';

class AuthApi {
  static Future<Map<String, dynamic>> loginUser(String number) async {
    final jsonData = {
      "auth_key": authKey,
      "mobile_number": number,
      "player_id": ""
    };

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.userLogin,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("loginUser :: ${value.data}");
      return jsonDecode(value.data);
    });
  }

  static Future<Map<String, dynamic>> userLoginOtp(
      Map<String, dynamic> data, String otp) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": data['user_auth'],
      "otp": otp
    };

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.userLoginOtp,
            data: jsonEncode(jsonData))
        .then((value) async {
      customPrint("userLoginOtp :: ${value.data}");
      return jsonDecode(value.data);
    });
  }

  static Future<Map<String, dynamic>> userRegister(
      String firstName, String lastName, String phoneNumber, String pan) async {
    final jsonData = {
      "auth_key": authKey,
      "first_name": firstName,
      "last_name": lastName,
      "mobile_number": phoneNumber,
      "pan": pan
    };

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.userRegistration,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("userRegister :: ${value.data}");
      return jsonDecode(value.data);
    });
  }

  static Future<Map<String, dynamic>> userRegistrationOtp(
      Map<String, dynamic> data, String otp) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": data['user_auth'],
      "otp": otp
    };

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.userRegistrationOtp,
            data: jsonEncode(jsonData))
        .then((value) async {
      customPrint("userRegistrationOtp :: ${value.data}");
      return jsonDecode(value.data);
    });
  }

  static Future<Map<String, dynamic>> userOtpResend(
      Map<String, dynamic> data) async {
    final jsonData = {
      "auth_key": authKey,
      "user_auth": data['user_auth'],
    };

    return await Dio()
        .post(DatabaseApi.mainUrl + DatabaseApi.resendOtp,
            data: jsonEncode(jsonData))
        .then((value) {
      customPrint("userOtpResend :: ${value.data}");
      return jsonDecode(value.data);
    });
  }
}
