import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar_driver/screens/tracking_process/track_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import '../models/get_booking_list_model.dart';
import '../utils/const.dart';

void _showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  );
}

Widget upComingList(BuildContext context, GetBookingListModel getBookingUpcomingResponse) {
  var size = MediaQuery.of(context).size;
  return getBookingUpcomingResponse.data != null
      ? ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingUpcomingResponse.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var getData = getBookingUpcomingResponse.data![index];

      return InkWell(
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: () {
          if (getData.vehicles != null && getData.vehicles!.isNotEmpty && index < getData.vehicles!.length) {
            if (getData.vehicles![index].vehiclesDrivers?.lattitude == null) {
              _showSnackbar(context, "Wait for Acceptance");
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackPage(getBookingData: getData),
                ),
              );
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackPage(getBookingData: getData),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 8),
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network("$imageUrl${getData.routes!.vehicles!.featureImage}"),
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
                              SizedBox(width: size.width * 0.01),
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
                            width: 180,
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
                                              Icon(
                                                Icons.attach_money,
                                                size: 10,
                                                color: ConstantColor.darkgreyColor,
                                              ),
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
                                              Icon(
                                                Icons.attach_money,
                                                size: 10,
                                                color: ConstantColor.darkgreyColor,
                                              ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TrackPage(getBookingData: getData),
                                  ),
                                );
                              },
                              child: Text(
                                '${getData.status}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ConstantColor.secondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
      : SizedBox(
    height: 300,
    width: 280,
    child: Center(
      child: Text(
        "No Upcoming Booking",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
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