import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar_driver/widgets/button.dart';

class DropOffPage extends StatefulWidget {
  const DropOffPage({super.key});

  @override
  State<DropOffPage> createState() => _DropOffPageState();
}

class _DropOffPageState extends State<DropOffPage> {
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
              'assets/images/dropoff-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.28,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'On the Way',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '45 Km Away',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        const Text(
                          'Moving toward the final Destination',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
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
                                  'Drop-off Location',
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
                              builder: (context) => completedRide(),
                            );
                          },
                          child: button('Dropped', context),
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

  Widget completedRide() {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.height * 0.72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              const Text(
                'Congratulations!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                'You have Dropped your Guest Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Container(
                color: Colors.transparent,
                width: size.width,
                height: size.height * 0.25,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: SvgPicture.asset(
                          'assets/images/location-path-icon.svg'),
                    ),
                    const Positioned(
                      top: 83,
                      left: 10,
                      child: Text(
                        '12 Km',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 22,
                      left: 10,
                      child: Text(
                        '45 Km',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      left: 70,
                      child: Text(
                        'My Location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                    Positioned(
                      top: 74,
                      left: 70,
                      child: Text(
                        '2972 Westheimer Rd. Santa Ana,\nIllinois 85486 ',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 11,
                      left: 70,
                      child: Text(
                        '2972 Westheimer Rd. Santa Ana,\nIllinois 85486 ',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Current Date',
                      style: TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat-Regular',
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.215,
                      child: const Text(
                        '22 Jun , 2023',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Vehicle',
                      style: TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat-Regular',
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.215,
                      child: const Text(
                        'Sedan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Fare',
                      style: TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat-Regular',
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.215,
                      child: Text(
                        '500 SAR ',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat-Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: dialogButton('Completed', context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
