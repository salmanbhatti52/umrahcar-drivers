import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/models/get_driver_profile.dart';
import 'package:umrahcar_driver/models/update_driver_location_model.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/pickup_screen.dart';
import 'package:umrahcar_driver/service/rest_api_service.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_driver/utils/const.dart';
import 'package:umrahcar_driver/widgets/top_boxes.dart';
import 'package:umrahcar_driver/widgets/home_list.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/dropoff_screen.dart';

import '../models/get_all_system_data_model.dart';
import '../models/get_booking_list_model.dart';
import '../widgets/upcoming_list.dart';

var userId;
var profileName;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
GetDriverProfile getDriverProfile=GetDriverProfile();
  getLocalData() async {
    final _sharedPref = await SharedPreferences.getInstance();
    var uid = _sharedPref.getString('userId');
    userId = uid;
    print("uiduid: ${uid}");
    print("uiduid: ${userId}");
    getProfile();
    getBookingListOngoing();
    getBookingListUpcoming();
    getBookingListCompleted();
    getSystemAllData();
  }

     getProfile()async{
       getDriverProfile= await DioClient().getProfile(userId, context);
       if(getDriverProfile !=null){
         print("name: ${getDriverProfile.data!.userData!.name}");
         setState(() {

         });
       }
     }
GetBookingListModel getBookingOngoingResponse=GetBookingListModel();

getBookingListOngoing()async{
  print("userId $userId");
  var mapData={
    "users_drivers_id": userId.toString()
  };
  getBookingOngoingResponse= await DioClient().getBookingOngoing(mapData, context);
  print("response id: ${getBookingOngoingResponse.data}");
  setState(() {

  });

}

GetBookingListModel getBookingUpcomingResponse=GetBookingListModel();
getBookingListUpcoming()async{
  print("userId $userId");
  var mapData={
    "users_drivers_id": userId.toString()
  };
  getBookingUpcomingResponse= await DioClient().getBookingupcoming(mapData, context);
  print("response id: ${getBookingUpcomingResponse.data}");
  setState(() {

  });

}

GetBookingListModel getBookingCompletedResponse=GetBookingListModel();
getBookingListCompleted()async{
  print("uid $userId");
  var mapData={
    "users_drivers_id":userId.toString()
  };
  getBookingCompletedResponse= await DioClient().getBookingCompleted(mapData, context);
  print("response id: ${getBookingCompletedResponse.data}");
  setState(() {

  });

}

bool servicestatus = false;
bool haspermission = false;
late LocationPermission permission;
late Position position;
String long = "", lat = "";
Timer? timer;

late StreamSubscription<Position> positionStream;
checkGps() async {
  servicestatus = await Geolocator.isLocationServiceEnabled();
  if(servicestatus){
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        haspermission = true;
      }
    }else{
      haspermission = true;
    }

    if(haspermission){
      setState(() {
        //refresh the UI
      });

      getLocation();
    }
  }else{
    print("GPS Service is not enabled, turn on GPS location");
  }

  setState(() {
    //refresh the UI
  });
}

getLocation() async {
  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.longitude); //Output: 80.24599079
  print(position.latitude);
  print("hiiiiiiiiiii");//Output: 29.6593457

  long = position.longitude.toString();
  lat = position.latitude.toString();


  if(long.isNotEmpty && lat.isNotEmpty){
    updateDriverLocation();

  }

  setState(() {
    //refresh UI
  });

  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings).listen((Position position) {
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
    print("bye");//Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    if(long.isNotEmpty && lat.isNotEmpty){
      updateDriverLocation();

    }
    setState(() {

    });
  });
}
UpdateDriverLocationModel updateDriverLocationModel=UpdateDriverLocationModel();
updateDriverLocation()async{
  print(lat);
  print(long);
  print(userId);
  print("done");
  var jsonData={
    "users_drivers_id":"${userId.toString()}",
    "longitude":long,
    "lattitude":lat
  };

  updateDriverLocationModel = await DioClient().updateDriverLocation(jsonData, context);
  if(updateDriverLocationModel !=null){
    print("message of location: ${updateDriverLocationModel.message}");
  }
}

GetAllSystemData getAllSystemData = GetAllSystemData();

getSystemAllData() async {
  getAllSystemData = await DioClient().getSystemAllData(context);
  if (getAllSystemData != null) {
    print("GETSystemAllData: ${getAllSystemData.data}");
    setState(() {
      getSettingsData();
    });
  }
}

late List<Setting> pickSettingsData = [];
int timerCount=3;
getSettingsData() {
  if (getAllSystemData!.data! != null) {
    for (int i = 0; i < getAllSystemData!.data!.settings!.length; i++) {
      pickSettingsData.add(getAllSystemData!.data!.settings![i]);
      print("Setting time= $pickSettingsData");
    }

    for (int i = 0; i < pickSettingsData.length; i++) {
      if (pickSettingsData[i].type == "map_refresh_time") {
        timerCount = int.parse(pickSettingsData[i].description!);
          print("timer refresh: ${timerCount}");
        checkGps();
          timer =
              Timer.periodic( Duration(minutes: timerCount), (timer) => checkGps());
          setState(() {});


      }
    }
  }
}


  @override
  void initState() {
    getLocalData();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  print("long: ${long}");
  print("lat: ${lat}");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: getDriverProfile.data !=null ?
      Stack(
        children: [
            Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.height * 0.259,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getDriverProfile.data!.userData!.image !=null ?

                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("$imageUrl${getDriverProfile.data!.userData!.image}",
                                ),
                                fit: BoxFit.cover
                              )
                            ),

                          ),
                        ):Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            radius: 35,
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(
                               width: 180,
                               child: Text(
                                '${getDriverProfile.data!.userData!.name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w600,
                                ),
                                 overflow: TextOverflow.ellipsis,
                            ),
                             ),
                            SizedBox(height: size.height * 0.002),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/white-location-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                 SizedBox(
                                   width: 180,
                                   child: Text(
                                    '${getDriverProfile.data!.userData!.city}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                     overflow: TextOverflow.ellipsis,

                                   ),
                                 ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ),
                          child: SvgPicture.asset(
                              'assets/images/green-notification-icon.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          box('assets/images/white-fast-car-icon.svg', getBookingOngoingResponse.data!=null ?'${getBookingOngoingResponse.data!.length}':"0",
                              'On Going Bookings', context),
                          box('assets/images/white-fast-car-icon.svg',getBookingUpcomingResponse.data!=null ? '${getBookingUpcomingResponse.data!.length}':"0",
                              'Upcoming Bookings', context),
                          box('assets/images/white-fast-car-icon.svg',getBookingCompletedResponse.data!=null? '${getBookingCompletedResponse.data!.length}':"0",
                              'Completed Bookings', context),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Bookings',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        color: Colors.transparent,
                        height: size.height * 0.279,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:upComingList(context,getBookingUpcomingResponse),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          getBookingOngoingResponse.data!=null ?
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
            child: GestureDetector(
              onTap: () {
                if( getBookingOngoingResponse.data!=null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  PickUpPage(getBookingData: getBookingOngoingResponse.data![0]),
                      ));
                  setState(() {

                  });
                }
              },
              child: Container(
                width: size.width,
                height: size.height * 0.245,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'On Going Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/homepage-map.png',
                          ),
                          Positioned(
                            top: 15,
                            left: 115,
                            child: SvgPicture.asset(
                                'assets/images/home-green-location-icon.svg'),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                child: Image.asset(
                                  'assets/images/user-profile.png',
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Text(
                                '${getBookingOngoingResponse.data![0].vehicles![0].vehiclesDrivers!.name}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/location-icon.svg'),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.25,
                                child:  AutoSizeText(
                                  '${getBookingOngoingResponse.data![0].name}',
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                  ),
                                  minFontSize: 8,
                                  maxFontSize: 8,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ):
          const Padding(
            padding: EdgeInsets.only(left: 120, right: 20, top: 180),
            child: Column(
              children: [
                SizedBox(height: 130,),
                Text(
                  'No Current Booking',
                  style: TextStyle(
                    color: Colors.black,

                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ):
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 370,),
          Center(
            child: Container(
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      )
      ,
    );
  }
}
