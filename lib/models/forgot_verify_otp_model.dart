



class ForgotOtpVerifyModel {
  String? status;
  String? message;

  ForgotOtpVerifyModel({
    this.status,
    this.message,
  });

  factory ForgotOtpVerifyModel.fromJson(Map<String, dynamic> json) => ForgotOtpVerifyModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
