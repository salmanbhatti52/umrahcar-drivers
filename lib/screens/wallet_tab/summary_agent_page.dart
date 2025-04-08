import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import '../../models/summary_agent_model.dart';
import '../../service/rest_api_service.dart';
import '../homepage_screen.dart';
import 'package:http/http.dart' as http;

class SummaryAgentPage extends StatefulWidget {
  const SummaryAgentPage({super.key});

  @override
  State<SummaryAgentPage> createState() => _SummaryAgentPageState();
}

class _SummaryAgentPageState extends State<SummaryAgentPage> {


  SummaryDriversModel summaryAgentModel=SummaryDriversModel();
  getSummaryAgent()async{
    print("userIdId ${userId}");
    var mapData={
      "users_drivers_id": userId.toString()
    };

    if(mounted){
      summaryAgentModel= await DioClient().summaryAgent(mapData, context);
      if(summaryAgentModel.data !=null ) {
        // print("getProfileResponse name: ${summaryAgentModel.data!.driversName}");
      }
      setState(() {

      });
    }
  }



  @override
  void initState() {
    getSummaryAgent();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: summaryAgentModel.data != null
          ? Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            buildSummaryRow('Driver Name', '${summaryAgentModel.data!.driversName}', context),
            SizedBox(height: 20),
            buildSummaryRow('Total Completed Trips', '${summaryAgentModel.data!.totalCompletedTrips}', context),
            SizedBox(height: 20),
            buildSummaryRow('Total Driver Fare', '${summaryAgentModel.data!.totalDriversFare}', context),
            SizedBox(height: 20),
            buildSummaryRow('Total Driver Receiving Debit', '${summaryAgentModel.data!.totalDriversReceivingsDebit}', context),
            SizedBox(height: 20),
            buildSummaryRow('Total Driver Receiving Credit', '${summaryAgentModel.data!.totalDriversReceivingsCredit}', context),
            SizedBox(height: 20),
            buildSummaryRow('Total Driver Balance', '${summaryAgentModel.data!.totalDriversBalance}', context, isBold: true),
          ],
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Text(
              'No Summary Found',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ConstantColor.darkgreyColor,
                fontSize: 12,
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryRow(String label, String value, BuildContext context, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            fontFamily: 'Montserrat-Regular',
            fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            fontFamily: 'Montserrat-Regular',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}