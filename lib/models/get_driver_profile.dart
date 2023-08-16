

class GetDriverProfile {
  String? status;
  Data? data;

  GetDriverProfile({
    this.status,
    this.data,
  });

  factory GetDriverProfile.fromJson(Map<String, dynamic> json) => GetDriverProfile(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  UserData? userData;

  Data({
    this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData!.toJson(),
  };
}

class UserData {
  String? usersDriversId;
  String? parentId;
  String? onesignalId;
  String? longitude;
  String? lattitude;
  String? walletAmount;
  String? driversType;
  String? companyName;
  String? name;
  String? email;
  String? password;
  String? contact;
  String? whatsapp;
  String? city;
  String? rating;
  String? image;
  String? status;
  String? resetOtp;
  String? notificationSwitch;
  String? dateAdded;
  String? dateModified;

  UserData({
    this.usersDriversId,
    this.parentId,
    this.onesignalId,
    this.longitude,
    this.lattitude,
    this.walletAmount,
    this.driversType,
    this.companyName,
    this.name,
    this.email,
    this.password,
    this.contact,
    this.whatsapp,
    this.city,
    this.rating,
    this.image,
    this.status,
    this.resetOtp,
    this.notificationSwitch,
    this.dateAdded,
    this.dateModified,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    usersDriversId: json["users_drivers_id"],
    parentId: json["parent_id"],
    onesignalId: json["onesignal_id"],
    longitude: json["longitude"],
    lattitude: json["lattitude"],
    walletAmount: json["wallet_amount"],
    driversType: json["drivers_type"],
    companyName: json["company_name"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    contact: json["contact"],
    whatsapp: json["whatsapp"],
    city: json["city"],
    rating: json["rating"],
    image: json["image"],
    status: json["status"],
    resetOtp: json["reset_otp"],
    notificationSwitch: json["notification_switch"],
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_id": usersDriversId,
    "parent_id": parentId,
    "onesignal_id": onesignalId,
    "longitude": longitude,
    "lattitude": lattitude,
    "wallet_amount": walletAmount,
    "drivers_type": driversType,
    "company_name": companyName,
    "name": name,
    "email": email,
    "password": password,
    "contact": contact,
    "whatsapp": whatsapp,
    "city": city,
    "rating": rating,
    "image": image,
    "status": status,
    "reset_otp": resetOtp,
    "notification_switch": notificationSwitch,
    "date_added": dateAdded,
    "date_modified": dateModified,
  };
}
