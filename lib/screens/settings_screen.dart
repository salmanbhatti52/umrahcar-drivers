import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar_driver/main.dart';
import 'package:umrahcar_driver/screens/about_us.dart';
import 'package:umrahcar_driver/screens/privacy_policy.dart';
import 'package:umrahcar_driver/screens/terms_conditions.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/get_all_system_data_model.dart';
import '../models/update_driver_location_model.dart';
import '../service/rest_api_service.dart';
import 'homepage_screen.dart';
import 'login_screen.dart';

class SetttingsPage extends StatefulWidget {
  const SetttingsPage({super.key});

  @override
  State<SetttingsPage> createState() => _SetttingsPageState();
}

class _SetttingsPageState extends State<SetttingsPage> {
  bool status = false;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  Timer? timer;

  late StreamSubscription<Position> positionStream;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        if (mounted) {
          setState(() {});
          getLocation();
        }
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    if (mounted) {
      setState(() {});
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();

    if (mounted) {
      if (long.isNotEmpty && lat.isNotEmpty) {
        updateDriverLocation();
      }
      setState(() {});
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      if (mounted) {
        if (long.isNotEmpty && lat.isNotEmpty) {
          updateDriverLocation();
        }
        setState(() {});
      }
    });
  }

  UpdateDriverLocationModel updateDriverLocationModel = UpdateDriverLocationModel();
  updateDriverLocation() async {
    var jsonData = {
      "users_drivers_id": "${userId.toString()}",
      "longitude": long,
      "lattitude": lat
    };

    updateDriverLocationModel = await DioClient().updateDriverLocation(jsonData, context);
    print("message of location: ${updateDriverLocationModel.message}");
  }

  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    if (mounted) {
      getAllSystemData = await DioClient().getSystemAllData(context);
      setState(() {
        getSettingsData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;
  getSettingsData() {
    if (getAllSystemData.data != null) {
      for (int i = 0; i < getAllSystemData.data!.settings!.length; i++) {
        pickSettingsData.add(getAllSystemData.data!.settings![i]);
      }

      for (int i = 0; i < pickSettingsData.length; i++) {
        if (pickSettingsData[i].type == "map_refresh_time") {
          timerCount = int.parse(pickSettingsData[i].description!);
          print("timer refresh: $timerCount");
          if (mounted) {
            checkGps();
            timer = Timer.periodic(
                Duration(minutes: timerCount), (timer) => checkGps());
            setState(() {});
          }
        }
      }
    }
  }

  final String phoneNumber = '966567799616';

  Future<void> _openWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open WhatsApp.';
    }
  }

  @override
  void initState() {
    getSystemAllData();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text('Active Tracking'),
              content: const Text(
                'Closing the app will stop location updates. '
                    'This may affect your active bookings.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            Navigator.of(context).pop(result);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.02),
                Text(
                  'Notifications',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/notification-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: size.width * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Push Notifications',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.002),
                        Text(
                          'Turn on Push Notifications',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      width: 45,
                      height: 25,
                      activeColor: ConstantColor.primaryColor,
                      inactiveColor: ConstantColor.darkgreyColor.withOpacity(0.2),
                      activeToggleColor: Colors.white,
                      inactiveToggleColor: ConstantColor.darkgreyColor,
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
                Row(
                  children: [
                    Icon(
                      Provider.of<ThemeProvider>(context).isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      size: 25,
                    ),
                    SizedBox(width: size.width * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.002),
                        Text(
                          Provider.of<ThemeProvider>(context).isDarkMode
                              ? 'Switch to Light Mode'
                              : 'Switch to Dark Mode',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: ConstantColor.darkgreyColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FlutterSwitch(
                      width: 45,
                      height: 25,
                      activeColor: ConstantColor.primaryColor,
                      inactiveColor: ConstantColor.darkgreyColor.withOpacity(0.2),
                      activeToggleColor: Colors.white,
                      inactiveToggleColor: ConstantColor.darkgreyColor,
                      toggleSize: 25,
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      borderRadius: 50,
                      padding: 2,
                      onToggle: (val) {
                        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Divider(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/about-us-icon.svg',
                          width: 24,
                          height: 24,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Text(
                            'About Us',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg',
                            width: 20,
                            height: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: _openWhatsApp,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/whatsapp-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Text(
                            'Contact Us',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg',
                            width: 20,
                            height: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TermsConditions()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/terms-icon.svg',
                          width: 24,
                          height: 24,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Text(
                            'Terms And Conditions',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg',
                            width: 20,
                            height: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/privacy-icon.svg',
                          width: 24,
                          height: 24,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Text(
                            'Privacy Policy',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/images/left-arrow-icon.svg',
                            width: 20,
                            height: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LogInPage()),
                      );
                    },
                    child: Container(
                      width: 256,
                      height: 48,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}