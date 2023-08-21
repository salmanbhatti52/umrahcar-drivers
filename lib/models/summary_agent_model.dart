// To parse this JSON data, do
//
//     final summaryDriversModel = summaryDriversModelFromJson(jsonString);

import 'dart:convert';

SummaryDriversModel summaryDriversModelFromJson(String str) => SummaryDriversModel.fromJson(json.decode(str));

String summaryDriversModelToJson(SummaryDriversModel data) => json.encode(data.toJson());

class SummaryDriversModel {
  String? status;
  Data? data;

  SummaryDriversModel({
    this.status,
    this.data,
  });

  factory SummaryDriversModel.fromJson(Map<String, dynamic> json) => SummaryDriversModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? usersDriversId;
  String? driversName;
  String? status;
  int? totalCompletedTrips;
  int? totalDriversFare;
  int? totalDriversReceivingsDebit;
  int? totalDriversReceivingsCredit;
  int? totalDriversBalance;

  Data({
    this.usersDriversId,
    this.driversName,
    this.status,
    this.totalCompletedTrips,
    this.totalDriversFare,
    this.totalDriversReceivingsDebit,
    this.totalDriversReceivingsCredit,
    this.totalDriversBalance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersDriversId: json["users_drivers_id"],
    driversName: json["drivers_name"],
    status: json["status"],
    totalCompletedTrips: json["total_completed_trips"],
    totalDriversFare: json["total_drivers_fare"],
    totalDriversReceivingsDebit: json["total_drivers_receivings_debit"],
    totalDriversReceivingsCredit: json["total_drivers_receivings_credit"],
    totalDriversBalance: json["total_drivers_balance"],
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_id": usersDriversId,
    "drivers_name": driversName,
    "status": status,
    "total_completed_trips": totalCompletedTrips,
    "total_drivers_fare": totalDriversFare,
    "total_drivers_receivings_debit": totalDriversReceivingsDebit,
    "total_drivers_receivings_credit": totalDriversReceivingsCredit,
    "total_drivers_balance": totalDriversBalance,
  };
}
