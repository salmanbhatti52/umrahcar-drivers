// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/button.dart';
import 'package:umrahcar_driver/widgets/navbar.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController contactNumberController = TextEditingController();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  DateTime? currentBackPressTime;

  Future<bool> onExitApp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tap again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF000000).withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onExitApp,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: mainColor,
          //   elevation: 0,
          // ),
          backgroundColor: mainColor,
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SvgPicture.asset('assets/images/umrah-car-logo-big.svg'),
                  SizedBox(height: size.height * 0.04),
                  const Text(
                    'Login to Your Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFF000000).withOpacity(0.15),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final code = await countryPicker.showPicker(
                                  context: context);
                              setState(() {
                                countryCode = code;
                              });
                              print('countryCode: $countryCode');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                countryCode?.dialCode ?? "+966",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 14,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            '|',
                            style: TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 20,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 240,
                            child: TextFormField(
                              controller: contactNumberController,
                              keyboardType: TextInputType.number,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Contact Number field is required!';
                              //   }
                              //   return null;
                              // },
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 16,
                                color: Color(0xFF6B7280),
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 2,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                ),
                                hintText: "Contact Number",
                                hintStyle: const TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 12,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                                prefixIcon: SvgPicture.asset(
                                  'assets/images/contact-icon.svg',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavBar(),
                          ));
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomePage()),
                      //     (Route<dynamic> route) => false);
                    },
                    child: button('Login', context),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
