import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_driver/widgets/button.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/chat_screen.dart';
import 'package:umrahcar_driver/screens/tracking_process/tarcking/dropoff_screen.dart';

class PickUpPage extends StatefulWidget {
  const PickUpPage({super.key});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/pickup-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.442,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF000000).withOpacity(0.15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.03),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'On the Way',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '12 Km Away',
                              style: TextStyle(
                                color: Color(0xFF79BF42),
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Image.asset(
                                    'assets/images/user-profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.04),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Cameron William',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Montserrat-Regular',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.003),
                                      const Text(
                                        '0901344934849',
                                        style: TextStyle(
                                          color: Color(0xFF929292),
                                          fontSize: 12,
                                          fontFamily: 'Montserrat-Regular',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatPage(),
                                          ));
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/chat-icon.svg',
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.06),
                                  SvgPicture.asset(
                                    'assets/images/contact-icon.svg',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/small-black-bookings-icon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: size.width * 0.032),
                                const Text(
                                  '2 Jun 2022',
                                  style: TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 12,
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.14),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/clock-icon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: size.width * 0.032),
                                const Text(
                                  '12:00 AM',
                                  style: TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 12,
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Divider(
                          color: const Color(0xFF929292).withOpacity(0.3),
                          thickness: 1,
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/green-location-icon.svg',
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(width: size.width * 0.04),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pickup Location',
                                  style: TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 12,
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.005),
                                SizedBox(
                                  width: size.width * 0.7,
                                  child: const AutoSizeText(
                                    '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    minFontSize: 12,
                                    maxFontSize: 12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const DropOffPage(),
                            );
                          },
                          child: button('Picked', context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/images/back-icon.svg')),
            ),
          ],
        ),
      ),
    );
  }
}
