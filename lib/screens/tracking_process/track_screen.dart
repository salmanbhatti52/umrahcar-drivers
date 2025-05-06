import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:umrahcar_driver/models/driver_status_model.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/button.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/pickup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/get_all_system_data_model.dart';
import '../../models/get_booking_list_model.dart';
import '../../service/rest_api_service.dart';
import '../homepage_screen.dart';
import 'tarcking/chat_screen.dart';

class TrackPage extends StatefulWidget {
  GetBookingData? getBookingData;
  TrackPage({super.key, this.getBookingData});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(error, style: Theme.of(context).textTheme.bodyMedium),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  LatLng _initialCameraPosition = const LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat ?? 0.0, long ?? 0.0),
          zoom: 14,
        ),
      ),
    );
  }

  double? lat;
  double? long;
  BitmapDescriptor? markerIcon;

  String _formatDate(String date) {
    final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    return DateFormat('dd MMMM yyyy').format(parsedDate);
  }

  String _formatTime(String time) {
    final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  }

  void addCustomIcon() async {
    markerIcon = await getBitmapDescriptorFromAssetBytes("assets/images1/location.png", 50);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Timer? timer;
  GetAllSystemData getAllSystemData = GetAllSystemData();
  late List<String> driverStatus = [];
  String? selectedDriverStatusValue;

  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    if (getAllSystemData != null) {
      setState(() {
        getSettingsData();
        getDriverStatusData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;

  getSettingsData() {
    if (getAllSystemData.data != null) {
      for (int i = 0; i < getAllSystemData.data!.settings!.length; i++) {
        pickSettingsData.add(getAllSystemData.data!.settings![i]);
      }

      for (int i = 0; i < pickSettingsData.length; i++) {
        if (pickSettingsData[i].type == "map_refresh_time") {
          timerCount = int.parse(pickSettingsData[i].description!);
          if (widget.getBookingData!.vehicles![0].vehiclesDrivers != null) {
            getBookingListOngoing();
            timer = Timer.periodic(Duration(minutes: timerCount), (timer) => getBookingListOngoing());
            setState(() {});
          }
        } else if (pickSettingsData[i].type == "lattitude" && widget.getBookingData!.guestLattitude == null) {
          lat = double.parse(pickSettingsData[i].description!);
        } else if (pickSettingsData[i].type == "longitude" && widget.getBookingData!.guestLongitude == null) {
          long = double.parse(pickSettingsData[i].description!);
        }
      }
    }
  }

  getDriverStatusData() {
    driverStatus = [];
    if (getAllSystemData.data != null) {
      for (int i = 0; i < getAllSystemData.data!.bookingsDriversStatus!.length; i++) {
        driverStatus.add(getAllSystemData.data!.bookingsDriversStatus![i].name!);
      }
    }
  }

  GetBookingListModel getBookingOngoingResponse = GetBookingListModel();

  bool _hasShownDialog = false;

  getBookingListOngoing() async {
    var mapData = {"users_drivers_id": userId.toString()};
    getBookingOngoingResponse = await DioClient().getBookingOngoing(mapData, context);
    for (int i = 0; i < getBookingOngoingResponse.data!.length; i++) {
      if (widget.getBookingData!.bookingsId == getBookingOngoingResponse.data![i].bookingsId) {
        if (getBookingOngoingResponse.data![i].guestLattitude != null && getBookingOngoingResponse.data![i].guestLongitude != null) {
          lat = double.parse(getBookingOngoingResponse.data![i].guestLattitude!);
          long = double.parse(getBookingOngoingResponse.data![i].guestLongitude!);
          setState(() {});
        } else if (!_hasShownDialog) {
          // Show dialog if guest_lattitude and guest_longitude are null
          _hasShownDialog = true; // Prevent showing dialog again
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Not Updated'),
                content: const Text(
                  'Guest location is not updated due to some reason. You will see the details once the guest location is updated.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void initState() {
    getSystemAllData();
    _initialCameraPosition = const LatLng(20.5937, 78.9629);
    addCustomIcon();
    if (widget.getBookingData != null) {
      if (widget.getBookingData!.driverTripStatus != null) {
        selectedDriverStatusValue = widget.getBookingData!.driverTripStatus!.name;
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  DriverStatusModel driverStatusModel = DriverStatusModel();

  changeDriverStatus(String? statusValue) async {
    var jsonData = {
      "bookings_id": "${widget.getBookingData!.bookingsId}",
      "driver_trip_status": "$statusValue"
    };
    driverStatusModel = await DioClient().driverStatus(jsonData, context);
    if (driverStatusModel.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Theme.of(context).colorScheme.primary, content: Text("${driverStatusModel.message}", style: Theme.of(context).textTheme.bodyMedium)),
      );
    }
  }

  Set<Marker> _buildMarkers() {
    return {
      Marker(
        markerId: const MarkerId('Pakistan'),
        position: LatLng(lat ?? 0.0, long ?? 0.0),
        draggable: true,
        icon: markerIcon ?? BitmapDescriptor.defaultMarker,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("lat: $lat");
    print("long: $long");
    print("getBookingOngoingResponse: ${getBookingOngoingResponse.data}");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getBookingOngoingResponse.data != null && lat != null && long != null
          ? Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.28,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: _initialCameraPosition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: false,
                markers: _buildMarkers(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Bookings Details',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 20),
                            if (widget.getBookingData!.driverTripStatus != null &&
                                widget.getBookingData!.driverTripStatus!.name != "Ride End")
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  width: size.width,
                                  height: 55,
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        isDense: true,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(top: 3),
                                          child: SvgPicture.asset(
                                            'assets/images/dropdown-icon.svg',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.scaleDown,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'Driver Status',
                                          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: ConstantColor.greyColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        items: driverStatus.map(
                                              (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: ConstantColor.greyColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ).toList(),
                                        value: selectedDriverStatusValue,
                                        onChanged: selectedDriverStatusValue == "Ride End"
                                            ? null
                                            : (String? value) {
                                          setState(() {
                                            selectedDriverStatusValue = value;
                                            for (int i = 0; i < getAllSystemData.data!.bookingsDriversStatus!.length; i++) {
                                              if (selectedDriverStatusValue == getAllSystemData.data!.bookingsDriversStatus![i].name) {
                                                String statusId = getAllSystemData.data!.bookingsDriversStatus![i].bookingsDriversStatusId!;
                                                changeDriverStatus(statusId);
                                                setState(() {});
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '(Booking Id ${widget.getBookingData!.bookingsId})',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Pickup Location',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.routes!.pickup!.name} (${widget.getBookingData!.routes!.pickup!.type})',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Drop off Location',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.routes!.dropoff!.name} (${widget.getBookingData!.routes!.dropoff!.type})',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Text(
                          'Pickup Hotel',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.pickupHotel!.name}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Drop off Hotel',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.dropoffHotel!.name}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Row(
                          children: [
                            for (int i = 0; i < widget.getBookingData!.vehicles!.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/fast-car-icon.svg',
                                      width: 10,
                                      height: 10,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Text(
                                      '${widget.getBookingData!.vehicles![i]!.vehiclesName!.name}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: ConstantColor.darkgreyColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/small-black-bookings-icon.svg',
                                  width: 20,
                                  height: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                SizedBox(width: size.width * 0.032),
                                Text(
                                  '${widget.getBookingData!.pickupDate}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ConstantColor.darkgreyColor,
                                    fontSize: 12,
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
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                SizedBox(width: size.width * 0.032),
                                Text(
                                  '${widget.getBookingData!.pickupTime}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ConstantColor.darkgreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                          thickness: 1,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  child: Image.asset(
                                    'assets/images/user-profile.png',
                                    fit: BoxFit.cover,
                                    // color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.032),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: Text(
                                    '${widget.getBookingData!.name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.115),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/passenger-icon.svg',
                                  width: 20,
                                  height: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                SizedBox(width: size.width * 0.045),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: Text(
                                    '(${widget.getBookingData!.noOfPassengers} Passengers)',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                Uri phoneno = Uri.parse('tel:${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}');
                                if (await launchUrl(phoneno)) {
                                  // Dialer opened
                                } else {
                                  // Dialer not opened
                                }
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/contact-icon.svg',
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  SizedBox(
                                    width: size.width * 0.275,
                                    child: Text(
                                      '${widget.getBookingData!.contact}',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: ConstantColor.darkgreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: size.width * 0.14),
                            // InkWell(
                            //   onTap: () {
                            //     _launchURL('https://wa.me/${widget.getBookingData!.whatsapp}/?text=hello');
                            //     setState(() {});
                            //   },
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(
                            //         'assets/images/whatsapp-icon.svg',
                            //         color: Theme.of(context).colorScheme.onSurface,
                            //       ),
                            //       SizedBox(width: size.width * 0.032),
                            //       SizedBox(
                            //         width: size.width * 0.275,
                            //         child: Text(
                            //           '${widget.getBookingData!.whatsapp}',
                            //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            //             color: ConstantColor.darkgreyColor,
                            //             fontSize: 12,
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      bookingId: widget.getBookingData!.bookingsId,
                                      usersDriverId: widget.getBookingData!.vehicles![0].usersDriversId,
                                      guestName: widget.getBookingData!.name,
                                      driverName: widget.getBookingData!.vehicles![0].vehiclesDrivers!.name,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/chat-icon.svg',
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  SizedBox(width: size.width * 0.032),
                                  SizedBox(
                                    width: size.width * 0.275,
                                    child: Text(
                                      'Chat',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: ConstantColor.darkgreyColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: size.height * 0.02),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => ChatPage(
                        //           bookingId: widget.getBookingData!.bookingsId,
                        //           usersDriverId: widget.getBookingData!.vehicles![0].usersDriversId,
                        //           guestName: widget.getBookingData!.name,
                        //           driverName: widget.getBookingData!.vehicles![0].vehiclesDrivers!.name,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: Row(
                        //     children: [
                        //       SvgPicture.asset(
                        //         'assets/images/chat-icon.svg',
                        //         color: Theme.of(context).colorScheme.onSurface,
                        //       ),
                        //       SizedBox(width: size.width * 0.032),
                        //       SizedBox(
                        //         width: size.width * 0.275,
                        //         child: Text(
                        //           'Chat',
                        //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        //             color: ConstantColor.darkgreyColor,
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: size.height * 0.02),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                          thickness: 1,
                        ),
                        if (widget.getBookingData!.cashReceiveFromCustomer != "0")
                          SizedBox(height: size.height * 0.02),
                        if (widget.getBookingData!.cashReceiveFromCustomer != "0")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cash Receive From Customer',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.greyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                'cash (${widget.getBookingData!.cashReceiveFromCustomer})',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: size.height * 0.02),
                        SizedBox(height: size.height * 0.03),
                        selectedDriverStatusValue == "Ride End" ||
                            (widget.getBookingData!.driverTripStatus != null && widget.getBookingData!.driverTripStatus!.name == "Ride End")
                            ? GestureDetector(
                          onTap: () {},
                          child: button('Completed', context),
                        )
                            : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PickUpPage(getBookingData: widget.getBookingData),
                              ),
                            );
                          },
                          child: button('Track Passenger', context),
                        ),
                        SizedBox(height: size.height * 0.02),
                      ],
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/back-icon.svg',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 175, top: 30),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}