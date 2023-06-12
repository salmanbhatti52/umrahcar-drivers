import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SetttingsPage extends StatefulWidget {
  const SetttingsPage({super.key});

  @override
  State<SetttingsPage> createState() => _SetttingsPageState();
}

class _SetttingsPageState extends State<SetttingsPage> {
  bool status = false;

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
            'Settings',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.08),
                const Text(
                  'Notifications',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/notification-icon.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: size.width * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Push Notifications',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.002),
                        const Text(
                          'Turn on Push Notifications',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.21),
                    FlutterSwitch(
                      width: 45,
                      height: 25,
                      activeColor: const Color(0xFF79BF42),
                      inactiveColor: const Color(0xFF565656).withOpacity(0.2),
                      activeToggleColor: Colors.white,
                      inactiveToggleColor: const Color(0xFF565656),
                      toggleSize: 25,
                      value: status,
                      borderRadius: 50,
                      padding: 2,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Divider(
                  color: const Color(0xFF929292).withOpacity(0.3),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/account-icon.svg',
                    ),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      'Account Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/images/left-arrow-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/about-us-icon.svg',
                    ),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/images/left-arrow-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/contact-us-icon.svg',
                    ),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/images/left-arrow-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/terms-icon.svg',
                    ),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      'Terms And Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/images/left-arrow-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/privacy-icon.svg',
                    ),
                    SizedBox(width: size.width * 0.05),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/images/left-arrow-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
