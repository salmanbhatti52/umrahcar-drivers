import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class TrackCompletedPage extends StatefulWidget {
  const TrackCompletedPage({super.key});

  @override
  State<TrackCompletedPage> createState() => _TrackCompletedPageState();
}

class _TrackCompletedPageState extends State<TrackCompletedPage> {
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
              'assets/images/track-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.47,
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
                        const Text(
                          'Bookings Detsils',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Pickup Location',
                          style: TextStyle(
                            color: Color(0xFF929292),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Drop off Location',
                          style: TextStyle(
                            color: Color(0xFF929292),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/fast-car-icon.svg',
                              width: 12,
                              height: 12,
                            ),
                            SizedBox(width: size.width * 0.02),
                            const Text(
                              'BMW 3 Series, 2005 Model',
                              style: TextStyle(
                                color: Color(0xFF565656),
                                fontSize: 12,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
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
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  child: Image.asset(
                                    'assets/images/user-profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.032),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: const Text(
                                    'Cameron',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.115),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/passenger-icon.svg',
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: size.width * 0.045),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: const Text(
                                    '(4 passengers)',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/contact-icon.svg'),
                                SizedBox(width: size.width * 0.032),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: const Text(
                                    '+9660359875631',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: size.width * 0.14),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/images/whatsapp-icon.svg'),
                                SizedBox(width: size.width * 0.032),
                                SizedBox(
                                  width: size.width * 0.275,
                                  child: const Text(
                                    '+9660359875631',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Montserrat-Regular',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
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
                child: SvgPicture.asset('assets/images/back-icon.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
