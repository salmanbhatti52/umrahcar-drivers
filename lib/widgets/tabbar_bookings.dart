import 'package:flutter/material.dart';
import 'package:umrahcar_driver/screens/booking_process/tab_screens/ongoing_screen.dart';
import 'package:umrahcar_driver/screens/booking_process/tab_screens/upcoming_screen.dart';
import 'package:umrahcar_driver/screens/booking_process/tab_screens/completed_screen.dart';

class TabbarBookings extends StatefulWidget {
  int? indexNmbr=0;
   TabbarBookings({super.key,this.indexNmbr});

  @override
  State<TabbarBookings> createState() => _TabbarBookingsState();
}

abstract class TickerProvider {}

class _TabbarBookingsState extends State<TabbarBookings>
    with TickerProviderStateMixin {
  List<String> tabs = ["On Going", "Upcoming", "Completed"];
  int index=0;
  @override
  void initState() {
    if(widget.indexNmbr !=null){
      index=widget.indexNmbr!;
      setState(() {

      });
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this,initialIndex: index);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.055,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF000000).withOpacity(0.15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFF79BF42),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorColor: const Color(0xFF79BF42),
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: const Color(0xFF929292),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 12,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: "On Going"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: tabController,
            children: const [
              OnGoingPage(),
              UpcomingPage(),
              CompletedPage(),
            ],
          ),
        ),
      ],
    );
  }
}
