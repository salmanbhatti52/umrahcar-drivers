// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
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
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  File? imagePath;
  String? base64img;
  Future pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: source);
      if (xFile == null) {
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        // const NavBar()), (Route<dynamic> route) => false);
      } else {
        Uint8List imageByte = await xFile.readAsBytes();
        base64img = base64.encode(imageByte);
        print("base64img $base64img");

        final imageTemporary = File(xFile.path);

        setState(() {
          imagePath = imageTemporary;
          print("newImage $imagePath");
          print("newImage64 $base64img");
          if(imagePath !=null){
            Navigator.pop(context);
            setState(() {

            });
          }
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => SaveImageScreen(
          //           image: imagePath,
          //           image64: "$base64img",
          //         )));
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }

  GetDriverProfile getProfileResponse=GetDriverProfile();
  getProfile()async{
    print("userIdId ${userId}");

    getProfileResponse= await DioClient().getProfile(userId, context);
    if(getProfileResponse.data !=null ) {
      print("getProfileResponse name: ${getProfileResponse.data!.userData!.name}");
      nameController.text=getProfileResponse.data!.userData!.name!;
      emailController.text=getProfileResponse.data!.userData!.email!;
      cityController.text=getProfileResponse.data!.userData!.city!;
      contactNumberController.text=getProfileResponse.data!.userData!.contact!;
      whatsappNumberController.text=getProfileResponse.data!.userData!.whatsapp!;
      businessNameController.text= getProfileResponse.data!.userData!.companyName!;
    }
    setState(() {

    });
  }

  @override
  void initState() {
    getProfile();
    // TODO: implement initState
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
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/images/back-icon.svg',
              width: 22,
              height: 22,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: getProfileResponse.data !=null ?
        SingleChildScrollView(
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
                                height:70,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: imagePath != null
                                    ? Image.file(
                                        imagePath!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        '$imageUrl${getProfileResponse.data!.userData!.image}',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: size.height * 0.2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  pickImage(ImageSource.camera);
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/camera-icon.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    SizedBox(
                                                        width: size.width * 0.04),
                                                    const Text(
                                                      'Take a picture',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat-Regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  height: size.height * 0.04),
                                              GestureDetector(
                                                onTap: () {
                                                  pickImage(ImageSource.gallery);
                                                },
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/gallery-icon.svg',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    SizedBox(
                                                        width: size.width * 0.04),
                                                    const Text(
                                                      'Choose a picture',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat-Regular',
                                                        fontWeight:
                                                            FontWeight.w400,
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
                          const Text(
                            'Welcome,',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF565656),
                              fontSize: 16,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.003),
                           if(getProfileResponse !=null)
                           Text(
                            '${getProfileResponse.data!.userData!.name!}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Montserrat-Regular',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name field is required!';
                      }
                      return null;
                    },
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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      hintText: "Concern Person Name",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/name-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: businessNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Business Name field is required!';
                      }
                      return null;
                    },
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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      hintText: "Business Name",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/business-name-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
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
                      bool emailValid = RegExp(
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Email field is required!";
                      } else if (!emailValid) {
                        return "Email field is not valid!";
                      } else {
                        return null;
                      }
                    },

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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      hintText: "Email",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/email-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City Name field is required!';
                      }
                      return null;
                    },
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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      hintText: "City Name",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/city-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
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
                      children: [
                        SizedBox(
                          width: 240,
                          child: TextFormField(
                            controller: contactNumberController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Contact Number field is required!';
                              }
                              return null;
                            },
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
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: whatsappNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Whatsapp Number field is required!';
                      }
                      return null;
                    },
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
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      hintText: "Whatsapp Number",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/whatsapp-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        print("userid: $userId");
                        print("name: ${nameController.text}");
                        print("email: ${emailController.text}");
                        print("business: ${businessNameController.text}");
                        print("email: ${emailController.text}");
                        print("city: ${cityController.text}");
                        print("contact: ${contactNumberController.text}");
                        print("whatsapp: ${whatsappNumberController.text}");
                        print("password: ${getProfileResponse !=null ? "${getProfileResponse.data!.userData!.password}":"123456"}");

                        var mapData={
                          "users_drivers_id":"$userId",
                          "name":nameController.text,
                          "email": emailController.text,
                          "password": getProfileResponse !=null ? "${getProfileResponse.data!.userData!.password}":"123456",
                          "city": cityController.text,
                          "contact":contactNumberController.text,
                          "whatsapp":whatsappNumberController.text,
                          "notification_switch":getProfileResponse !=null ? "${getProfileResponse.data!.userData!.notificationSwitch!}":"1234567890",
                          "image" : base64img,

                        };
                        print("mapData: ${mapData}");
                        var response = await DioClient().updateProfile(
                            mapData,context
                        );
                        if(response !=null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated Successfully")));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  NavBar(indexNmbr: 2),
                              ));
                          setState(() {

                          });
                        }



                      }

                    },
                    child: button('Update', context)),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ):const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 170),
              child: CircularProgressIndicator(),
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