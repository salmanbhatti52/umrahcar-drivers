import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/screens/tracking_process/track_upcoming_screen.dart';

import '../models/get_booking_list_model.dart';
import '../screens/tracking_process/track_screen.dart';
import '../utils/const.dart';

Widget upComingList(BuildContext context,GetBookingListModel getBookingUpcomingResponse) {
  var size = MediaQuery.of(context).size;
  return getBookingUpcomingResponse.data!=null ?
  ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingUpcomingResponse.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData=getBookingUpcomingResponse.data![index];

      return InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  TrackPage(getBookingData: getData),
              ));
        },
        child: Column(
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
                        Text(
                          "booking id: ${getData.bookingsId}",
                          style: const TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 8,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(width: size.width * 0.05),
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
                          '${getData.pickupTime} ${getData.pickupDate}',
                          style: const TextStyle(
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
                // SizedBox(width: size.width * 0.1),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  TrackPage(getBookingData: getData),
                        ));
                  },
                  child: const Text(
                    'Upcoming',
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
        ),
      );
    },
  ):Container(
    height: 300,
    width: 280,
    child: Center(child: const Text("No Upcoming Booking")),
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

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
