

class SendMessageModel {
  String? status;
  String? data;

  SendMessageModel({
    this.status,
    this.data,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) => SendMessageModel(
    status: json["status"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
