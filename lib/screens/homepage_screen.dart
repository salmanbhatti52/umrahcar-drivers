import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/top_boxes.dart';
import 'package:umrahcar_driver/widgets/home_list.dart';

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
      body: Container(
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
              height: size.height * 0.158,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: CircleAvatar(
                      radius: 35,
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                  SizedBox(height: size.height * 0.03),
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
                    height: size.height * 0.511,
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
    );
  }
}
