import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar_driver/screens/tracking_process/track_completed_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import '../models/get_booking_list_model.dart';
import '../utils/const.dart';

Widget completedList(
    BuildContext context, GetBookingListModel getBookingCompletedResponse) {
  var size = MediaQuery.of(context).size;
  return getBookingCompletedResponse.data != null
      ? ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: getBookingCompletedResponse.data!.length,
          itemBuilder: (BuildContext context, int index) {
            var getData = getBookingCompletedResponse.data![index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 8, bottom: 8, left: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                    "$imageUrl${getData.routes!.vehicles!.featureImage}"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.005),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getData.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "booking id: ${getData.bookingsId}",
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.02),
                                SvgPicture.asset(
                                    'assets/images1/small-black-location-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  "${getData.routes!.pickup!.name}",
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.005),
                            SizedBox(
                              width: 180,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < getData.vehicles!.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: getData.vehicles!.length < 4
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/images1/small-black-car-icon.svg'),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Text(
                                                  '${getData.vehicles![i].vehiclesName!.name}',
                                                  style: const TextStyle(
                                                    color: Color(0xFF565656),
                                                    fontSize: 10,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                if (getData.paymentType ==
                                                    "credit")
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .attach_money, // This is the currency icon
                                                        size: 10,
                                                        color:
                                                            Color(0xFF565656),
                                                      ),
                                                      Text(
                                                        "credit",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF565656),
                                                          fontSize: 10,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (getData
                                                        .cashReceiveFromCustomer !=
                                                    "0")
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .attach_money, // This is the currency icon
                                                        size: 10,
                                                        color:
                                                            Color(0xFF565656),
                                                      ),
                                                      Text(
                                                        "${getData.cashReceiveFromCustomer}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF565656),
                                                          fontSize: 10,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: SvgPicture.asset(
                                                        'assets/images1/small-black-car-icon.svg'),
                                                  ),
                                                  Text(
                                                    '${getData.vehicles![i].vehiclesName!.name}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF565656),
                                                      fontSize: 10,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images1/small-black-bookings-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  '${_formatDate(getData.pickupDate!)} ${_formatTime(getData.pickupTime!)}',
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.003),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>  TrackPage(getBookingData: getData),
                                //     ));
                              },
                              child: const Text(
                                'Completed',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ConstantColor.secondaryColor,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        // SizedBox(width: size.width * 0.10),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            );
          },
        )
      : const SizedBox(
          height: 300,
          width: 300,
          child: Center(child: Text("No Completed Booking")),
        );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
];
String _formatDate(String date) {
  final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
  return DateFormat('d MMM yyyy').format(parsedDate);
}

String _formatTime(String time) {
  final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
  return DateFormat('h:mm a').format(parsedTime);
}

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
