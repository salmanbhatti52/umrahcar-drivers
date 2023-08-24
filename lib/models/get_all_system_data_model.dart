class GetAllSystemData {
  String? status;
  Data? data;

  GetAllSystemData({
    this.status,
    this.data,
  });

  factory GetAllSystemData.fromJson(Map<String, dynamic> json) => GetAllSystemData(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  List<FlightCompany>? flightCompanies;
  List<Vehicle>? vehicles;
  List<VisaType>? visaTypes;
  List<String>? serviceType;
  List<RoutesPickup>? routesPickup;
  List<Setting>? settings;
  List<AccountsHeads>? accountsHeadsAgents;
  List<AccountsHeads>? accountsHeadsDrivers;
  List<BookingsDriversStatus>? bookingsDriversStatus;

  Data({
    this.flightCompanies,
    this.vehicles,
    this.visaTypes,
    this.serviceType,
    this.routesPickup,
    this.settings,
    this.accountsHeadsAgents,
    this.accountsHeadsDrivers,
    this.bookingsDriversStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    flightCompanies: List<FlightCompany>.from(json["flight_companies"].map((x) => FlightCompany.fromJson(x))),
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    visaTypes: List<VisaType>.from(json["visa_types"].map((x) => VisaType.fromJson(x))),
    serviceType: List<String>.from(json["service_type"].map((x) => x)),
    routesPickup: List<RoutesPickup>.from(json["routes_pickup"].map((x) => RoutesPickup.fromJson(x))),
    settings: List<Setting>.from(json["settings"].map((x) => Setting.fromJson(x))),
    accountsHeadsAgents: List<AccountsHeads>.from(json["accounts_heads_agents"].map((x) => AccountsHeads.fromJson(x))),
    accountsHeadsDrivers: List<AccountsHeads>.from(json["accounts_heads_drivers"].map((x) => AccountsHeads.fromJson(x))),
    bookingsDriversStatus: List<BookingsDriversStatus>.from(json["bookings_drivers_status"].map((x) => BookingsDriversStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "flight_companies": List<dynamic>.from(flightCompanies!.map((x) => x.toJson())),
    "vehicles": List<dynamic>.from(vehicles!.map((x) => x.toJson())),
    "visa_types": List<dynamic>.from(visaTypes!.map((x) => x.toJson())),
    "service_type": List<dynamic>.from(serviceType!.map((x) => x)),
    "routes_pickup": List<dynamic>.from(routesPickup!.map((x) => x.toJson())),
    "settings": List<dynamic>.from(settings!.map((x) => x.toJson())),
    "accounts_heads_agents": List<dynamic>.from(accountsHeadsAgents!.map((x) => x.toJson())),
    "accounts_heads_drivers": List<dynamic>.from(accountsHeadsDrivers!.map((x) => x.toJson())),
    "bookings_drivers_status": List<dynamic>.from(bookingsDriversStatus!.map((x) => x.toJson())),
  };
}

class AccountsHeads {
  String? accountsHeadsId;
  String? name;
  String? roles;
  String? status;

  AccountsHeads({
    this.accountsHeadsId,
    this.name,
    this.roles,
    this.status,
  });

  factory AccountsHeads.fromJson(Map<String, dynamic> json) => AccountsHeads(
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
class BookingsDriversStatus {
  String? bookingsDriversStatusId;
  String? name;
  String? status;

  BookingsDriversStatus({
    this.bookingsDriversStatusId,
    this.name,
    this.status,
  });

  factory BookingsDriversStatus.fromJson(Map<String, dynamic> json) => BookingsDriversStatus(
    bookingsDriversStatusId: json["bookings_drivers_status_id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_drivers_status_id": bookingsDriversStatusId,
    "name": name,
    "status": status,
  };
}

class FlightCompany {
  String? flightCompaniesId;
  String? name;
  String? code;
  Status? status;

  FlightCompany({
    this.flightCompaniesId,
    this.name,
    this.code,
    this.status,
  });

  factory FlightCompany.fromJson(Map<String, dynamic> json) => FlightCompany(
    flightCompaniesId: json["flight_companies_id"],
    name: json["name"],
    code: json["code"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "flight_companies_id": flightCompaniesId,
    "name": name,
    "code": code,
    "status": statusValues.reverse[status],
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
  "Active": Status.ACTIVE
});

class RoutesPickup {
  String? routesPickupId;
  String? name;
  String? type;
  Status? status;

  RoutesPickup({
    this.routesPickupId,
    this.name,
    this.type,
    this.status,
  });

  factory RoutesPickup.fromJson(Map<String, dynamic> json) => RoutesPickup(
    routesPickupId: json["routes_pickup_id"],
    name: json["name"],
    type: json["type"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "routes_pickup_id": routesPickupId,
    "name": name,
    "type": type,
    "status": statusValues.reverse[status],
  };
}

class Setting {
  String? settingsId;
  String? type;
  String? description;

  Setting({
    this.settingsId,
    this.type,
    this.description,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    settingsId: json["settings_id"],
    type: json["type"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "settings_id": settingsId,
    "type": type,
    "description": description,
  };
}

class Vehicle {
  String? vehiclesId;
  String? name;
  String? noOfPassengers;
  String? featureImage;
  String? noOfBags;
  String? noOfDoors;
  String? ac;
  Status? status;

  Vehicle({
    this.vehiclesId,
    this.name,
    this.noOfPassengers,
    this.featureImage,
    this.noOfBags,
    this.noOfDoors,
    this.ac,
    this.status,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    vehiclesId: json["vehicles_id"],
    name: json["name"],
    noOfPassengers: json["no_of_passengers"],
    featureImage: json["feature_image"],
    noOfBags: json["no_of_bags"],
    noOfDoors: json["no_of_doors"],
    ac: json["ac"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "vehicles_id": vehiclesId,
    "name": name,
    "no_of_passengers": noOfPassengers,
    "feature_image": featureImage,
    "no_of_bags": noOfBags,
    "no_of_doors": noOfDoors,
    "ac": ac,
    "status": statusValues.reverse[status],
  };
}

class VisaType {
  String? visaTypesId;
  String? name;
  Status? status;

  VisaType({
    this.visaTypesId,
    this.name,
    this.status,
  });

  factory VisaType.fromJson(Map<String, dynamic> json) => VisaType(
    visaTypesId: json["visa_types_id"],
    name: json["name"],
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "visa_types_id": visaTypesId,
    "name": name,
    "status": statusValues.reverse[status],
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}