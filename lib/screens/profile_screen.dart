import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:umrahcar_driver/screens/edit_profile_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/get_all_system_data_model.dart';
import '../models/get_driver_profile.dart';
import '../models/update_driver_location_model.dart';
import '../service/rest_api_service.dart';
import '../utils/const.dart';
import '../widgets/button.dart';
import 'homepage_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetDriverProfile getDriverProfile = GetDriverProfile();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  bool _obscure = true;
  bool _obscure1 = true;
  bool _obscure2 = true;

  getProfile() async {
    if (mounted) {
      getDriverProfile = await DioClient().getProfile(userId, context);
      print("name: ${getDriverProfile.data!.userData!.name}");

      setState(() {});
    }
  }

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
          setState(() {
            //refresh the UI
          });
          getLocation();
        }
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    if (mounted) {
      setState(() {
        //refresh the UI
      });
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude); //Output: 80.24599079
    // print(position.latitude);
    // print("hiiiiiiiiiii");//Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    if (mounted) {
      setState(() {
        //refresh UI
      });
      if (long.isNotEmpty && lat.isNotEmpty) {
        if (mounted) {
          updateDriverLocation();
        }
      }
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      // print(position.longitude); //Output: 80.24599079
      // print(position.latitude); //Output: 29.6593457
      // print("bye");//Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      if (mounted) {
        if (long.isNotEmpty && lat.isNotEmpty) {
          if (mounted) {
            updateDriverLocation();
          }
        }
        setState(() {});
      }
    });
  }

  UpdateDriverLocationModel updateDriverLocationModel =
      UpdateDriverLocationModel();
  updateDriverLocation() async {
    // print(lat);
    // print(long);
    // print(userId);
    // print("done");
    var jsonData = {
      "users_drivers_id": userId.toString(),
      "longitude": long,
      "lattitude": lat
    };

    updateDriverLocationModel =
        await DioClient().updateDriverLocation(jsonData, context);
    print("message of location: ${updateDriverLocationModel.message}");
  }

  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    if (mounted) {
      getAllSystemData = await DioClient().getSystemAllData(context);
      // print("GETSystemAllData: ${getAllSystemData.data}");
      setState(() {
        getSettingsData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;
  getSettingsData() {
    for (int i = 0; i < getAllSystemData.data!.settings!.length; i++) {
      pickSettingsData.add(getAllSystemData.data!.settings![i]);
      // print("Setting time= $pickSettingsData");
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

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getProfile();
    getSystemAllData();
    // TODO: implement initState
    super.initState();
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
            SystemNavigator.pop(); // Closes the app on Android
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
            'Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: getDriverProfile.data != null
            ? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getDriverProfile.data!.userData!.image != null
                            ? Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("$imageUrl${getDriverProfile.data!.userData!.image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/profile.png'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                                  );
                                },
                                child: Text(
                                  '${getDriverProfile.data!.userData!.name}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total Earning',
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ConstantColor.darkgreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: size.height * 0.002),
                            Text(
                              '${getDriverProfile.data!.userData!.walletAmount}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.name,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/name-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'Name',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.companyName,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/business-name-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'Company Name',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.email,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/email-icon.svg',
                      width: 20,
                      height: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'Email',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.city,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/city-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'City',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.contact,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/contact-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'Contact',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  readOnly: true,
                  initialValue: getDriverProfile.data!.userData!.whatsapp,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      'assets/images/whatsapp-icon.svg',
                      width: 25,
                      height: 25,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    labelText: 'WhatsApp',
                    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => changePassword(),
                  );
                },
                child: Container(
                  width: 256,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 370),
            Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }

  Widget changePassword() {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: size.height * 0.62,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Form(
                  key: changePasswordFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Change Password',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: currentPasswordController,
                          obscureText: _obscure,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Current Password field is required!';
                            } else if (value.length < 6) {
                              return "Password must be 6 Digits";
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            hintText: "Current Password",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/password-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscure = !_obscure),
                              child: _obscure
                                  ? SvgPicture.asset('assets/images/hide-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface)
                                  : SvgPicture.asset('assets/images/show-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: newPasswordController,
                          obscureText: _obscure1,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'New Password field is required!';
                            } else if (value.length < 6) {
                              return "Password must be 6 Digits";
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            hintText: "New Password",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/password-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscure1 = !_obscure1),
                              child: _obscure1
                                  ? SvgPicture.asset('assets/images/hide-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface)
                                  : SvgPicture.asset('assets/images/show-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: _obscure2,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password field is required!';
                            } else if (value.length < 6) {
                              return "Password must be 6 Digits";
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            hintText: "Confirm Password",
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.greyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/password-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => _obscure2 = !_obscure2),
                              child: _obscure2
                                  ? SvgPicture.asset('assets/images/hide-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface)
                                  : SvgPicture.asset('assets/images/show-password-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      GestureDetector(
                        onTap: () async {
                          if (changePasswordFormKey.currentState!.validate()) {
                            var mapData = {
                              "users_drivers_id": "$userId",
                              "old_password": currentPasswordController.text,
                              "new_password": newPasswordController.text,
                              "confirm_password": " ${confirmPasswordController.text}"
                            };
                            var response = await DioClient().changeUserPassword(mapData, context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("${response.message}", style: Theme.of(context).textTheme.bodyMedium)));
                            Navigator.pop(context);
                            currentPasswordController.clear();
                            newPasswordController.clear();
                            confirmPasswordController.clear();
                            _obscure = _obscure1 = _obscure2 = true;
                            setState(() {});
                          }
                        },
                        child: dialogButton('Update', context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
