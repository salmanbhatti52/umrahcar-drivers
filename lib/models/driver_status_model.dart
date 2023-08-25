

class DriverStatusModel {
  String? status;
  String? message;

  DriverStatusModel({
    this.status,
    this.message,
  });

  factory DriverStatusModel.fromJson(Map<String, dynamic> json) => DriverStatusModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
