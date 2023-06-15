import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_driver/widgets/top_boxes.dart';
import 'package:umrahcar_driver/widgets/home_list.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/dropoff_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  width: size.width,
                  height: size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 35,
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mohammad Irfan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: size.height * 0.002),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/white-location-icon.svg'),
                              SizedBox(width: size.width * 0.01),
                              const Text(
                                '6391 Elgin St. Celina, ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6, left: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ),
                          child: SvgPicture.asset(
                              'assets/images/green-notification-icon.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          box('assets/images/white-fast-car-icon.svg', '30',
                              'On Going Bookings', context),
                          box('assets/images/white-fast-car-icon.svg', '10',
                              'Upcoming Bookings', context),
                          box('assets/images/white-fast-car-icon.svg', '15',
                              'Completed Bookings', context),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Bookings',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const BookingsPage(),
                            //         ));
                            //   },
                            //   child: const Text(
                            //     'See all',
                            //     textAlign: TextAlign.right,
                            //     style: TextStyle(
                            //       color: Color(0xFF79BF42),
                            //       fontFamily: 'Montserrat-Regular',
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 12,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        color: Colors.transparent,
                        height: size.height * 0.279,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: homeList(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DropOffPage(),
                    ));
              },
              child: Container(
                width: size.width,
                height: size.height * 0.245,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'On Going Booking',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/homepage-map.png',
                          ),
                          Positioned(
                            top: 15,
                            left: 115,
                            child: SvgPicture.asset(
                                'assets/images/home-green-location-icon.svg'),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                child: Image.asset(
                                  'assets/images/user-profile.png',
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),
                              const Text(
                                'Camiron Williosm',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/location-icon.svg'),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.25,
                                child: const AutoSizeText(
                                  '6391 Elgin St. Celina,',
                                  style: TextStyle(
                                    color: Color(0xFF565656),
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8,
                                  ),
                                  minFontSize: 8,
                                  maxFontSize: 8,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
