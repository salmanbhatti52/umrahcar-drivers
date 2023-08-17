

class UpdateDriverLocationModel {
  String? status;
  String? message;

  UpdateDriverLocationModel({
    this.status,
    this.message,
  });

  factory UpdateDriverLocationModel.fromJson(Map<String, dynamic> json) => UpdateDriverLocationModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
