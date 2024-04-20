/// status : "success"
/// data : [{"bookings_id":"27","parent_id":"26","users_agents_id":"1","name":"ali","contact":"+92394239","whatsapp":"+87382479234","onesignal_id":"bcd81861-8184-401b-89e6-5ffd2e406c23","guest_lattitude":null,"guest_longitude":null,"booked_by":"Admin","booking_date":"2024-04-15","booking_time":"14:32:04","routes_id":"170","routes_details":"","pickup_hotel":null,"dropoff_hotel":{"hotels_id":"427","cities_id":"1","name":" AZIZIA (SHEESHA) ","city":"Makkah","status":"Active"},"no_of_passengers":"4","no_of_adults":"1","no_of_childs":"3","no_of_infants":"0","pickup_location":"0","dropoff_location":"0","pickup_date":"2024-04-16","pickup_time":"17:45:00","flight_companies_id":"0","flight_number":"","flight_details":"","flight_date":"2024-04-16","flight_time":"00:00:04","actual_fare":"0.00","agent_fare":"400.00","booked_fare":"400.00","cash_receive_from_customer":"0","extra_information":"dgdgdgdg","visa_types_id":"1","service_type":"Normal","payment_type":"credit","date_added":"2024-04-15 14:32:04","date_modified":"0000-00-00 00:00:00","final_status":{"bookings_final_status_id":"3","name":"Missed","status":"Active"},"final_status_other":"","payment_status":"0","completed_status":"0","status":"Active","cancel_reason":null,"driver_trip_status":{"bookings_drivers_status_id":"4","name":"Ride End","status":"Active"},"pickup_datetime":"2024-04-16 05:45:00","source":"","routes_pickup_id":"1","routes_dropoff_id":"20","vehicles_id":"5","fare":"400.00","bookings_multiple_id":"27","users_drivers_id":"6","users_drivers_fare":"0","paid_status":"Pending","routes":{"routes_id":"170","routes_pickup_id":"1","routes_dropoff_id":"20","vehicles_id":"5","fare":"400.00","service_type":"Normal","status":"Active","vehicle":{"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"},"pickup":{"routes_pickup_id":"1","name":"Jeddah Airport","type":"Airport","status":"Active"},"dropoff":{"routes_dropoff_id":"20","routes_pickup_id":"1","name":"Makkah Hotel","type":"Hotel","status":"Active"}},"users_agents_data":{"users_agents_id":"1","users_roles_id":"4","onesignal_id":"52e805f5-bd29-49d6-a9b4-0799d9f4fdf7","wallet_amount":"-600.00","credit_limit":"0.00","image_url":"uploads/users_agents/1696332795-Test.jpg","username":"Administrator","name":"Admin","email":"agents@umrahpassengers.com","password":"Passengers12#$","agency":"UP Official","address":"Multan Pakistan","city":"Multan","state":"Punjab","country":"Pakistan","contact":"+923008637767","mobile":"+923008637767","whatsapp":"+923008637767","landline":"+923008637767","iata_number":"123456","local_license_number":"123456","service_type":"Normal","notification_switch":"Yes","reset_otp":"0","date_added":null,"date_modified":"2023-08-15 07:50:19","status":"Active"},"flight_companies":null,"visa_types":{"visa_types_id":"1","name":"Umrah Visa","status":"Active"},"vehicles":[{"bookings_multiple_id":"27","bookings_id":"27","vehicles_id":"5","users_drivers_id":"6","users_drivers_fare":"0","paid_status":"Pending","date_added":"2024-04-15 14:32:04","date_modified":"0000-00-00 00:00:00","vehicles_drivers":{"users_drivers_id":"6","parent_id":"0","onesignal_id":"97b52784-4100-41a4-9b71-4cbd8c02451d","longitude":"71.4854448","lattitude":"30.2398234","wallet_amount":"0.00","drivers_type":"Individual","company_name":"Individual","name":"Muhammad Ali ","email":"ali@gmail.com","password":"123456","contact":"+9203057819889","whatsapp":"+9203057819889","city":"Multan ","rating":"0.0","image":"uploads/users_drivers/1712574474.jpeg","status":"Active","reset_otp":"0","notification_switch":"Yes","date_added":"2024-04-08 11:07:54","date_modified":"2024-04-08 11:07:54"},"vehicles_name":{"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"}}],"pending_update":"No"}]

class GetBookingsOngoingModel {
  GetBookingsOngoingModel({
      this.status, 
      this.data,});

  GetBookingsOngoingModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  String? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// bookings_id : "27"
/// parent_id : "26"
/// users_agents_id : "1"
/// name : "ali"
/// contact : "+92394239"
/// whatsapp : "+87382479234"
/// onesignal_id : "bcd81861-8184-401b-89e6-5ffd2e406c23"
/// guest_lattitude : null
/// guest_longitude : null
/// booked_by : "Admin"
/// booking_date : "2024-04-15"
/// booking_time : "14:32:04"
/// routes_id : "170"
/// routes_details : ""
/// pickup_hotel : null
/// dropoff_hotel : {"hotels_id":"427","cities_id":"1","name":" AZIZIA (SHEESHA) ","city":"Makkah","status":"Active"}
/// no_of_passengers : "4"
/// no_of_adults : "1"
/// no_of_childs : "3"
/// no_of_infants : "0"
/// pickup_location : "0"
/// dropoff_location : "0"
/// pickup_date : "2024-04-16"
/// pickup_time : "17:45:00"
/// flight_companies_id : "0"
/// flight_number : ""
/// flight_details : ""
/// flight_date : "2024-04-16"
/// flight_time : "00:00:04"
/// actual_fare : "0.00"
/// agent_fare : "400.00"
/// booked_fare : "400.00"
/// cash_receive_from_customer : "0"
/// extra_information : "dgdgdgdg"
/// visa_types_id : "1"
/// service_type : "Normal"
/// payment_type : "credit"
/// date_added : "2024-04-15 14:32:04"
/// date_modified : "0000-00-00 00:00:00"
/// final_status : {"bookings_final_status_id":"3","name":"Missed","status":"Active"}
/// final_status_other : ""
/// payment_status : "0"
/// completed_status : "0"
/// status : "Active"
/// cancel_reason : null
/// driver_trip_status : {"bookings_drivers_status_id":"4","name":"Ride End","status":"Active"}
/// pickup_datetime : "2024-04-16 05:45:00"
/// source : ""
/// routes_pickup_id : "1"
/// routes_dropoff_id : "20"
/// vehicles_id : "5"
/// fare : "400.00"
/// bookings_multiple_id : "27"
/// users_drivers_id : "6"
/// users_drivers_fare : "0"
/// paid_status : "Pending"
/// routes : {"routes_id":"170","routes_pickup_id":"1","routes_dropoff_id":"20","vehicles_id":"5","fare":"400.00","service_type":"Normal","status":"Active","vehicle":{"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"},"pickup":{"routes_pickup_id":"1","name":"Jeddah Airport","type":"Airport","status":"Active"},"dropoff":{"routes_dropoff_id":"20","routes_pickup_id":"1","name":"Makkah Hotel","type":"Hotel","status":"Active"}}
/// users_agents_data : {"users_agents_id":"1","users_roles_id":"4","onesignal_id":"52e805f5-bd29-49d6-a9b4-0799d9f4fdf7","wallet_amount":"-600.00","credit_limit":"0.00","image_url":"uploads/users_agents/1696332795-Test.jpg","username":"Administrator","name":"Admin","email":"agents@umrahpassengers.com","password":"Passengers12#$","agency":"UP Official","address":"Multan Pakistan","city":"Multan","state":"Punjab","country":"Pakistan","contact":"+923008637767","mobile":"+923008637767","whatsapp":"+923008637767","landline":"+923008637767","iata_number":"123456","local_license_number":"123456","service_type":"Normal","notification_switch":"Yes","reset_otp":"0","date_added":null,"date_modified":"2023-08-15 07:50:19","status":"Active"}
/// flight_companies : null
/// visa_types : {"visa_types_id":"1","name":"Umrah Visa","status":"Active"}
/// vehicles : [{"bookings_multiple_id":"27","bookings_id":"27","vehicles_id":"5","users_drivers_id":"6","users_drivers_fare":"0","paid_status":"Pending","date_added":"2024-04-15 14:32:04","date_modified":"0000-00-00 00:00:00","vehicles_drivers":{"users_drivers_id":"6","parent_id":"0","onesignal_id":"97b52784-4100-41a4-9b71-4cbd8c02451d","longitude":"71.4854448","lattitude":"30.2398234","wallet_amount":"0.00","drivers_type":"Individual","company_name":"Individual","name":"Muhammad Ali ","email":"ali@gmail.com","password":"123456","contact":"+9203057819889","whatsapp":"+9203057819889","city":"Multan ","rating":"0.0","image":"uploads/users_drivers/1712574474.jpeg","status":"Active","reset_otp":"0","notification_switch":"Yes","date_added":"2024-04-08 11:07:54","date_modified":"2024-04-08 11:07:54"},"vehicles_name":{"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"}}]
/// pending_update : "No"

class Data {
  Data({
      this.bookingsId, 
      this.parentId, 
      this.usersAgentsId, 
      this.name, 
      this.contact, 
      this.whatsapp, 
      this.onesignalId, 
      this.guestLattitude, 
      this.guestLongitude, 
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
      this.routesPickupId, 
      this.routesDropoffId, 
      this.vehiclesId, 
      this.fare, 
      this.bookingsMultipleId, 
      this.usersDriversId, 
      this.usersDriversFare, 
      this.paidStatus, 
      this.routes, 
      this.usersAgentsData, 
      this.flightCompanies, 
      this.visaTypes, 
      this.vehicles, 
      this.pendingUpdate,});

  Data.fromJson(dynamic json) {
    bookingsId = json['bookings_id'];
    parentId = json['parent_id'];
    usersAgentsId = json['users_agents_id'];
    name = json['name'];
    contact = json['contact'];
    whatsapp = json['whatsapp'];
    onesignalId = json['onesignal_id'];
    guestLattitude = json['guest_lattitude'];
    guestLongitude = json['guest_longitude'];
    bookedBy = json['booked_by'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    routesId = json['routes_id'];
    routesDetails = json['routes_details'];
    pickupHotel = json['pickup_hotel'];
    dropoffHotel = json['dropoff_hotel'] != null ? DropoffHotel.fromJson(json['dropoff_hotel']) : null;
    noOfPassengers = json['no_of_passengers'];
    noOfAdults = json['no_of_adults'];
    noOfChilds = json['no_of_childs'];
    noOfInfants = json['no_of_infants'];
    pickupLocation = json['pickup_location'];
    dropoffLocation = json['dropoff_location'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    flightCompaniesId = json['flight_companies_id'];
    flightNumber = json['flight_number'];
    flightDetails = json['flight_details'];
    flightDate = json['flight_date'];
    flightTime = json['flight_time'];
    actualFare = json['actual_fare'];
    agentFare = json['agent_fare'];
    bookedFare = json['booked_fare'];
    cashReceiveFromCustomer = json['cash_receive_from_customer'];
    extraInformation = json['extra_information'];
    visaTypesId = json['visa_types_id'];
    serviceType = json['service_type'];
    paymentType = json['payment_type'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    finalStatus = json['final_status'] != null ? FinalStatus.fromJson(json['final_status']) : null;
    finalStatusOther = json['final_status_other'];
    paymentStatus = json['payment_status'];
    completedStatus = json['completed_status'];
    status = json['status'];
    cancelReason = json['cancel_reason'];
    driverTripStatus = json['driver_trip_status'] != null ? DriverTripStatus.fromJson(json['driver_trip_status']) : null;
    pickupDatetime = json['pickup_datetime'];
    source = json['source'];
    routesPickupId = json['routes_pickup_id'];
    routesDropoffId = json['routes_dropoff_id'];
    vehiclesId = json['vehicles_id'];
    fare = json['fare'];
    bookingsMultipleId = json['bookings_multiple_id'];
    usersDriversId = json['users_drivers_id'];
    usersDriversFare = json['users_drivers_fare'];
    paidStatus = json['paid_status'];
    routes = json['routes'] != null ? Routes.fromJson(json['routes']) : null;
    usersAgentsData = json['users_agents_data'] != null ? UsersAgentsData.fromJson(json['users_agents_data']) : null;
    flightCompanies = json['flight_companies'];
    visaTypes = json['visa_types'] != null ? VisaTypes.fromJson(json['visa_types']) : null;
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles?.add(Vehicles.fromJson(v));
      });
    }
    pendingUpdate = json['pending_update'];
  }
  String? bookingsId;
  String? parentId;
  String? usersAgentsId;
  String? name;
  String? contact;
  String? whatsapp;
  String? onesignalId;
  dynamic guestLattitude;
  dynamic guestLongitude;
  String? bookedBy;
  String? bookingDate;
  String? bookingTime;
  String? routesId;
  String? routesDetails;
  dynamic pickupHotel;
  DropoffHotel? dropoffHotel;
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
  FinalStatus? finalStatus;
  String? finalStatusOther;
  String? paymentStatus;
  String? completedStatus;
  String? status;
  dynamic cancelReason;
  DriverTripStatus? driverTripStatus;
  String? pickupDatetime;
  String? source;
  String? routesPickupId;
  String? routesDropoffId;
  String? vehiclesId;
  String? fare;
  String? bookingsMultipleId;
  String? usersDriversId;
  String? usersDriversFare;
  String? paidStatus;
  Routes? routes;
  UsersAgentsData? usersAgentsData;
  dynamic flightCompanies;
  VisaTypes? visaTypes;
  List<Vehicles>? vehicles;
  String? pendingUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookings_id'] = bookingsId;
    map['parent_id'] = parentId;
    map['users_agents_id'] = usersAgentsId;
    map['name'] = name;
    map['contact'] = contact;
    map['whatsapp'] = whatsapp;
    map['onesignal_id'] = onesignalId;
    map['guest_lattitude'] = guestLattitude;
    map['guest_longitude'] = guestLongitude;
    map['booked_by'] = bookedBy;
    map['booking_date'] = bookingDate;
    map['booking_time'] = bookingTime;
    map['routes_id'] = routesId;
    map['routes_details'] = routesDetails;
    map['pickup_hotel'] = pickupHotel;
    if (dropoffHotel != null) {
      map['dropoff_hotel'] = dropoffHotel?.toJson();
    }
    map['no_of_passengers'] = noOfPassengers;
    map['no_of_adults'] = noOfAdults;
    map['no_of_childs'] = noOfChilds;
    map['no_of_infants'] = noOfInfants;
    map['pickup_location'] = pickupLocation;
    map['dropoff_location'] = dropoffLocation;
    map['pickup_date'] = pickupDate;
    map['pickup_time'] = pickupTime;
    map['flight_companies_id'] = flightCompaniesId;
    map['flight_number'] = flightNumber;
    map['flight_details'] = flightDetails;
    map['flight_date'] = flightDate;
    map['flight_time'] = flightTime;
    map['actual_fare'] = actualFare;
    map['agent_fare'] = agentFare;
    map['booked_fare'] = bookedFare;
    map['cash_receive_from_customer'] = cashReceiveFromCustomer;
    map['extra_information'] = extraInformation;
    map['visa_types_id'] = visaTypesId;
    map['service_type'] = serviceType;
    map['payment_type'] = paymentType;
    map['date_added'] = dateAdded;
    map['date_modified'] = dateModified;
    if (finalStatus != null) {
      map['final_status'] = finalStatus?.toJson();
    }
    map['final_status_other'] = finalStatusOther;
    map['payment_status'] = paymentStatus;
    map['completed_status'] = completedStatus;
    map['status'] = status;
    map['cancel_reason'] = cancelReason;
    if (driverTripStatus != null) {
      map['driver_trip_status'] = driverTripStatus?.toJson();
    }
    map['pickup_datetime'] = pickupDatetime;
    map['source'] = source;
    map['routes_pickup_id'] = routesPickupId;
    map['routes_dropoff_id'] = routesDropoffId;
    map['vehicles_id'] = vehiclesId;
    map['fare'] = fare;
    map['bookings_multiple_id'] = bookingsMultipleId;
    map['users_drivers_id'] = usersDriversId;
    map['users_drivers_fare'] = usersDriversFare;
    map['paid_status'] = paidStatus;
    if (routes != null) {
      map['routes'] = routes?.toJson();
    }
    if (usersAgentsData != null) {
      map['users_agents_data'] = usersAgentsData?.toJson();
    }
    map['flight_companies'] = flightCompanies;
    if (visaTypes != null) {
      map['visa_types'] = visaTypes?.toJson();
    }
    if (vehicles != null) {
      map['vehicles'] = vehicles?.map((v) => v.toJson()).toList();
    }
    map['pending_update'] = pendingUpdate;
    return map;
  }

}

/// bookings_multiple_id : "27"
/// bookings_id : "27"
/// vehicles_id : "5"
/// users_drivers_id : "6"
/// users_drivers_fare : "0"
/// paid_status : "Pending"
/// date_added : "2024-04-15 14:32:04"
/// date_modified : "0000-00-00 00:00:00"
/// vehicles_drivers : {"users_drivers_id":"6","parent_id":"0","onesignal_id":"97b52784-4100-41a4-9b71-4cbd8c02451d","longitude":"71.4854448","lattitude":"30.2398234","wallet_amount":"0.00","drivers_type":"Individual","company_name":"Individual","name":"Muhammad Ali ","email":"ali@gmail.com","password":"123456","contact":"+9203057819889","whatsapp":"+9203057819889","city":"Multan ","rating":"0.0","image":"uploads/users_drivers/1712574474.jpeg","status":"Active","reset_otp":"0","notification_switch":"Yes","date_added":"2024-04-08 11:07:54","date_modified":"2024-04-08 11:07:54"}
/// vehicles_name : {"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"}

class Vehicles {
  Vehicles({
      this.bookingsMultipleId, 
      this.bookingsId, 
      this.vehiclesId, 
      this.usersDriversId, 
      this.usersDriversFare, 
      this.paidStatus, 
      this.dateAdded, 
      this.dateModified, 
      this.vehiclesDrivers, 
      this.vehiclesName,});

  Vehicles.fromJson(dynamic json) {
    bookingsMultipleId = json['bookings_multiple_id'];
    bookingsId = json['bookings_id'];
    vehiclesId = json['vehicles_id'];
    usersDriversId = json['users_drivers_id'];
    usersDriversFare = json['users_drivers_fare'];
    paidStatus = json['paid_status'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    vehiclesDrivers = json['vehicles_drivers'] != null ? VehiclesDrivers.fromJson(json['vehicles_drivers']) : null;
    vehiclesName = json['vehicles_name'] != null ? VehiclesName.fromJson(json['vehicles_name']) : null;
  }
  String? bookingsMultipleId;
  String? bookingsId;
  String? vehiclesId;
  String? usersDriversId;
  String? usersDriversFare;
  String? paidStatus;
  String? dateAdded;
  String? dateModified;
  VehiclesDrivers? vehiclesDrivers;
  VehiclesName? vehiclesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookings_multiple_id'] = bookingsMultipleId;
    map['bookings_id'] = bookingsId;
    map['vehicles_id'] = vehiclesId;
    map['users_drivers_id'] = usersDriversId;
    map['users_drivers_fare'] = usersDriversFare;
    map['paid_status'] = paidStatus;
    map['date_added'] = dateAdded;
    map['date_modified'] = dateModified;
    if (vehiclesDrivers != null) {
      map['vehicles_drivers'] = vehiclesDrivers?.toJson();
    }
    if (vehiclesName != null) {
      map['vehicles_name'] = vehiclesName?.toJson();
    }
    return map;
  }

}

/// vehicles_id : "5"
/// name : "GMC Yukon XL"
/// no_of_passengers : "7"
/// feature_image : "uploads/vehicles/gmc.png"
/// no_of_bags : "6"
/// no_of_doors : "4"
/// ac : "Yes"
/// status : "Active"

class VehiclesName {
  VehiclesName({
      this.vehiclesId, 
      this.name, 
      this.noOfPassengers, 
      this.featureImage, 
      this.noOfBags, 
      this.noOfDoors, 
      this.ac, 
      this.status,});

  VehiclesName.fromJson(dynamic json) {
    vehiclesId = json['vehicles_id'];
    name = json['name'];
    noOfPassengers = json['no_of_passengers'];
    featureImage = json['feature_image'];
    noOfBags = json['no_of_bags'];
    noOfDoors = json['no_of_doors'];
    ac = json['ac'];
    status = json['status'];
  }
  String? vehiclesId;
  String? name;
  String? noOfPassengers;
  String? featureImage;
  String? noOfBags;
  String? noOfDoors;
  String? ac;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicles_id'] = vehiclesId;
    map['name'] = name;
    map['no_of_passengers'] = noOfPassengers;
    map['feature_image'] = featureImage;
    map['no_of_bags'] = noOfBags;
    map['no_of_doors'] = noOfDoors;
    map['ac'] = ac;
    map['status'] = status;
    return map;
  }

}

/// users_drivers_id : "6"
/// parent_id : "0"
/// onesignal_id : "97b52784-4100-41a4-9b71-4cbd8c02451d"
/// longitude : "71.4854448"
/// lattitude : "30.2398234"
/// wallet_amount : "0.00"
/// drivers_type : "Individual"
/// company_name : "Individual"
/// name : "Muhammad Ali "
/// email : "ali@gmail.com"
/// password : "123456"
/// contact : "+9203057819889"
/// whatsapp : "+9203057819889"
/// city : "Multan "
/// rating : "0.0"
/// image : "uploads/users_drivers/1712574474.jpeg"
/// status : "Active"
/// reset_otp : "0"
/// notification_switch : "Yes"
/// date_added : "2024-04-08 11:07:54"
/// date_modified : "2024-04-08 11:07:54"

class VehiclesDrivers {
  VehiclesDrivers({
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
      this.dateModified,});

  VehiclesDrivers.fromJson(dynamic json) {
    usersDriversId = json['users_drivers_id'];
    parentId = json['parent_id'];
    onesignalId = json['onesignal_id'];
    longitude = json['longitude'];
    lattitude = json['lattitude'];
    walletAmount = json['wallet_amount'];
    driversType = json['drivers_type'];
    companyName = json['company_name'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    contact = json['contact'];
    whatsapp = json['whatsapp'];
    city = json['city'];
    rating = json['rating'];
    image = json['image'];
    status = json['status'];
    resetOtp = json['reset_otp'];
    notificationSwitch = json['notification_switch'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
  }
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['users_drivers_id'] = usersDriversId;
    map['parent_id'] = parentId;
    map['onesignal_id'] = onesignalId;
    map['longitude'] = longitude;
    map['lattitude'] = lattitude;
    map['wallet_amount'] = walletAmount;
    map['drivers_type'] = driversType;
    map['company_name'] = companyName;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['contact'] = contact;
    map['whatsapp'] = whatsapp;
    map['city'] = city;
    map['rating'] = rating;
    map['image'] = image;
    map['status'] = status;
    map['reset_otp'] = resetOtp;
    map['notification_switch'] = notificationSwitch;
    map['date_added'] = dateAdded;
    map['date_modified'] = dateModified;
    return map;
  }

}

/// visa_types_id : "1"
/// name : "Umrah Visa"
/// status : "Active"

class VisaTypes {
  VisaTypes({
      this.visaTypesId, 
      this.name, 
      this.status,});

  VisaTypes.fromJson(dynamic json) {
    visaTypesId = json['visa_types_id'];
    name = json['name'];
    status = json['status'];
  }
  String? visaTypesId;
  String? name;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visa_types_id'] = visaTypesId;
    map['name'] = name;
    map['status'] = status;
    return map;
  }

}

/// users_agents_id : "1"
/// users_roles_id : "4"
/// onesignal_id : "52e805f5-bd29-49d6-a9b4-0799d9f4fdf7"
/// wallet_amount : "-600.00"
/// credit_limit : "0.00"
/// image_url : "uploads/users_agents/1696332795-Test.jpg"
/// username : "Administrator"
/// name : "Admin"
/// email : "agents@umrahpassengers.com"
/// password : "Passengers12#$"
/// agency : "UP Official"
/// address : "Multan Pakistan"
/// city : "Multan"
/// state : "Punjab"
/// country : "Pakistan"
/// contact : "+923008637767"
/// mobile : "+923008637767"
/// whatsapp : "+923008637767"
/// landline : "+923008637767"
/// iata_number : "123456"
/// local_license_number : "123456"
/// service_type : "Normal"
/// notification_switch : "Yes"
/// reset_otp : "0"
/// date_added : null
/// date_modified : "2023-08-15 07:50:19"
/// status : "Active"

class UsersAgentsData {
  UsersAgentsData({
      this.usersAgentsId, 
      this.usersRolesId, 
      this.onesignalId, 
      this.walletAmount, 
      this.creditLimit, 
      this.imageUrl, 
      this.username, 
      this.name, 
      this.email, 
      this.password, 
      this.agency, 
      this.address, 
      this.city, 
      this.state, 
      this.country, 
      this.contact, 
      this.mobile, 
      this.whatsapp, 
      this.landline, 
      this.iataNumber, 
      this.localLicenseNumber, 
      this.serviceType, 
      this.notificationSwitch, 
      this.resetOtp, 
      this.dateAdded, 
      this.dateModified, 
      this.status,});

  UsersAgentsData.fromJson(dynamic json) {
    usersAgentsId = json['users_agents_id'];
    usersRolesId = json['users_roles_id'];
    onesignalId = json['onesignal_id'];
    walletAmount = json['wallet_amount'];
    creditLimit = json['credit_limit'];
    imageUrl = json['image_url'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    agency = json['agency'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    contact = json['contact'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    landline = json['landline'];
    iataNumber = json['iata_number'];
    localLicenseNumber = json['local_license_number'];
    serviceType = json['service_type'];
    notificationSwitch = json['notification_switch'];
    resetOtp = json['reset_otp'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    status = json['status'];
  }
  String? usersAgentsId;
  String? usersRolesId;
  String? onesignalId;
  String? walletAmount;
  String? creditLimit;
  String? imageUrl;
  String? username;
  String? name;
  String? email;
  String? password;
  String? agency;
  String? address;
  String? city;
  String? state;
  String? country;
  String? contact;
  String? mobile;
  String? whatsapp;
  String? landline;
  String? iataNumber;
  String? localLicenseNumber;
  String? serviceType;
  String? notificationSwitch;
  String? resetOtp;
  dynamic dateAdded;
  String? dateModified;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['users_agents_id'] = usersAgentsId;
    map['users_roles_id'] = usersRolesId;
    map['onesignal_id'] = onesignalId;
    map['wallet_amount'] = walletAmount;
    map['credit_limit'] = creditLimit;
    map['image_url'] = imageUrl;
    map['username'] = username;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['agency'] = agency;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['contact'] = contact;
    map['mobile'] = mobile;
    map['whatsapp'] = whatsapp;
    map['landline'] = landline;
    map['iata_number'] = iataNumber;
    map['local_license_number'] = localLicenseNumber;
    map['service_type'] = serviceType;
    map['notification_switch'] = notificationSwitch;
    map['reset_otp'] = resetOtp;
    map['date_added'] = dateAdded;
    map['date_modified'] = dateModified;
    map['status'] = status;
    return map;
  }

}

/// routes_id : "170"
/// routes_pickup_id : "1"
/// routes_dropoff_id : "20"
/// vehicles_id : "5"
/// fare : "400.00"
/// service_type : "Normal"
/// status : "Active"
/// vehicle : {"vehicles_id":"5","name":"GMC Yukon XL","no_of_passengers":"7","feature_image":"uploads/vehicles/gmc.png","no_of_bags":"6","no_of_doors":"4","ac":"Yes","status":"Active"}
/// pickup : {"routes_pickup_id":"1","name":"Jeddah Airport","type":"Airport","status":"Active"}
/// dropoff : {"routes_dropoff_id":"20","routes_pickup_id":"1","name":"Makkah Hotel","type":"Hotel","status":"Active"}

class Routes {
  Routes({
      this.routesId, 
      this.routesPickupId, 
      this.routesDropoffId, 
      this.vehiclesId, 
      this.fare, 
      this.serviceType, 
      this.status, 
      this.vehicle, 
      this.pickup, 
      this.dropoff,});

  Routes.fromJson(dynamic json) {
    routesId = json['routes_id'];
    routesPickupId = json['routes_pickup_id'];
    routesDropoffId = json['routes_dropoff_id'];
    vehiclesId = json['vehicles_id'];
    fare = json['fare'];
    serviceType = json['service_type'];
    status = json['status'];
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    pickup = json['pickup'] != null ? Pickup.fromJson(json['pickup']) : null;
    dropoff = json['dropoff'] != null ? Dropoff.fromJson(json['dropoff']) : null;
  }
  String? routesId;
  String? routesPickupId;
  String? routesDropoffId;
  String? vehiclesId;
  String? fare;
  String? serviceType;
  String? status;
  Vehicle? vehicle;
  Pickup? pickup;
  Dropoff? dropoff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routes_id'] = routesId;
    map['routes_pickup_id'] = routesPickupId;
    map['routes_dropoff_id'] = routesDropoffId;
    map['vehicles_id'] = vehiclesId;
    map['fare'] = fare;
    map['service_type'] = serviceType;
    map['status'] = status;
    if (vehicle != null) {
      map['vehicle'] = vehicle?.toJson();
    }
    if (pickup != null) {
      map['pickup'] = pickup?.toJson();
    }
    if (dropoff != null) {
      map['dropoff'] = dropoff?.toJson();
    }
    return map;
  }

}

/// routes_dropoff_id : "20"
/// routes_pickup_id : "1"
/// name : "Makkah Hotel"
/// type : "Hotel"
/// status : "Active"

class Dropoff {
  Dropoff({
      this.routesDropoffId, 
      this.routesPickupId, 
      this.name, 
      this.type, 
      this.status,});

  Dropoff.fromJson(dynamic json) {
    routesDropoffId = json['routes_dropoff_id'];
    routesPickupId = json['routes_pickup_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
  }
  String? routesDropoffId;
  String? routesPickupId;
  String? name;
  String? type;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routes_dropoff_id'] = routesDropoffId;
    map['routes_pickup_id'] = routesPickupId;
    map['name'] = name;
    map['type'] = type;
    map['status'] = status;
    return map;
  }

}

/// routes_pickup_id : "1"
/// name : "Jeddah Airport"
/// type : "Airport"
/// status : "Active"

class Pickup {
  Pickup({
      this.routesPickupId, 
      this.name, 
      this.type, 
      this.status,});

  Pickup.fromJson(dynamic json) {
    routesPickupId = json['routes_pickup_id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
  }
  String? routesPickupId;
  String? name;
  String? type;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routes_pickup_id'] = routesPickupId;
    map['name'] = name;
    map['type'] = type;
    map['status'] = status;
    return map;
  }

}

/// vehicles_id : "5"
/// name : "GMC Yukon XL"
/// no_of_passengers : "7"
/// feature_image : "uploads/vehicles/gmc.png"
/// no_of_bags : "6"
/// no_of_doors : "4"
/// ac : "Yes"
/// status : "Active"

class Vehicle {
  Vehicle({
      this.vehiclesId, 
      this.name, 
      this.noOfPassengers, 
      this.featureImage, 
      this.noOfBags, 
      this.noOfDoors, 
      this.ac, 
      this.status,});

  Vehicle.fromJson(dynamic json) {
    vehiclesId = json['vehicles_id'];
    name = json['name'];
    noOfPassengers = json['no_of_passengers'];
    featureImage = json['feature_image'];
    noOfBags = json['no_of_bags'];
    noOfDoors = json['no_of_doors'];
    ac = json['ac'];
    status = json['status'];
  }
  String? vehiclesId;
  String? name;
  String? noOfPassengers;
  String? featureImage;
  String? noOfBags;
  String? noOfDoors;
  String? ac;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicles_id'] = vehiclesId;
    map['name'] = name;
    map['no_of_passengers'] = noOfPassengers;
    map['feature_image'] = featureImage;
    map['no_of_bags'] = noOfBags;
    map['no_of_doors'] = noOfDoors;
    map['ac'] = ac;
    map['status'] = status;
    return map;
  }

}

/// bookings_drivers_status_id : "4"
/// name : "Ride End"
/// status : "Active"

class DriverTripStatus {
  DriverTripStatus({
      this.bookingsDriversStatusId, 
      this.name, 
      this.status,});

  DriverTripStatus.fromJson(dynamic json) {
    bookingsDriversStatusId = json['bookings_drivers_status_id'];
    name = json['name'];
    status = json['status'];
  }
  String? bookingsDriversStatusId;
  String? name;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookings_drivers_status_id'] = bookingsDriversStatusId;
    map['name'] = name;
    map['status'] = status;
    return map;
  }

}

/// bookings_final_status_id : "3"
/// name : "Missed"
/// status : "Active"

class FinalStatus {
  FinalStatus({
      this.bookingsFinalStatusId, 
      this.name, 
      this.status,});

  FinalStatus.fromJson(dynamic json) {
    bookingsFinalStatusId = json['bookings_final_status_id'];
    name = json['name'];
    status = json['status'];
  }
  String? bookingsFinalStatusId;
  String? name;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookings_final_status_id'] = bookingsFinalStatusId;
    map['name'] = name;
    map['status'] = status;
    return map;
  }

}

/// hotels_id : "427"
/// cities_id : "1"
/// name : " AZIZIA (SHEESHA) "
/// city : "Makkah"
/// status : "Active"

class DropoffHotel {
  DropoffHotel({
      this.hotelsId, 
      this.citiesId, 
      this.name, 
      this.city, 
      this.status,});

  DropoffHotel.fromJson(dynamic json) {
    hotelsId = json['hotels_id'];
    citiesId = json['cities_id'];
    name = json['name'];
    city = json['city'];
    status = json['status'];
  }
  String? hotelsId;
  String? citiesId;
  String? name;
  String? city;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hotels_id'] = hotelsId;
    map['cities_id'] = citiesId;
    map['name'] = name;
    map['city'] = city;
    map['status'] = status;
    return map;
  }

}