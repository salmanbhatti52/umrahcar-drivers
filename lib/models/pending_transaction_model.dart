

class PendingTransactiontModel {
  String? status;
  List<Datum>? data;

  PendingTransactiontModel({
    this.status,
    this.data,
  });

  factory PendingTransactiontModel.fromJson(Map<String, dynamic> json) => PendingTransactiontModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? usersDriversAccountsId;
  UsersDriversId? usersDriversId;
  AccountsHeadsId? accountsHeadsId;
  String? description;
  String? txnType;
  String? txnDate;
  String? amount;
  String? image;
  String? status;

  Datum({
    this.usersDriversAccountsId,
    this.usersDriversId,
    this.accountsHeadsId,
    this.description,
    this.txnType,
    this.txnDate,
    this.amount,
    this.image,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    usersDriversAccountsId: json["users_drivers_accounts_id"],
    usersDriversId: UsersDriversId.fromJson(json["users_drivers_id"]),
    accountsHeadsId: AccountsHeadsId.fromJson(json["accounts_heads_id"]),
    description: json["description"],
    txnType: json["txn_type"],
    txnDate: json["txn_date"],
    amount: json["amount"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_accounts_id": usersDriversAccountsId,
    "users_drivers_id": usersDriversId!.toJson(),
    "accounts_heads_id": accountsHeadsId!.toJson(),
    "description": description,
    "txn_type": txnType,
    "txn_date": txnDate,
    "amount": amount,
    "image": image,
    "status": status,
  };
}

class AccountsHeadsId {
  String? accountsHeadsId;
  String? name;
  String? roles;
  String? status;

  AccountsHeadsId({
    this.accountsHeadsId,
    this.name,
    this.roles,
    this.status,
  });

  factory AccountsHeadsId.fromJson(Map<String, dynamic> json) => AccountsHeadsId(
    accountsHeadsId: json["accounts_heads_id"],
    name: json["name"],
    roles: json["roles"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "accounts_heads_id": accountsHeadsId,
    "name": name,
    "roles": roles,
    "status": status,
  };
}

class UsersDriversId {
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

  UsersDriversId({
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

  factory UsersDriversId.fromJson(Map<String, dynamic> json) => UsersDriversId(
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
