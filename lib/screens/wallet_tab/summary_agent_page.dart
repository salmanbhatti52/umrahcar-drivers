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
      body: summaryAgentModel.data !=null ?
      Padding(
        padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Driver Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                 Text(
                  '${summaryAgentModel.data!.driversName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Completed Trips',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Text(
                  '${summaryAgentModel.data!.totalCompletedTrips}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Driver Fare',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Text(
                  '${summaryAgentModel.data!.totalDriversFare}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Driver Receiving Debit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Text(
                  '${summaryAgentModel.data!.totalDriversReceivingsDebit}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Driver Receiving Credit',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Text(
                  '${summaryAgentModel.data!.totalDriversReceivingsCredit}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ), SizedBox(height: 20,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Driver Balance',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Text(
                  '${summaryAgentModel.data!.totalDriversBalance}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                )

              ],
            ),

          ],
        ),
      ):const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: EdgeInsets.only(left: 130),
            child: Text(
              'No Summary Found',
              style: TextStyle(
                color: Color(0xFF565656),
                fontSize: 12,

                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
    );
  }
}
