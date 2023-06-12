import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/tabbar_bookings.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Bookings',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              const TabbarBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
