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
        formattedDate = selectedDate.toString().substring(0, 10);
        getSummaryDrivers();
      });
    }
  }

  getSummaryDrivers() async {
    summaryData = {};
    summaryErrorMessage = '';
    http.Response response = await sendPostRequest(action: '/get_summary_drivers', data: {
      'users_drivers_id': userId.toString(),
      'summary_date': formattedDate,
    });
    var decodedData = jsonDecode(response.body);
    String status = decodedData['status'];
    if (status == 'success') {
      summaryData = decodedData['data'];
      totalFare = 0.0;
      newTotal = 0.0;
      expenses = 0.0;
      finalTotal = 0.0;

      for (dynamic rec in summaryData['bookings_list']) {
        totalFare += double.parse(rec['routes']['fare']);
      }
      newTotal = totalFare + double.parse(summaryData['bookings_list'][0]['vehicles'][0]['vehicles_drivers']['wallet_amount']);
      for (dynamic rec in summaryData['expenses']) {
        expenses += double.parse(rec['amount']);
      }
      finalTotal = newTotal - expenses;
    } else if (status == 'error') {
      summaryErrorMessage = decodedData['message'];
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (formattedDate.isNotEmpty)
                Row(
                  children: [
                    Text(
                      'Selected Date: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              if (summaryErrorMessage.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 125.0),
                    child: Text(
                      'No Summary Found.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              if (summaryData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Fare',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: summaryData['bookings_list'].length,
                      itemBuilder: (context, index) {
                        return ReusableTile(
                          label: 'From: ${summaryData['bookings_list'][index]['routes']['pickup']['name']}\nTo: ${summaryData['bookings_list'][index]['routes']['dropoff']['name']}',
                          value: summaryData['bookings_list'][index]['routes']['fare'],
                        );
                      },
                    ),
                    Divider(
                      thickness: 3,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      height: 14,
                    ),
                    ReusableTile(label: 'Total Fare', value: totalFare.toString()),
                    ReusableTile(label: 'Total Wallet Balance', value: summaryData['bookings_list'][0]['vehicles'][0]['vehicles_drivers']['wallet_amount']),
                    Divider(
                      thickness: 3,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      height: 14,
                    ),
                    ReusableTile(label: 'New Total', value: newTotal.toString()),
                    ReusableTile(label: 'Expenses', value: expenses.toString()),
                    Divider(
                      thickness: 3,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      height: 14,
                    ),
                    ReusableTile(label: 'Grand Total', value: finalTotal.toString()),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableTile extends StatelessWidget {
  final String label;
  final String value;

  const ReusableTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}