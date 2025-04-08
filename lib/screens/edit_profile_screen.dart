import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umrahcar_driver/models/get_driver_profile.dart';
import 'package:umrahcar_driver/utils/const.dart';

import '../service/rest_api_service.dart';
import '../utils/colors.dart';
import '../widgets/button.dart';
import '../widgets/navbar.dart';
import 'homepage_screen.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final countryPicker = const FlCountryCodePicker();
  // CountryCode? countryCode;

  File? imagePath;
  String? base64img;
  Future pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: source);
      if (xFile != null) {
        Uint8List imageByte = await xFile.readAsBytes();
        base64img = base64.encode(imageByte);
        final imageTemporary = File(xFile.path);
        setState(() {
          imagePath = imageTemporary;
          Navigator.pop(context);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  GetDriverProfile getProfileResponse = GetDriverProfile();
  getProfile() async {
    getProfileResponse = await DioClient().getProfile(userId, context);
    if (getProfileResponse.data != null) {
      nameController.text = getProfileResponse.data!.userData!.name!;
      emailController.text = getProfileResponse.data!.userData!.email!;
      cityController.text = getProfileResponse.data!.userData!.city!;
      contactNumberController.text = getProfileResponse.data!.userData!.contact!;
      whatsappNumberController.text = getProfileResponse.data!.userData!.whatsapp!;
      businessNameController.text = getProfileResponse.data!.userData!.companyName!;
    }
    setState(() {});
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/images/back-icon.svg',
              width: 22,
              height: 22,
              fit: BoxFit.scaleDown,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: getProfileResponse.data != null
            ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60, left: 20),
                      child: SizedBox(
                        width: 80,
                        height: 70,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                ),
                                child: imagePath != null
                                    ? Image.file(imagePath!, fit: BoxFit.cover)
                                    : Image.network('$imageUrl${getProfileResponse.data!.userData!.image}', fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Theme.of(context).colorScheme.surface,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: size.height * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () => pickImage(ImageSource.camera),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/camera-icon.svg',
                                                      width: 30,
                                                      height: 30,
                                                      color: Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                    SizedBox(width: size.width * 0.04),
                                                    Text(
                                                      'Take a picture',
                                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: size.height * 0.04),
                                              GestureDetector(
                                                onTap: () => pickImage(ImageSource.gallery),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/gallery-icon.svg',
                                                      width: 30,
                                                      height: 30,
                                                      color: Theme.of(context).colorScheme.onSurface,
                                                    ),
                                                    SizedBox(width: size.width * 0.04),
                                                    Text(
                                                      'Choose a picture',
                                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: primaryColor,
                                  child: SvgPicture.asset(
                                    'assets/images/white-camera-icon.svg',
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome,',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ConstantColor.darkgreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.003),
                          if (getProfileResponse.data != null)
                            Text(
                              '${getProfileResponse.data!.userData!.name!}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty ? 'Name field is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
                      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Concern Person Name",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                      prefixIcon: SvgPicture.asset('assets/images/name-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: businessNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty ? 'Business Name field is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
                      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Business Name",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                      prefixIcon: SvgPicture.asset('assets/images/business-name-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value!);
                      if (value.isEmpty) return "Email field is required!";
                      if (!emailValid) return "Email field is not valid!";
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
                      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Email",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                      prefixIcon: SvgPicture.asset('assets/images/email-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty ? 'City Name field is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
                      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "City Name",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                      prefixIcon: SvgPicture.asset('assets/images/city-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 240,
                          child: TextFormField(
                            controller: contactNumberController,
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty ? 'Contact Number field is required!' : null,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              filled: false,
                              errorStyle: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                              hintText: "Contact Number",
                              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                              prefixIcon: SvgPicture.asset('assets/images/contact-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: whatsappNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Whatsapp Number field is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
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
                      errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: Colors.red)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Whatsapp Number",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ConstantColor.greyColor, fontSize: 12, fontWeight: FontWeight.w500),
                      prefixIcon: SvgPicture.asset('assets/images/whatsapp-icon.svg', width: 25, height: 25, fit: BoxFit.scaleDown, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var mapData = {
                        "users_drivers_id": "$userId",
                        "name": nameController.text,
                        "email": emailController.text,
                        "password": getProfileResponse.data != null ? "${getProfileResponse.data!.userData!.password}" : "123456",
                        "city": cityController.text,
                        "contact": contactNumberController.text,
                        "whatsapp": whatsappNumberController.text,
                        "notification_switch": getProfileResponse.data != null ? "${getProfileResponse.data!.userData!.notificationSwitch!}" : "1234567890",
                        "image": base64img,
                      };
                      var response = await DioClient().updateProfile(mapData, context);
                      if (response != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Profile Updated Successfully", style: Theme.of(context).textTheme.bodyMedium)));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar(indexNmbr: 2)));
                        setState(() {});
                      }
                    }
                  },
                  child: button('Update', context),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 170),
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}


// SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     height: size.height * 0.062,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 1,
              //         color: const Color(0xFF000000).withOpacity(0.15),
              //       ),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 20),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset('assets/images/city-icon.svg'),
              //           const Padding(
              //             padding: EdgeInsets.only(left: 15),
              //             child: Text(
              //               'City Name',
              //               style: TextStyle(
              //                 color: Color(0xFF929292),
              //                 fontSize: 12,
              //                 fontFamily: 'Montserrat-Regular',
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 165),
              //             child: SvgPicture.asset(
              //                 'assets/images/dropdown-icon.svg'),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),