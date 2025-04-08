import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/tabbar_bookings.dart';

import '../../models/get_all_system_data_model.dart';
import '../../models/update_driver_location_model.dart';
import '../../service/rest_api_service.dart';
import '../homepage_screen.dart';

class BookingsPage extends StatefulWidget {
  int? indexNmbr=0;
   BookingsPage({super.key,this.indexNmbr});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  bool status = false;
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  Timer? timer;

  late StreamSubscription<Position> positionStream;
  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if(serviceStatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          hasPermission = true;
        }
      }else{
        hasPermission = true;
      }

      if(hasPermission){
        if(mounted){
          setState(() {
            //refresh the UI
          });
        }


        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    if(mounted){
      setState(() {
        //refresh the UI
      });
    }

  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude); //Output: 80.24599079
    // print(position.latitude);
    // print("hi");//Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();




    if(mounted){
      if(long.isNotEmpty && lat.isNotEmpty){
        updateDriverLocation();

      }
      setState(() {
        //refresh UI
      });
    }


    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen((Position position) {
      // print(position.longitude); //Output: 80.24599079
      // print(position.latitude); //Output: 29.6593457
      // print("bye");//Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();


      if(mounted){
        if(long.isNotEmpty && lat.isNotEmpty){
          updateDriverLocation();

        }
        setState(() {

        });
      }
    });
  }
  UpdateDriverLocationModel updateDriverLocationModel=UpdateDriverLocationModel();
  updateDriverLocation()async{
    // print(lat);
    // print(long);
    // print(userId);
    // print("done");
    var jsonData={
      "users_drivers_id":userId.toString(),
      "longitude":long,
      "lattitude":lat
    };

    updateDriverLocationModel = await DioClient().updateDriverLocation(jsonData,context);
    print("message of location: ${updateDriverLocationModel.message}");
    }

  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    // print("GETSystemAllData: ${getAllSystemData.data}");
    if(mounted){
      setState(() {
        getSettingsData();
      });
    }

    }

  late List<Setting> pickSettingsData = [];
  int timerCount=3;
  getSettingsData() {
    for (int i = 0; i < getAllSystemData!.data!.settings!.length; i++) {
      pickSettingsData.add(getAllSystemData!.data!.settings![i]);
      // print("Setting time= $pickSettingsData");
    }

    for (int i = 0; i < pickSettingsData.length; i++) {
      if (pickSettingsData[i].type == "map_refresh_time") {
        timerCount = int.parse(pickSettingsData[i].description!);
        print("timer refresh: $timerCount");

        if(mounted){
          checkGps();
          timer =
              Timer.periodic( Duration(minutes: timerCount), (timer) => checkGps());
          setState(() {});
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();

  }

  @override
  void initState() {
    print("bookingPage: ${widget.indexNmbr}");
    getSystemAllData();
    // TODO: implement initState
    super.initState();
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
            Navigator.of(context).pop(result);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Bookings',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              TabbarBookings(indexNmbr: widget.indexNmbr),
            ],
          ),
        ),
      ),
    );
  }
}
