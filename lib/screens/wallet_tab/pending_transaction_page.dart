import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umrahcar_driver/models/driver_status_model.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import '../../models/pending_transaction_model.dart';
import '../../service/rest_api_service.dart';
import '../../utils/const.dart';
import '../../widgets/navbar.dart';
import '../add_card_page.dart';
import '../homepage_screen.dart';

class PendingTransactionPage extends StatefulWidget {
  const PendingTransactionPage({super.key});

  @override
  State<PendingTransactionPage> createState() => _PendingTransactionPageState();
}

class _PendingTransactionPageState extends State<PendingTransactionPage> {
  PendingTransactiontModel summaryAgentModel = PendingTransactiontModel();
  getSummaryAgent() async {
    print("userIdId ${userId}");
    var mapData = {"users_drivers_id": userId.toString()};
    summaryAgentModel = await DioClient().pendingTransactions(mapData, context);
    if (summaryAgentModel.data!.isNotEmpty) {
      print(
          "getProfileResponse name: ${summaryAgentModel.data![0].usersDriversAccountsId}");
    }
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    getSummaryAgent();
    // TODO: implement initState
    super.initState();
  }
DriverStatusModel deleteTransaction=DriverStatusModel();
  Future<void> _showAlertDialog(String? id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Delete Transaction',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Are you sure want to Delete Transaction?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('No', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes', style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () async {
                var jsonData = {"users_drivers_accounts_id": "$id"};
                deleteTransaction = await DioClient().deleteTransaction(jsonData, context);
                if (deleteTransaction.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text("${deleteTransaction.message}", style: Theme.of(context).textTheme.bodyMedium)),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => NavBar(indexNmbr: 3, walletPage: 2)),
                        (Route<dynamic> route) => false,
                  );
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: summaryAgentModel.data != null && summaryAgentModel.data!.isNotEmpty
          ? ListView.builder(
        itemCount: summaryAgentModel.data!.length,
        itemBuilder: (BuildContext context, i) {
          final flavor = summaryAgentModel.data![i];
          return Column(
            children: [
              Slidable(
                key: ValueKey(i),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => _showAlertDialog(flavor.usersDriversAccountsId),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(left: 15, right: 5),
                      decoration: const BoxDecoration(shape: BoxShape.rectangle),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Image.network("$imageUrl${flavor.image}", fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Txn Type: ${flavor.txnType!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Amount: ${flavor.amount!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Description: ${flavor.description!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Date: ${flavor.txnDate!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Accounts Head: ${flavor.accountsHeadsId!.name!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Driver: ${flavor.usersDriversId!.name!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.005),
                          Text(
                            "Company: ${flavor.usersDriversId!.companyName!}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Text(
                        flavor.status!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primaryColor,
                          fontSize: 12,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          );
        },
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Text(
              'No Pending Transaction Found',
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
}