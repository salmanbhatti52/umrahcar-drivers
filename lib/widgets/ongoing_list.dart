import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import '../models/get_booking_list_model.dart';
import '../screens/tracking_process/track_screen.dart';
import '../utils/const.dart';

Widget onGoingList(BuildContext context, GetBookingListModel getBookingOngoingData) {
  var size = MediaQuery.of(context).size;

  // Sort the data by pickup date and time
  if (getBookingOngoingData.data != null && getBookingOngoingData.data!.isNotEmpty) {
    getBookingOngoingData.data!.sort((a, b) {
      // Parse pickup_date and pickup_time into DateTime objects
      final DateTime dateTimeA = DateTime.parse(
        "${a.pickupDate} ${a.pickupTime}",
      );
      final DateTime dateTimeB = DateTime.parse(
        "${b.pickupDate} ${b.pickupTime}",
      );
      // Compare DateTime objects (earlier comes first)
      return dateTimeA.compareTo(dateTimeB);
    });
  }

  return getBookingOngoingData.data != null
      ? ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingOngoingData.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData = getBookingOngoingData.data![index];
      return InkWell(
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackPage(getBookingData: getData),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Theme.of(context).colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: Image.network("$imageUrl${getData.routes!.vehicles!.featureImage}"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.007),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getData.name!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
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
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),
                              SvgPicture.asset(
                                'assets/images1/small-black-location-icon.svg',
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              SizedBox(width: size.width * 0.01),
                              Text(
                                "${getData.routes!.pickup!.name}",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.005),
                          SizedBox(
                            width: 190,
                            child: Row(
                              children: [
                                for (int i = 0; i < getData.vehicles!.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: getData.vehicles!.length < 4
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images1/small-black-car-icon.svg',
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          '${getData.vehicles![i].vehiclesName!.name}',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: ConstantColor.darkgreyColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.01),
                                        if (getData.paymentType == "credit")
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images1/symbol.png',
                                                width: 10,
                                                height: 10,
                                              ),
                                              SizedBox(width: size.width * 0.01),
                                              Text(
                                                "credit",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: ConstantColor.darkgreyColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (getData.cashReceiveFromCustomer != "0")
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images1/symbol.png',
                                                width: 10,
                                                height: 10,
                                              ),
                                              SizedBox(width: size.width * 0.01),
                                              Text(
                                                "${getData.cashReceiveFromCustomer}",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: ConstantColor.darkgreyColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    )
                                        : Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: SvgPicture.asset(
                                              'assets/images1/small-black-car-icon.svg',
                                              color: Theme.of(context).colorScheme.onSurface,
                                            ),
                                          ),
                                          Text(
                                            '${getData.vehicles![i].vehiclesName!.name}',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: ConstantColor.darkgreyColor,
                                              fontSize: 10,
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
                                'assets/images1/small-black-bookings-icon.svg',
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              SizedBox(width: size.width * 0.01),
                              Text(
                                '${_formatDate(getData.pickupDate!)} ${_formatTime(getData.pickupTime!)}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.darkgreyColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      );
    },
  )
      : Padding(
    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
    child: Center(
      child: SvgPicture.asset(
        'assets/images1/noBooking.svg',
        width: 150,
        height: 150,
      ),
    ),
  );
}

String _formatDate(String date) {
  final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
  return DateFormat('d MMM yyyy').format(parsedDate);
}

String _formatTime(String time) {
  final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
  return DateFormat('h:mm a').format(parsedTime);
}

List myList = [
  MyList("assets/images/list-image-1.png", "Makkah Hottle Aziziz"),
];


class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
