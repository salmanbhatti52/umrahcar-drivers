

class GetChatModel {
  String? status;
  Data? data;

  GetChatModel({
    this.status,
    this.data,
  });

  factory GetChatModel.fromJson(Map<String, dynamic> json) => GetChatModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  BookingData? bookingData;
  List<Message>? message;

  Data({
    this.bookingData,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingData: BookingData.fromJson(json["booking_data"]),
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "booking_data": bookingData!.toJson(),
    "message": List<dynamic>.from(message!.map((x) => x.toJson())),
  };
}

class BookingData {
  String? bookingsId;
  String? parentId;
  String? usersAgentsId;
  String? name;
  String? contact;
  String? whatsapp;
  String? bookedBy;
  String? bookingDate;
  String? bookingTime;
  String? routesId;
  String? routesDetails;
  String? pickupHotel;
  String? dropoffHotel;
  String? noOfPassengers;
  String? noOfAdults;
  String? noOfChilds;
  String? noOfInfants;
  String? pickupLocation;
  String? dropoffLocation;
  String? pickupDate;
  String? pickupTime;
  String? flightCompaniesId;
  String? flightNumber;
  String? flightDetails;
  String? flightDate;
  String? flightTime;
  String? actualFare;
  String? agentFare;
  String? bookedFare;
  String? cashReceiveFromCustomer;
  String? extraInformation;
  String? visaTypesId;
  String? serviceType;
  String? paymentType;
  String? dateAdded;
  String? dateModified;
  String?  finalStatus;
  String?  finalStatusOther;
  String?  paymentStatus;
  String?  completedStatus;
  String?  status;
  String?  cancelReason;
  String?  driverTripStatus;
  String?  pickupDatetime;
  String?  source;

  BookingData({
    this.bookingsId,
    this.parentId,
    this.usersAgentsId,
    this.name,
    this.contact,
    this.whatsapp,
    this.bookedBy,
    this.bookingDate,
    this.bookingTime,
    this.routesId,
    this.routesDetails,
    this.pickupHotel,
    this.dropoffHotel,
    this.noOfPassengers,
    this.noOfAdults,
    this.noOfChilds,
    this.noOfInfants,
    this.pickupLocation,
    this.dropoffLocation,
    this.pickupDate,
    this.pickupTime,
    this.flightCompaniesId,
    this.flightNumber,
    this.flightDetails,
    this.flightDate,
    this.flightTime,
    this.actualFare,
    this.agentFare,
    this.bookedFare,
    this.cashReceiveFromCustomer,
    this.extraInformation,
    this.visaTypesId,
    this.serviceType,
    this.paymentType,
    this.dateAdded,
    this.dateModified,
    this.finalStatus,
    this.finalStatusOther,
    this.paymentStatus,
    this.completedStatus,
    this.status,
    this.cancelReason,
    this.driverTripStatus,
    this.pickupDatetime,
    this.source,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    bookingsId: json["bookings_id"],
    parentId: json["parent_id"],
    usersAgentsId: json["users_agents_id"],
    name: json["name"],
    contact: json["contact"],
    whatsapp: json["whatsapp"],
    bookedBy: json["booked_by"],
    bookingDate: json["booking_date"],
    bookingTime: json["booking_time"],
    routesId: json["routes_id"],
    routesDetails: json["routes_details"],
    pickupHotel: json["pickup_hotel"],
    dropoffHotel: json["dropoff_hotel"],
    noOfPassengers: json["no_of_passengers"],
    noOfAdults: json["no_of_adults"],
    noOfChilds: json["no_of_childs"],
    noOfInfants: json["no_of_infants"],
    pickupLocation: json["pickup_location"],
    dropoffLocation: json["dropoff_location"],
    pickupDate: json["pickup_date"],
    pickupTime: json["pickup_time"],
    flightCompaniesId: json["flight_companies_id"],
    flightNumber: json["flight_number"],
    flightDetails: json["flight_details"],
    flightDate:json["flight_date"],
    flightTime: json["flight_time"],
    actualFare: json["actual_fare"],
    agentFare: json["agent_fare"],
    bookedFare: json["booked_fare"],
    cashReceiveFromCustomer: json["cash_receive_from_customer"],
    extraInformation: json["extra_information"],
    visaTypesId: json["visa_types_id"],
    serviceType: json["service_type"],
    paymentType: json["payment_type"],
    dateAdded: json["date_added"],
    dateModified:json["date_modified"],
    finalStatus: json["final_status"],
    finalStatusOther: json["final_status_other"],
    paymentStatus: json["payment_status"],
    completedStatus: json["completed_status"],
    status: json["status"],
    cancelReason: json["cancel_reason"],
    driverTripStatus: json["driver_trip_status"],
    pickupDatetime: json["pickup_datetime"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_id": bookingsId,
    "parent_id": parentId,
    "users_agents_id": usersAgentsId,
    "name": name,
    "contact": contact,
    "whatsapp": whatsapp,
    "booked_by": bookedBy,
    "booking_date": bookingDate,
    "booking_time": bookingTime,
    "routes_id": routesId,
    "routes_details": routesDetails,
    "pickup_hotel": pickupHotel,
    "dropoff_hotel": dropoffHotel,
    "no_of_passengers": noOfPassengers,
    "no_of_adults": noOfAdults,
    "no_of_childs": noOfChilds,
    "no_of_infants": noOfInfants,
    "pickup_location": pickupLocation,
    "dropoff_location": dropoffLocation,
    "pickup_date": pickupDate,
    "pickup_time": pickupTime,
    "flight_companies_id": flightCompaniesId,
    "flight_number": flightNumber,
    "flight_details": flightDetails,
    "flight_date": flightDate,
    "flight_time": flightTime,
    "actual_fare": actualFare,
    "agent_fare": agentFare,
    "booked_fare": bookedFare,
    "cash_receive_from_customer": cashReceiveFromCustomer,
    "extra_information": extraInformation,
    "visa_types_id": visaTypesId,
    "service_type": serviceType,
    "payment_type": paymentType,
    "date_added": dateAdded,
    "date_modified": dateModified,
    "final_status": finalStatus,
    "final_status_other": finalStatusOther,
    "payment_status": paymentStatus,
    "completed_status": completedStatus,
    "status": status,
    "cancel_reason": cancelReason,
    "driver_trip_status": driverTripStatus,
    "pickup_datetime": pickupDatetime,
    "source": source,
  };
}

class Message {
  String? bookingsChatId;
  String? bookingsId;
  String? usersDriversId;
  String? receiver;
  String? guestName;
  String? message;
  String? dateAdded;
  String? status;
  String? parentId;
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
  String? dateModified;
  DriversData? driversData;

  Message({
    this.bookingsChatId,
    this.bookingsId,
    this.usersDriversId,
    this.receiver,
    this.guestName,
    this.message,
    this.dateAdded,
    this.status,
    this.parentId,
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
    this.dateModified,
    this.driversData,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    bookingsChatId: json["bookings_chat_id"],
    bookingsId: json["bookings_id"],
    usersDriversId: json["users_drivers_id"],
    receiver: json["receiver"],
    guestName: json["guest_name"],
    message: json["message"],
    dateAdded:json["date_added"],
    status: json["status"],
    parentId: json["parent_id"],
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
    dateModified: json["date_modified"],
    driversData: json["drivers_data"] !=null ?DriversData.fromJson(json["drivers_data"]): null,
  );

  Map<String, dynamic> toJson() => {
    "bookings_chat_id": bookingsChatId,
    "bookings_id": bookingsId,
    "users_drivers_id": usersDriversId,
    "receiver": receiver,
    "guest_name": guestName,
    "message": message,
    "date_added": dateAdded,
    "status": status,
    "parent_id": parentId,
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
    "date_modified": dateModified,
    "drivers_data": driversData,
  };
}

class DriversData {
  String? usersDriversId;
  String? parentId;
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
  String? dateAdded;
  String? dateModified;

  DriversData({
    this.usersDriversId,
    this.parentId,
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
    this.dateAdded,
    this.dateModified,
  });

  factory DriversData.fromJson(Map<String, dynamic> json) => DriversData(
    usersDriversId: json["users_drivers_id"],
    parentId: json["parent_id"],
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
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
  );

  Map<String, dynamic> toJson() => {
    "users_drivers_id": usersDriversId,
    "parent_id": parentId,
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
    "date_added": dateAdded,
    "date_modified": dateModified,
  };
}
