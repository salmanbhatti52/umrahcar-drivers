

class AddCardModel {
  String? status;
  String? message;

  AddCardModel({
    this.status,
    this.message,
  });

  factory AddCardModel.fromJson(Map<String, dynamic> json) => AddCardModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
