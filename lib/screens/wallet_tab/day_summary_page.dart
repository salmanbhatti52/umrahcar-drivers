import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../service/rest_api_service.dart';
import 'package:http/http.dart' as http;

import '../../utils/colors.dart';
import '../homepage_screen.dart';

class DaySummaryPage extends StatefulWidget {
  const DaySummaryPage({super.key});

  @override
  State<DaySummaryPage> createState() => _DaySummaryPageState();
}

class _DaySummaryPageState extends State<DaySummaryPage> {
  DateTime? selectedDate;
  String formattedDate = '';
  Map summaryData = {};
  String summaryErrorMessage = '';
  double totalFare = 0.0;
  double newTotal = 0.0;
  double expenses = 0.0;
  double finalTotal = 0.0;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2024),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });

      // Format the date using intl package
      formattedDate = selectedDate.toString();
      formattedDate = formattedDate.substring(0, 10);

      print(selectedDate);
      print(formattedDate);

      if (selectedDate != null) {
        getSummaryDrivers();
      }
      // setState(() {
      //   // msgTextFieldController.text =
      //   //     msgTextFieldController.text + formattedDate;
      // });
    }
  }

  getSummaryDrivers() async {
    summaryData = {};
    summaryErrorMessage = '';
    http.Response response =
        await sendPostRequest(action: '/get_summary_drivers', data: {
      'users_drivers_id': userId.toString(),
      'summary_date': formattedDate.toString(),
    });
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      debugPrint('response body123: $decodedData');
      summaryData = decodedData['data'];
      totalFare = 0.0;
      newTotal = 0.0;
      expenses = 0.0;
      finalTotal = 0.0;

      for(dynamic rec in summaryData['bookings_list']){
        totalFare = totalFare +  double.parse(
        rec['routes']['fare']);
      }
      print('totalFare: $totalFare');

      newTotal = totalFare + double.parse(summaryData['bookings_list'][0]['vehicles'][0]['vehicles_drivers']['wallet_amount']);
      print('newTotal: $newTotal');

      for(dynamic rec in summaryData['expenses']){
        expenses = expenses +  double.parse(rec['amount']);
      }
      print('expenses: $expenses');

      finalTotal = newTotal - expenses;
      print('finalTotal: $finalTotal');

    } else if (status == 'error') {
      debugPrint('error message: ${decodedData['message']}');
      summaryErrorMessage = decodedData['message'];
    } else {}
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                margin: const EdgeInsets.fromLTRB(0, 14, 12, 9),
                child: Row(
                  children: [
                    Text(
                      'Select Date: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Center(
                        child: Icon(
                          Icons.calendar_month,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              formattedDate.isNotEmpty
                  ? Row(
                      children: [
                        Text(
                          'Selected Date: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$formattedDate',
                        ),
                      ],
                    )
                  : SizedBox(),
              summaryErrorMessage.isNotEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 125.0),
                        child: Text('No Summary Found.'),
                      ),
                    )
                  : const SizedBox(),
              summaryData.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Fare',
                        ),
                        summaryData.isNotEmpty
                            ? Column(
                              children: [

                                ListView.builder(
                                                          padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                    itemCount: summaryData['bookings_list'].length,
                                    itemBuilder: (context, index) {
                                      return ReusableTile(
                                          label:
                                              'From: ${summaryData['bookings_list'][index]['routes']['pickup']['name']}\nTo: ${summaryData['bookings_list'][index]['routes']['dropoff']['name']}',
                                          value: summaryData['bookings_list']
                                              [index]['routes']['fare']);
                                    },
                                  ),
                                Divider(
                                  thickness: 3,
                                  color: Colors.black45,
                                  height: 14,
                                ),
                                ReusableTile(label: 'Total Fare', value: totalFare.toString()),
                                ReusableTile(label: 'Remaining Cash', value: summaryData['bookings_list'][0]['vehicles'][0]['vehicles_drivers']['wallet_amount']),
                                Divider(
                                  thickness: 3,
                                  color: Colors.black45,
                                  height: 14,
                                ),
                                ReusableTile(label: 'New Total', value: newTotal.toString()),
                                ReusableTile(label: 'Expenses', value: expenses.toString()),
                                Divider(
                                  thickness: 3,
                                  color: Colors.black45,
                                  height: 14,
                                ),
                                ReusableTile(label: 'Grand Total', value: finalTotal.toString()),
                              ],
                            )
                            : SizedBox(),

          
            //             SizedBox(
            //               height: 5,
            //             ),
            // summaryData.isNotEmpty? ReusableTile(
            //                                 label:
            //                                     'From: ${summaryData['bookings_list'][0]['routes']['pickup']['name']}\nTo: ${summaryData['bookings_list'][0]['routes']['dropoff']['name']}',
            //                                 value: summaryData['bookings_list']
            //                                     [0]['routes']['fare']):SizedBox(),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableTile extends StatelessWidget {
  const ReusableTile({super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }
}
