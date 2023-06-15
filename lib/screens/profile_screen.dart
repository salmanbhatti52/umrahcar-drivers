import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            'Profile',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(width: size.width * 0.03),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: Container(
                            color: Colors.transparent,
                            width: size.width * 0.4,
                            child: const AutoSizeText(
                              'Mohammad Irfan',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                              ),
                              minFontSize: 16,
                              maxFontSize: 16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        width: size.width * 0.24,
                        height: size.height * 0.065,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFF000000).withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Earning',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF565656),
                                fontSize: 8,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.002),
                            const Text(
                              '600 SAR',
                              style: TextStyle(
                                color: Color(0xFF79BF42),
                                fontSize: 12,
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/name-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      'Mohammad Irfan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/business-name-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      'Business Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/email-icon.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      'Mohammad1234@gmail.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/city-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      'Lahore',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/contact-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      '+9660359875631',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/whatsapp-icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Text(
                      '+9660359875631',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
