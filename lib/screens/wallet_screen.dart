import 'package:flutter/material.dart';
import 'package:umrahcar_driver/screens/wallet_tab/wallet_tabbar.dart';

import '../models/summary_agent_model.dart';
import '../service/rest_api_service.dart';
import '../utils/colors.dart';
import 'add_card_page.dart';
import 'homepage_screen.dart';

class WalletPage extends StatefulWidget {
  int? indexNmbr = 0;
  WalletPage({super.key, this.indexNmbr});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  SummaryDriversModel getAgentsWidgetData = SummaryDriversModel();
  getSummaryAgent() async {
    print("userIdId $userId");
    var mapData = {"users_drivers_id": userId.toString()};
    if (mounted) {
      getAgentsWidgetData = await DioClient().summaryAgent(mapData, context);
      if (getAgentsWidgetData.data != null) {
        // print("getProfileResponse name: ${getAgentsWidgetData.data!.totalDriversBalance}");
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    getSummaryAgent();
    print(" widget.indexNmbr: ${widget.indexNmbr}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Active Tracking'),
              content: const Text(
                'Closing the app will stop location updates. '
                    'This may affect your active bookings.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            Navigator.of(context).pop(result);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: getAgentsWidgetData.data != null
            ? Container(
          decoration: BoxDecoration(
            color: primaryColor, // Blue header retained
          ),
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                width: size.width,
                height: size.height * 0.1128,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      'My Wallet',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bignoimagebox(
                              '${getAgentsWidgetData.data!.totalDriversBalance}',
                              'Wallet Amount',
                              context),
                          SizedBox(width: size.width * 0.04),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddCardPage(),
                                ),
                              );
                              setState(() {});
                            },
                            child: bignoimageredbox('Debit/Credit', 'Transactions', context),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      widget.indexNmbr == null
                          ? WalletTabBarScreen(indexNmbr: 0)
                          : WalletTabBarScreen(indexNmbr: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            : SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

Widget bignoimagebox(String priceText, String titleText, BuildContext context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: primaryColor, // Blue box retained
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            priceText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bignoimageredbox(String priceText, String titleText, BuildContext context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0, -1),
          end: Alignment(0.037, 1.01),
          colors: [Color(0xffE03B3B), Color(0xffBF4242)],
          stops: [0, 1],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            priceText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}