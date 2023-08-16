import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/get_booking_list_model.dart';
import '../screens/tracking_process/track_screen.dart';
import '../utils/const.dart';

Widget onGoingList(BuildContext context,GetBookingListModel getBookingOngoingData) {
  var size = MediaQuery.of(context).size;
  return getBookingOngoingData.data !=null ?
  ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingOngoingData.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData=getBookingOngoingData.data![index];

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network("$imageUrl${getData.routes!.vehicles!.featureImage}"),
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
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-location-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        "${getData.routes!.pickup!.name}",
                        style: const TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Container(
                    width: 180,

                    child: Row(
                      children: [
                        for(int i=0; i<getData.vehicles!.length; i++)

                          Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: getData.vehicles!.length <4?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/small-black-car-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  '${getData.vehicles![i].vehiclesName!.name}',
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 7,
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ):
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: SvgPicture.asset('assets/images/small-black-car-icon.svg'),
                                  ),
                                  Text(
                                    '${getData.vehicles![i].vehiclesName!.name}',
                                    style: const TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 7,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
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
                          'assets/images/small-black-bookings-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        '${getData.bookingTime} ${getData.bookingDate}',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  TrackPage(getBookingData: getData),
                      ));
                },
                child: const Text(
                  'Track',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0066FF),
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      );
    },
  ):Container(
    height: 300,
    width: 300,
    child: const Center(child: Text("No Ongoing Booking")),
  );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz"),
];

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
