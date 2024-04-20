import 'dart:convert';
import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/add_card_model.dart';
import '../../../utils/colors.dart';
import '../../../widgets/button.dart';
import '../service/rest_api_service.dart';
import '../widgets/navbar.dart';
import 'homepage_screen.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController landLineNumberController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  // TextEditingController iataNumberController = TextEditingController();
  // TextEditingController localgovtNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  CountryCode? countryCode1;
  // String? pickCountry;
  // String? pickState;

  bool _obscure = true;
  bool _obscure1 = true;


  List<String> driverTypeList=[
    "Credit (Out)",
    // "Debit (In)"
  ];
  String? selectedCompany;



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
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
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
        body: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.09),
                const Text(
                  'Add Debit / Credit Transactions ',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 100,
                        height:100,
                        decoration: const BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        child: imagePath != null
                            ? Image.file(
                          imagePath!,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          'assets/images/place.png',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: -45,
                      left: 9,
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
                SizedBox(height: size.height * 0.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: 55,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          isDense: true,

                          icon: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: SvgPicture.asset(
                              'assets/images/dropdown-icon.svg',
                              width: 20,
                              height: 20,

                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000)
                                    .withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000)
                                    .withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(16)),
                              borderSide: BorderSide(
                                color: const Color(0xFF000000)
                                    .withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            // prefixIcon: SvgPicture.asset(
                            //   'assets/images/service-icon.svg',
                            //   width: 10,
                            //   height: 8,
                            //   fit: BoxFit.scaleDown,
                            // ),
                            hintText: 'Transaction Type',
                            contentPadding: EdgeInsets.only(left: 35),
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 10,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          items: driverTypeList!
                              .map(
                                (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 10,
                                  fontFamily: 'Montserrat-Regular',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                              .toList(),
                          value: selectedCompany,
                          onChanged: (value) {
                            setState(() {
                              selectedCompany = value;
                              print("Selected Company: ${selectedCompany}");
                              setState(() {

                              });
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Amount is required!';
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
                          horizontal: 50, vertical: 10),
                      hintText: "Amount",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      // prefixIcon: SvgPicture.asset(
                      //   'assets/images/name-icon.svg',
                      //   width: 25,
                      //   height: 25,
                      //   fit: BoxFit.scaleDown,
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description  is required!';
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
                          horizontal: 50, vertical: 10),
                      hintText: "Description",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      // prefixIcon: SvgPicture.asset(
                      //   'assets/images/business-name-icon.svg',
                      //   width: 25,
                      //   height: 25,
                      //   fit: BoxFit.scaleDown,
                      // ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),
                GestureDetector(
                    onTap: () async {
                      if(signUpFormKey.currentState!.validate()  && selectedCompany !=null && base64img !=null){

                        var jsonData= {
                          "users_drivers_id":userId.toString(),
                          "accounts_heads_id":"1",
                          "txn_type":selectedCompany,
                          "amount": amountController.text,
                          "description":descriptionController.text,
                          "image": base64img
                        };
                        print("data: ${jsonData}");
                        AddCardModel res= await DioClient().addCard(jsonData, context);
                        print("response: ${res.message}");

                        if(res !=null){
                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${res.message}")));

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => NavBar(indexNmbr: 3,walletPage: 2,)),
                                  (Route<dynamic> route) => false);
                          setState(() {

                          });
                        }



                      }
                      else if(selectedCompany ==null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                "Please Select Payment Type")));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Select Image")));

                      }


                    },
                    child: button('Submit', context)),
                SizedBox(height: size.height * 0.03),


              ],
            ),
          ),
        ),
      ),
    );
  }
}