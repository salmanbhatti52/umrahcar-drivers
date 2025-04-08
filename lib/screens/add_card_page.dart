import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
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
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.09),
                Text(
                  'Add Debit / Credit Transactions',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: imagePath != null
                            ? Image.file(imagePath!, fit: BoxFit.cover)
                            : Image.asset('assets/images/place.png', fit: BoxFit.cover),
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
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            elevation: 10,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            builder: (context) {
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
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
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
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
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
                  child: DropdownButtonFormField<String>(
                    isDense: true,
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: SvgPicture.asset(
                        'assets/images/dropdown-icon.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    decoration: InputDecoration(
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
                      hintText: 'Transaction Type',
                      contentPadding: const EdgeInsets.only(left: 35),
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.greyColor,
                        fontSize: 10,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: driverTypeList.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ConstantColor.greyColor,
                          fontSize: 10,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                    value: selectedCompany,
                    onChanged: (value) {
                      setState(() {
                        selectedCompany = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty ? 'Amount is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    decoration: InputDecoration(
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      hintText: "Amount",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.greyColor,
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty ? 'Description is required!' : null,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    decoration: InputDecoration(
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      hintText: "Description",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ConstantColor.greyColor,
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () async {
                    if (signUpFormKey.currentState!.validate() && selectedCompany != null && base64img != null) {
                      var jsonData = {
                        "users_drivers_id": userId.toString(),
                        "accounts_heads_id": "1",
                        "txn_type": selectedCompany,
                        "amount": amountController.text,
                        "description": descriptionController.text,
                        "image": base64img,
                      };
                      AddCardModel res = await DioClient().addCard(jsonData, context);
                      if (res != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("${res.message}", style: Theme.of(context).textTheme.bodyMedium)),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => NavBar(indexNmbr: 3, walletPage: 2)),
                              (Route<dynamic> route) => false,
                        );
                      }
                    } else if (selectedCompany == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select Payment Type", style: Theme.of(context).textTheme.bodyMedium)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select Image", style: Theme.of(context).textTheme.bodyMedium)),
                      );
                    }
                  },
                  child: button('Submit', context),
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