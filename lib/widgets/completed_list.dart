import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar_driver/screens/homepage_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/get_booking_list_model.dart';
import '../utils/const.dart';

Future<void> generateSingleBookingPDF(GetBookingData booking) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Container(
        padding: const pw.EdgeInsets.all(16),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Booking Details', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text("Name: ${booking.name}", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text("Booking ID: ${booking.bookingsId}"),
            pw.Text("Pickup: ${booking.routes?.pickup?.name ?? 'N/A'}"),
            pw.Text("Date & Time: ${_formatDate(booking.pickupDate!)} ${_formatTime(booking.pickupTime!)}"),
            if (booking.vehicles != null)
              pw.Text("Vehicles: ${booking.vehicles!.map((v) => v.vehiclesName?.name ?? '').join(', ')}"),
            if (booking.paymentType == "credit") pw.Text("Payment: Credit"),
            if (booking.cashReceiveFromCustomer != "0")
              pw.Text("Cash Received: ${booking.cashReceiveFromCustomer}"),
          ],
        ),
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}


Widget completedList(BuildContext context, GetBookingListModel getBookingCompletedResponse) {
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
                          width: 80,
                          height: 80,
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
                        width: 180,
                        child: Wrap(
                          spacing: 4, // Horizontal spacing between items
                          runSpacing: 4, // Vertical spacing between wrapped lines
                          children: [
                            // Vehicle list
                            for (int i = 0; i < getData.vehicles!.length; i++)
                              getData.vehicles!.length < 4
                                  ? Row(
                                mainAxisSize: MainAxisSize.min, // Minimize Row width
                                children: [
                                  SvgPicture.asset(
                                    'assets/images1/small-black-car-icon.svg',
                                    color: Theme.of(context).colorScheme.onSurface,
                                    width: 10, // Reduced size for compactness
                                    height: 10,
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Text(
                                    '${getData.vehicles![i].vehiclesName!.name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Truncate long names
                                    maxLines: 1,
                                  ),
                                ],
                              )
                                  : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: SvgPicture.asset(
                                      'assets/images1/small-black-car-icon.svg',
                                      color: Theme.of(context).colorScheme.onSurface,
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                  Text(
                                    '${getData.vehicles![i].vehiclesName!.name}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ConstantColor.darkgreyColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            // Payment details (displayed once, outside vehicle loop)
                            if (getData.paymentType == "credit")
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // const Icon(
                                  //   Icons.attach_money,
                                  //   size: 10,
                                  //   color: ConstantColor.darkgreyColor,
                                  // ),
                                  Image.asset(
                                    'assets/images1/symbol.png',
                                    width: 10,
                                    height: 10,
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  // Text(
                                  //   currencySymbol.toString(),
                                  //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  //     color: ConstantColor.navBarTextColor,
                                  //     fontSize: 10,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Icon(
                                  //   Icons.attach_money,
                                  //   size: 10,
                                  //   color: ConstantColor.darkgreyColor,
                                  // ),
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
                      SizedBox(height: size.height * 0.003),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Completed',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ConstantColor.secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          GestureDetector(
                            onTap: () => generateSingleBookingPDF(getData),
                            child: Text(
                              'Download PDF',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ConstantColor.secondaryColor.withOpacity(0.7),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      );
    },
  )
      : SizedBox(
    height: 300,
    width: 300,
    child: Center(
      child: Text(
        "No Completed Booking",
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