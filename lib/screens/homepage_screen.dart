import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:umrahcar_driver/widgets/ongoing_list.dart';
import 'package:umrahcar_driver/widgets/top_boxes.dart';
import 'package:umrahcar_driver/widgets/home_list.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/dropoff_screen.dart';
import '../models/get_all_system_data_model.dart';
import '../models/get_booking_list_model.dart';
import '../widgets/navbar.dart';
import '../widgets/upcoming_list.dart';

var userId;
var profileName;
String? currencySymbol;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetDriverProfile getDriverProfile = GetDriverProfile();

  getLocalData() async {
    final sharedPref = await SharedPreferences.getInstance();
    var uid = sharedPref.getString('userId');
    userId = uid;
    print("userId Home121: $userId");
    getProfile();
    getSystemAllData();
    getBookingListOngoing();
    getBookingListUpcoming();
    getBookingListCompleted();
  }

  getProfile() async {
    if (mounted) {
      getDriverProfile = await DioClient().getProfile(userId, context);
      print("name: ${getDriverProfile.data!.userData!.name}");
      setState(() {});
    }
  }

  GetBookingListModel getBookingOngoingResponse = GetBookingListModel();

  getBookingListOngoing() async {
    if (mounted) {
      var mapData = {"users_drivers_id": userId.toString()};
      getBookingOngoingResponse = await DioClient().getBookingOngoing(mapData, context);
      setState(() {});
    }
  }

  GetBookingListModel getBookingUpcomingResponse = GetBookingListModel();

  getBookingListUpcoming() async {
    if (mounted) {
      var mapData = {"users_drivers_id": userId.toString()};
      getBookingUpcomingResponse = await DioClient().getBookingupcoming(mapData, context);
      setState(() {});
    }
  }

  GetBookingListModel getBookingCompletedResponse = GetBookingListModel();

  getBookingListCompleted() async {
    if (mounted) {
      var mapData = {"users_drivers_id": userId.toString()};
      getBookingCompletedResponse = await DioClient().getBookingCompleted(mapData, context);
      setState(() {});
    }
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
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        if (mounted) {
          setState(() {});
          getLocation();
        }
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    if (mounted) {
      setState(() {});
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();

    if (mounted) {
      if (long.isNotEmpty && lat.isNotEmpty) {
        updateDriverLocation();
      }
      setState(() {});
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      if (mounted) {
        if (long.isNotEmpty && lat.isNotEmpty) {
          updateDriverLocation();
        }
        setState(() {});
      }
    });
  }

  UpdateDriverLocationModel updateDriverLocationModel = UpdateDriverLocationModel();

  updateDriverLocation() async {
    var jsonData = {
      "users_drivers_id": userId.toString(),
      "longitude": long,
      "lattitude": lat
    };
    if (mounted) {
      updateDriverLocationModel = await DioClient().updateDriverLocation(jsonData, context);
      print("message of location: ${updateDriverLocationModel.message}");
    }
  }

  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    if (mounted) {
      getAllSystemData = await DioClient().getSystemAllData(context);
      setState(() {
        getSettingsData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;

  getSettingsData() {
    for (int i = 0; i < getAllSystemData.data!.settings!.length; i++) {
      pickSettingsData.add(getAllSystemData.data!.settings![i]);
    }

    for (int i = 0; i < pickSettingsData.length; i++) {
      final setting = pickSettingsData[i];

      if (setting.type == "map_refresh_time") {
        timerCount = int.parse(setting.description!);
        print("timer refresh: $timerCount");
        if (mounted) {
          checkGps();
          timer = Timer.periodic(Duration(minutes: timerCount), (timer) => checkGps());
          setState(() {});
        }
      }

      if (setting.type == "currency_symbol") {
        currencySymbol = setting.description;
        print("Currency Symbol: $currencySymbol");
      }
    }
  }

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Active Tracking'),
              content: const Text(
                'Closing the app will stop location updates. '
                    'This may affect your active bookings.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            SystemNavigator.pop(); // Closes the app on Android
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: getDriverProfile.data != null
            ? Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.height * 0.252,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getDriverProfile.data!.userData!.image != null
                            ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "$imageUrl${getDriverProfile.data!.userData!.image}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                              // color: Theme.of(context).colorScheme.onSurface,
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
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: size.height * 0.002),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/white-location-icon.svg',
                                  color: Colors.white,
                                ),
                                SizedBox(width: size.width * 0.01),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    '${getDriverProfile.data!.userData!.city}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/green-notification-icon.svg',
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBar(indexNmbr: 1),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: box(
                                  'assets/images/white-fast-car-icon.svg',
                                  getBookingOngoingResponse.data != null
                                      ? '${getBookingOngoingResponse.data!.length}'
                                      : "0",
                                  'On Going Bookings',
                                  context,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBar(indexNmbr: 1, bookingNmbr: 1),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: box(
                                  'assets/images/white-fast-car-icon.svg',
                                  getBookingUpcomingResponse.data != null
                                      ? '${getBookingUpcomingResponse.data!.length}'
                                      : "0",
                                  'Upcoming Bookings',
                                  context,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NavBar(indexNmbr: 1, bookingNmbr: 2),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: box(
                                  'assets/images/white-fast-car-icon.svg',
                                  getBookingCompletedResponse.data != null
                                      ? '${getBookingCompletedResponse.data!.length}'
                                      : "0",
                                  'Completed Bookings',
                                  context,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ongoing Bookings',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            height: size.height * 0.273,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  getBookingListOngoing();
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: onGoingList(context, getBookingOngoingResponse),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            getBookingOngoingResponse.data != null
                ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
              child: GestureDetector(
                onTap: () {
                  if (getBookingOngoingResponse.data != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PickUpPage(
                          getBookingData: getBookingOngoingResponse.data![0],
                        ),
                      ),
                    );
                    setState(() {});
                  }
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.255,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'On Going Booking',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/homepage-map.png',
                              // color: Theme.of(context).colorScheme.onSurface,
                            ),
                            Positioned(
                              top: 15,
                              left: 115,
                              child: SvgPicture.asset(
                                'assets/images/home-green-location-icon.svg',
                                // color: Theme.of(context).colorScheme.onSurface,
                              ),
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
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  child: Image.asset(
                                    'assets/images/user-profile.png',
                                    // color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.02),
                                Text(
                                  '${getBookingOngoingResponse.data![0].vehicles![0].vehiclesDrivers!.name}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/location-icon.svg',
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Text(
                                    '${getBookingOngoingResponse.data![0].name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.only(left: 100, right: 20, top: 160),
              child: Column(
                children: [
                  SizedBox(height: 130),
                  Text(
                    'No Current Booking',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 370),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}