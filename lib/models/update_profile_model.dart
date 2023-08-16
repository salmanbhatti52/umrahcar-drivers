

class UpdateProfileModel {
  String? usersDriversId;
  String? name;
  String? email;
  String? password;
  String? contact;
  String? whatsapp;
  String? city;
  String? notificationSwitch;
  String? image;

  UpdateProfileModel({
    this.usersDriversId,
    this.name,
    this.email,
    this.password,
    this.contact,
    this.whatsapp,
    this.city,
    this.notificationSwitch,
    this.image,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    usersDriversId: json["users_drivers_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    contact: json["contact"],
    whatsapp: json["whatsapp"],
    city: json["city"],
    notificationSwitch: json["notification_switch"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_id": usersDriversId,
    "name": name,
    "email": email,
    "password": password,
    "contact": contact,
    "whatsapp": whatsapp,
    "city": city,
    "notification_switch": notificationSwitch,
    "image": image,
  };
}
