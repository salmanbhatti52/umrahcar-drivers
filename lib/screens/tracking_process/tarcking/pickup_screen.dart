import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../models/get_booking_list_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/button.dart';
import 'chat_screen.dart';
import 'dropoff_screen.dart';

class PickUpPage extends StatefulWidget {
  GetBookingData? getBookingData;
  PickUpPage({super.key,this.getBookingData});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/pickup-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => driverReached(),
                  );
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
                                '${widget.getBookingData!.driverTripStatus!.name}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '12 Km Away',
                                style: TextStyle(
                                  color: Color(0xFF79BF42),
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
                                          '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.name}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Montserrat-Regular',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.003),
                                        Text(
                                          '${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}',
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
                                    SvgPicture.asset(
                                      'assets/images/contact-icon.svg',
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
                              SizedBox(width: size.width * 0.05),
                              const Text(
                                'Waiting',
                                style: TextStyle(
                                  color: Color(0xFF79BF42),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                  child: SvgPicture.asset('assets/images/back-icon.svg')),
            ),
          ],
        ),
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
                  const Text(
                    'Tesla S45 , Model 2022',
                    style: TextStyle(
                      color: Color(0xFF79BF42),
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
                  onTap: () {
                    print("iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatPage(bookingId: widget.getBookingData!.bookingsId,usersDriverId: widget.getBookingData!.vehicles![0].usersDriversId,guestName: widget.getBookingData!.name,driverName: widget.getBookingData!.vehicles![0].vehiclesDrivers!.name),
                        ));
                  },
                  child: dialogButtonTransparent('Contact', context)),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DropOffPage(),
                      ));
                },
                child: dialogButton('Go a head', context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
