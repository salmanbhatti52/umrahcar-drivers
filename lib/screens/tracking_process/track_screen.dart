import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/button.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/pickup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/get_booking_list_model.dart';
class TrackPage extends StatefulWidget {
  GetBookingData? getBookingData;
  TrackPage({super.key,this.getBookingData});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {


  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
              'assets/images/track-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.56,
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
                        const Text(
                          'Bookings Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Pickup Location',
                          style: TextStyle(
                            color: Color(0xFF929292),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.routes!.pickup!.name} (${widget.getBookingData!.routes!.pickup!.type})',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Drop off Location',
                          style: TextStyle(
                            color: Color(0xFF929292),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          '${widget.getBookingData!.routes!.dropoff!.name} (${widget.getBookingData!.routes!.dropoff!.type})',
                          style: const TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Row(
                          children: [
                            for(int i=0; i<widget.getBookingData!.vehicles!.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/fast-car-icon.svg',
                                      width: 10,
                                      height: 10,
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Text(
                                      '${widget.getBookingData!.vehicles![i]!.vehiclesName!.name}',
                                      style: const TextStyle(
                                        color: Color(0xFF565656),
                                        fontSize: 10,
                                        fontFamily: 'Montserrat-Regular',
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
                                  style: TextStyle(
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
                        Divider(
                          color: const Color(0xFF929292).withOpacity(0.3),
                          thickness: 1,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  child: Image.asset(
                                    'assets/images/user-profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.032),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child:  Text(
                                    '${widget.getBookingData!.name}',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
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
                                ),
                                SizedBox(width: size.width * 0.045),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child:  Text(
                                    '(${widget.getBookingData!.noOfPassengers} Passengers)',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
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
                              onTap: ()async {
                                Uri phoneno = Uri.parse('tel: ${widget.getBookingData!.vehicles![0].vehiclesDrivers!.contact}');
                                if (await launchUrl(phoneno)) {
                                  //dialer opened
                                }else{
                                  //dailer is not opened
                                }
                                print(
                                    "iddddd ${widget.getBookingData!.vehicles![0].usersDriversId}");
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/contact-icon.svg'),
                                  SizedBox(width: size.width * 0.032),
                                  SizedBox(
                                    width: size.width * 0.275,
                                    child:  Text(
                                      '${widget.getBookingData!.contact}',
                                      style: const TextStyle(
                                        color: Color(0xFF565656),
                                        fontSize: 12,
                                        fontFamily: 'Montserrat-Regular',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: size.width * 0.14),
                            InkWell(
                              onTap: (){
                                _launchURL(
                                    'https://wa.me/${widget.getBookingData!.whatsapp}/?text=hello');
                                setState(() {

                                });
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/whatsapp-icon.svg'),
                                  SizedBox(width: size.width * 0.032),
                                  SizedBox(
                                    width: size.width * 0.275,
                                    child:  Text(
                                      '${widget.getBookingData!.whatsapp}',
                                      style: const TextStyle(
                                        color: Color(0xFF565656),
                                        fontSize: 12,
                                        fontFamily: 'Montserrat-Regular',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Divider(
                          color: const Color(0xFF929292).withOpacity(0.3),
                          thickness: 1,
                        ),
                        if(widget.getBookingData!.bookedFare !="0")
                          SizedBox(height: size.height * 0.01),
                        if(widget.getBookingData!.bookedFare !="0")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Booked Fare',
                                style: TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              widget.getBookingData!.paymentType=="credit"?
                              const Text(
                                'credit',
                                style: TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ):
                              Text(
                                '${widget.getBookingData!.bookedFare}',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        if(widget.getBookingData!.cashReceiveFromCustomer != "0")

                          SizedBox(height: size.height * 0.02),
                        if(widget.getBookingData!.cashReceiveFromCustomer != "0")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cash Receive From Customer',
                                style: TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                'credit (${widget.getBookingData!.cashReceiveFromCustomer})',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: size.height * 0.02),

                        SizedBox(height: size.height * 0.03),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  PickUpPage(getBookingData: widget.getBookingData),
                                ));
                          },
                          child: button('Track', context),
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
                child: SvgPicture.asset('assets/images/back-icon.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
