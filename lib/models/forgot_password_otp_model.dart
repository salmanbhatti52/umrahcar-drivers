

import 'dart:convert';


class ForgotPasswordOtpModel {
  String? status;
  Data? data;

  ForgotPasswordOtpModel({
    this.status,
    this.data,
  });

  factory ForgotPasswordOtpModel.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int? otp;
  String? usersDriversId;
  String? message;

  Data({
    this.otp,
    this.usersDriversId,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otp: json["otp"],
    usersDriversId: json["users_drivers_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "users_drivers_id": usersDriversId,
    "message": message,
  };
}
