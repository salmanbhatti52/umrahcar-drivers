import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:umrahcar_driver/models/distance_calculate_model.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../models/get_all_system_data_model.dart';
import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_service.dart';
import '../../../utils/colors.dart';
import '../../../widgets/button.dart';
import '../../homepage_screen.dart';
import 'chat_screen.dart';
import 'dart:ui' as ui;

import 'dropoff_screen.dart';

class PickUpPage extends StatefulWidget {
  GetBookingData? getBookingData;
  PickUpPage({super.key,this.getBookingData});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  @override

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat!, long!), zoom: 17),
        ),
      );
    });
  }

  double? lat;
  double? long;
  @override
  var icon;
  BitmapDescriptor? markerIcon;
  void addCustomIcon() async {
    icon = await getBitmapDescriptorFromAssetBytes(
        "assets/images/location.png", 50);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Timer? timer;
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
          if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {
            print("timer refresh: ${timerCount}");
            getBookingListOngoing();
            timer =
                Timer.periodic( Duration(minutes: timerCount), (timer) => getBookingListOngoing());
            setState(() {});

          }
        }else if (pickSettingsData[i].type == "lattitude" && widget.getBookingData!.guestLattitude==null) {
          lat = double.parse(pickSettingsData[i].description!);
          print("timer lat: ${timerCount}");
        } else if (pickSettingsData[i].type == "longitude"  && widget.getBookingData!.guestLongitude==null) {
          long = double.parse(pickSettingsData[i].description!);
          calculateDistance(widget.getBookingData!.vehicles![0].vehiclesDrivers!.longitude,widget.getBookingData!.vehicles![0].vehiclesDrivers!.lattitude);
          print("timer long: ${timerCount}");
        }
      }
    }
  }

  GetBookingListModel getBookingOngoingResponse=GetBookingListModel();

  getBookingListOngoing()async{
    print("phoneNmbr $userId");
    var mapData={
      "users_drivers_id": userId.toString()
    };
    getBookingOngoingResponse= await DioClient().getBookingOngoing(mapData, context);
    print("response id: ${getBookingOngoingResponse.data}");
    for(int i=0;i<getBookingOngoingResponse.data!.length;i++) {
      if (widget.getBookingData!.bookingsId==getBookingOngoingResponse.data![i].bookingsId) {
        lat = double.parse(getBookingOngoingResponse.data![i].guestLattitude!);
        long=double.parse(getBookingOngoingResponse.data![i].guestLongitude!);
        String? latt=getBookingOngoingResponse.data![i].vehicles![0].vehiclesDrivers!.lattitude;
        String? longg=getBookingOngoingResponse.data![i].vehicles![0].vehiclesDrivers!.longitude;
        calculateDistance(longg,latt);
        print("latt: ${getBookingOngoingResponse.data![i].guestLattitude!}");
        print("long: ${getBookingOngoingResponse.data![i].guestLongitude!}");
        setState(() {

        });
      }
    }


  }


  DistanceCalculatorModel distanceCalculatorModel=DistanceCalculatorModel();

String? distance="";
  calculateDistance(String? longg,String? latt)async{
    var jsonData={
      "from_lat":"${latt}",
      "from_long":"${longg}",
      "to_lat":"${lat}",
      "to_long":"${long}"
    };
    print("jsonjsonData: ${jsonData}");
    distanceCalculatorModel=await DioClient().distanceCalculate(jsonData, context);
    if(distanceCalculatorModel.data !=null){
      print("distanceeee: ${distanceCalculatorModel.data!.distance}");
      distance=distanceCalculatorModel.data!.distance;
      setState(() {

      });
    }
  }


  void initState() {
    getSystemAllData();

    addCustomIcon();
    if (widget.getBookingData != null) {

      print(
          "lat: ${widget.getBookingData!.guestLattitude}");
      print(
          "log: ${widget.getBookingData!.guestLongitude}");
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }



  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: getBookingOngoingResponse !=null && lat !=null && long !=null?
      Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
              CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: false,
              markers: {
                Marker(
                    markerId: MarkerId('Pakistan'),
                    position: LatLng(lat!, long!),
                    draggable: true,
                    icon: icon != null
                        ? icon!
                        : BitmapDescriptor.defaultMarker)
              },
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   barrierDismissible: false,
                  //   builder: (context) => driverReached(),
                  // );
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          if(widget.getBookingData!.driverTripStatus !=null)

                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.getBookingData!.status}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                               Text(
                                '${distance} Away',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Image.asset(
                                      'assets/images/user-profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.getBookingData!.name}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Regular',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.003),
                                        Text(
                                          '${widget.getBookingData!.contact}',
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontFamily: 'Montserrat-Regular',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        print("iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatPage(bookingId: widget.getBookingData!.bookingsId,usersDriverId: widget.getBookingData!.vehicles![0].usersDriversId,guestName: widget.getBookingData!.name,driverName: widget.getBookingData!.vehicles![0].vehiclesDrivers!.name),
                                            ));



                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/chat-icon.svg',
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.06),
                                    InkWell(
                                      onTap: () async {
                                        print("iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                                        Uri phoneno = Uri.parse('tel: ${widget.getBookingData!.contact}');
                                        if (await launchUrl(phoneno)) {
                                          //dialer opened
                                        }else{
                                          //dailer is not opened
                                        }
                                        print(
                                            "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/contact-icon.svg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/small-black-bookings-icon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  Text(
                                    '${widget.getBookingData!.pickupDate}',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: size.width * 0.14),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/clock-icon.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  Text(
                                    '${widget.getBookingData!.pickupTime}',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/clock-icon.svg',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: size.width * 0.032),
                              Text(
                                '${widget.getBookingData!.pickupTime}',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // SizedBox(width: size.width * 0.05),
                              // const Text(
                              //   'Waiting',
                              //   style: TextStyle(
                              //     color: primaryColor,
                              //     fontSize: 12,
                              //     fontFamily: 'Montserrat-Regular',
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 40,
                    width: 40,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        SvgPicture.asset('assets/images/back-icon.svg'),
                      ],
                    )),
              ),
            ),
          ],
        ),
      )
      : const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 175, top: 30),
          child: CircularProgressIndicator(),
        ),
      ],
    ),
    );
  }

  Widget driverReached() {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.height * 0.65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              CircleAvatar(
                radius: 45,
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                'Mohammad Irfan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/green-fast-car-icon.svg'),
                  SizedBox(width: size.width * 0.02),
                   Text(
                    '${widget.getBookingData!.routes!.pickup!.name}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat-Regular',
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              const Text(
                'Your Driver has\nReached on your Spot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
              SizedBox(height: size.height * 0.08),
              GestureDetector(
                  onTap: () async {
                    print("iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                    Uri phoneno = Uri.parse('tel: ${widget.getBookingData!.contact}');
                    if (await launchUrl(phoneno)) {
                    //dialer opened
                    }else{
                    //dailer is not opened
                    }
                    print(
                    "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                  },
                  child: dialogButtonTransparent('Contact', context)),
              SizedBox(height: size.height * 0.02),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const DropOffPage(),
              //         ));
              //   },
              //   child: dialogButton('Go a head', context),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
