import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/models/distance_calculate_model.dart';
import 'package:umrahcar_driver/models/driver_status_model.dart';
import 'package:umrahcar_driver/models/update_driver_location_model.dart';

import '../models/add_card_model.dart';
import '../models/forgot_password_otp_model.dart';
import '../models/forgot_verify_otp_model.dart';
import '../models/get_all_system_data_model.dart';
import '../models/get_booking_list_model.dart';
import '../models/get_chat_model.dart';
import '../models/get_driver_profile.dart';
import '../models/login_model.dart';
import '../models/pending_transaction_model.dart';
import '../models/send_message_model.dart';
import '../models/sign_up_model.dart';
import '../models/summary_agent_model.dart';
import '../models/update_profile_model.dart';
import '../utils/const.dart';


Future<http.Response> sendPostRequest ({required String action, Map<String, dynamic>? data}){
  debugPrint(action);
  print(data);

  return  http.post(
      Uri.parse(baseUrl + action),headers: <String,String>{
    // 'Content-Type': 'application/json; charset=UTF-8',
    'Content-Type': 'application/json',
  },body: jsonEncode(data)
  );
}

class DioClient {
  final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final _sharedPref = await SharedPreferences.getInstance();
        if (_sharedPref.containsKey('userId')) {
          options.headers["Authorization"] =
          "Bearer ${_sharedPref.getString('userId')}";
        }
        return handler.next(options);
      }),
    );

  Future<LoginModel> login(Map<String,dynamic> model,BuildContext context) async {
    print("Login Payloads: $model");
    try {
      final response =
      await _dio.post('$baseUrl/login_drivers', data: model);
      if (response.statusCode == 200) {
        print("login API RES: ${response.data}");
        var res= LoginModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email or Password is incorrect")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Phone Number is incorrect")));

      rethrow;
    }
  }

  Future<SignUpModel> signUp(Map<String,dynamic> model,BuildContext context) async {
    print("mapData: $model");
    try {
      final response =
      await _dio.post('$baseUrl/signup_drivers', data: model);
      if (response.statusCode == 200) {
        print("Signup Res: ${response.data}");
        var res= SignUpModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already exist")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email already exist")));

      rethrow;
    }
  }

  Future<GetDriverProfile> getProfile(String? uid,BuildContext context) async {
    String url= "$baseUrl/get_details_drivers/$uid";
    print("url: $url");

    try {
      final response = await _dio.post(url);
      if (response.statusCode == 200) {
        print("Get Profile Res: ${response.data.toString()}");
        var res= GetDriverProfile.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Data Found")));

      rethrow;
    }
  }


  Future<ForgotOtpVerifyModel> changeUserPassword(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/change_user_password_drivers', data: model);
      if (response.statusCode == 200) {
        print("change Password Res: ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Old password is wrong")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<UpdateProfileModel> updateProfile(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/update_profile_drivers', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res= UpdateProfileModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Fields are needed")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateDriverLocationModel> updateDriverLocation(Map<String,dynamic> model,BuildContext context) async {

    print('update Location payloads: $model');
    try {
      final response =
      await _dio.post('$baseUrl/update_locations_drivers', data: model);
      if (response.statusCode == 200) {
        print("Update Driver Location RES:  ${response.data}");
        var res= UpdateDriverLocationModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All Fields are needed")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<GetBookingListModel> getBookingupcoming(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_drivers_upcoming', data: model);
      if (response.statusCode == 200) {
        print("Upcoming Bookings Res ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
         // Handle non-200 status codes
      print("Error Upcoming Bookings: ${response.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
      return GetBookingListModel(); // Return a default instance or handle the error appropriately
      }
    } on DioError catch (e) {
       if (e.response?.statusCode == 400) {
      // Handle the 400 error specifically
      print("Bad Request Error Upcoming: ${e.response?.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bad Request Error. Please check your request.")));
    } else {
      // Handle other errors
      print("Error Upcoming: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
    }
    return GetBookingListModel();
    }
  }
  Future<GetBookingListModel> getBookingOngoing(Map<String, dynamic> model, BuildContext context) async {
 try {
    final response = await _dio.post('$baseUrl/get_bookings_drivers_ongoing', data: model);
    if (response.statusCode == 200) {
      print("Ongoing Booking Res: ${response.data}");
      var res = GetBookingListModel.fromJson(response.data);
      return res;
    } else {
      // Handle non-200 status codes
      print("Error Ongoing: ${response.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
      return GetBookingListModel(); // Return a default instance or handle the error appropriately
    }
 } on DioError catch (e) {
    if (e.response?.statusCode == 400) {
      // Handle the 400 error specifically
      print("Bad Request  Error Ongoing: ${e.response?.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bad Request Error. Please check your request.")));
    } else {
      // Handle other errors
      print("Error  Ongoing: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
    }
    return GetBookingListModel(); // Return a default instance or handle the error appropriately
 }
}


  Future<GetBookingListModel> getBookingCompleted(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_bookings_drivers_completed', data: model);
      if (response.statusCode == 200) {
        print("Completed Bookings Res: ${response.data}");
        var res= GetBookingListModel.fromJson(response.data);
        return res;
      }
      else  {
       print("Error: ${response.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
      return GetBookingListModel(); // Return a default instance or handle the error appropriately
      }
    }on DioError catch (e) {
    if (e.response?.statusCode == 400) {
      // Handle the 400 error specifically
      print("Bad Request Error: ${e.response?.data}");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bad Request Error. Please check your request.")));
    } else {
      // Handle other errors
      print("Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred. Please try again.")));
    }
    return GetBookingListModel(); // Return a default instance or handle the error appropriately
 }
  }
  Future<GetChatModel> getChat(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_messages', data: model);
      if (response.statusCode == 200) {
        print("Get Messages Res: ${response.data}");
        var res= GetChatModel.fromJson(response.data);
        return res;
      }
      else  {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }


  Future<SendMessageModel> sendMessage(Map<String,dynamic> model,BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/send_messages', data: model);
      if (response.statusCode == 200) {
        print("Send Msg Res: ${response.data}");
        var res= SendMessageModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Chat Found")));

      rethrow;
    }
  }





  Future<ForgotPasswordOtpModel> forgotPasswordOtp(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/reset_password_drivers', data: model);
      if (response.statusCode == 200) {
        print("Reset Password Drivers Res: ${response.data}");
        var res= ForgotPasswordOtpModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email does not exists.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<ForgotOtpVerifyModel> verifyForgotPasswordOtp(Map<String,dynamic> model,BuildContext context) async {

    try {
      final response =
      await _dio.post('$baseUrl/verify_otp_drivers', data: model);
      if (response.statusCode == 200) {
        print("Verify OTP Drivers Res: ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<ForgotOtpVerifyModel> resetNewPassword(Map<String,dynamic> model,BuildContext context) async {
print("model: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/reset_password_set_drivers', data: model);
      print("code status: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Reset Password Set Drivers Res: ${response.data}");
        var res= ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<GetAllSystemData> getSystemAllData(BuildContext context) async {
    try {
      final response =
      await _dio.post('$baseUrl/get_all_system_data',);
      if (response.statusCode == 200) {
        print("Get System Data Res: ${response.data}");
        var res= GetAllSystemData.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }



  Future<SummaryDriversModel> summaryAgent(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: $model");
    try {
      final response =
      await _dio.post('$baseUrl/summary_drivers',data: model);
      if (response.statusCode == 200) {
        print("Summary Drivers Res: ${response.data}");
        var res= SummaryDriversModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }
  Future<PendingTransactiontModel> pendingTransactions(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/transactions_drivers',data: model);
      if (response.statusCode == 200) {
        print("Pending Transactions Res: ${response.data}");
        var res= PendingTransactiontModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }

  Future<AddCardModel> addCard(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/transactions_drivers_add',data: model);
      if (response.statusCode == 200) {
        print("Add Drivers Transactions Res: ${response.data}");
        var res= AddCardModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }
  Future<DriverStatusModel> driverStatus(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/drivers_status_update',data: model);
      if (response.statusCode == 200) {
        print("Driver Status Update Res: ${response.data}");
        var res= DriverStatusModel.fromJson(response.data);
        return res;
      }
      else  {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Status Changed.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No Status Changed.")));

      rethrow;
    }
  }
  Future<DriverStatusModel> deleteTransaction(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/transactions_drivers_delete',data: model);
      if (response.statusCode == 200) {
        print("Delete Transactions Res: ${response.data}");
        var res= DriverStatusModel.fromJson(response.data);
        return res;
      }
      else  {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unable To Delete Transaction. Only Pending transactions can be deleted")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unable To Delete Transaction. Only Pending transactions can be deleted")));

      rethrow;
    }

  }
  Future<DistanceCalculatorModel> distanceCalculate(Map<String?,dynamic?> model,BuildContext context) async {
    print("data: ${model}");
    try {
      final response =
      await _dio.post('$baseUrl/calculate_distance',data: model);
      if (response.statusCode == 200) {
        print("Calculate Distance Res: ${response.data}");
        var res= DistanceCalculatorModel.fromJson(response.data);
        return res;
      }
      else  {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unable To Delete Transaction. Only Pending transactions can be deleted")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unable To Delete Transaction. Only Pending transactions can be deleted")));

      rethrow;
    }
  }




}
