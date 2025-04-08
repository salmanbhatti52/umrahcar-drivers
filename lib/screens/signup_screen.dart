import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umrahcar_driver/models/sign_up_model.dart';
import 'package:umrahcar_driver/service/rest_api_service.dart';
import '../utils/colors.dart';
import '../widgets/button.dart';
import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController whatsappNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Country code picker
  CountryCode? countryCode;
  CountryCode? countryCode1;

  // State variables
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  File? imagePath;
  String? base64img;

  // Dropdown options
  final List<String> driverTypeList = ["Company", "Individual"];
  String? selectedCompany;

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: source);
      if (xFile == null) return;

      final imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      debugPrint("base64img $base64img");

      final imageTemporary = File(xFile.path);

      if (!mounted) return;
      setState(() {
        imagePath = imageTemporary;
        if (imagePath != null) {
          Navigator.pop(context);
        }
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> _showImageSourceBottomSheet(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
                        style: Theme.of(context).textTheme.bodyMedium,
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
                        style: Theme.of(context).textTheme.bodyMedium,
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
  }

  Future<void> _submitForm() async {
    if (!signUpFormKey.currentState!.validate()) return;
    if (selectedCompany == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select Driver Type")),
      );
      return;
    }
    if (countryCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select Country Code")),
      );
      return;
    }
    if (countryCode1 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select WhatsApp Country Code")),
      );
      return;
    }
    if (base64img == null) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Please Select Image")),
      );
      return;
    }

    final jsonData = {
      "longitude": "",
      "lattitude": "",
      "drivers_type": selectedCompany,
      "company_name": businessNameController.text,
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "contact": "${countryCode!.dialCode}${contactNumberController.text}",
      "whatsapp": "${countryCode1!.dialCode}${whatsappNumberController.text}",
      "city": cityController.text,
      "notification_switch": "Yes",
      "image": base64img
    };

    debugPrint("data: $jsonData");
    final res = await DioClient().signUp(jsonData, context);
    debugPrint("response: ${res.message}");

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("Driver added successfully")),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LogInPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.04),
                SvgPicture.asset(
                  'assets/app-icon.svg',
                  height: 150,
                  width: 150,
                  // color: theme.colorScheme.onSurface,
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  'Sign Up to Your Account',
                  style: theme.textTheme.headlineSmall?.copyWith(
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
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: imagePath != null
                            ? Image.file(imagePath!, fit: BoxFit.cover)
                            : Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 4,
                      right: -45,
                      child: GestureDetector(
                        onTap: () => _showImageSourceBottomSheet(context),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: theme.primaryColor,
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
                _buildDriverTypeDropdown(size, theme),
                SizedBox(height: size.height * 0.02),
                _buildTextFormField(
                  controller: nameController,
                  hintText: "Concern Person Name",
                  prefixIcon: 'assets/images/name-icon.svg',
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'Name field is required!' : null,
                ),
                SizedBox(height: size.height * 0.02),
                _buildTextFormField(
                  controller: businessNameController,
                  hintText: "Company Name",
                  prefixIcon: 'assets/images/business-name-icon.svg',
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Company Name field is required!'
                      : null,
                ),
                SizedBox(height: size.height * 0.02),
                _buildTextFormField(
                  controller: cityController,
                  hintText: "City Name",
                  prefixIcon: 'assets/images/landline-icon.svg',
                  validator: (value) =>
                  value?.isEmpty ?? true ? 'City Name field is required!' : null,
                ),
                SizedBox(height: size.height * 0.02),
                _buildPhoneNumberField(
                  controller: contactNumberController,
                  hintText: "Contact Number",
                  countryCode: countryCode,
                  onCountryCodeChanged: (code) {
                    setState(() {
                      countryCode = code;
                    });
                  },
                  prefixIcon: 'assets/images/contact-icon.svg',
                ),
                SizedBox(height: size.height * 0.02),
                _buildPhoneNumberField(
                  controller: whatsappNumberController,
                  hintText: "Whatsapp Number",
                  countryCode: countryCode1,
                  onCountryCodeChanged: (code) {
                    setState(() {
                      countryCode1 = code;
                    });
                  },
                  prefixIcon: 'assets/images/whatsapp-icon.svg',
                ),
                SizedBox(height: size.height * 0.02),
                _buildTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: 'assets/images/email-icon.svg',
                  validator: (value) {
                    if (value?.isEmpty ?? true) return "Email field is required!";
                    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(value!)) {
                      return "Email field is not valid!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                _buildPasswordField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Password field is required!';
                    if (value!.length < 6) return "Password must be 6 Digits";
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                _buildPasswordField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: _obscureConfirmPassword,
                  onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Confirm Password field is required!';
                    if (value!.length < 6) return "Password must be 6 Digits";
                    if (value != passwordController.text) {
                      return "Confirm Password and Password are not same";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: _submitForm,
                  child: button('Signup', context),
                ),
                SizedBox(height: size.height * 0.03),
                _buildOrDivider(theme),
                SizedBox(height: size.height * 0.03),
                _buildLoginPrompt(theme),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDriverTypeDropdown(Size size, ThemeData theme) {
    return Padding(
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
                  color: theme.colorScheme.onSurface,
                ),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.onSurface.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 1,
                  ),
                ),
                prefixIcon: SvgPicture.asset(
                  'assets/images/service-icon.svg',
                  width: 10,
                  height: 8,
                  fit: BoxFit.scaleDown,
                  color: theme.colorScheme.onSurface,
                ),
                hintText: 'Driver Type',
                hintStyle: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              borderRadius: BorderRadius.circular(16),
              items: driverTypeList
                  .map(
                    (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              )
                  .toList(),
              value: selectedCompany,
              onChanged: (value) => setState(() => selectedCompany = value),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String prefixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surface,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.15),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10),
          hintText: hintText,
          hintStyle: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          prefixIcon: SvgPicture.asset(
            prefixIcon,
            width: 25,
            height: 25,
            fit: BoxFit.scaleDown,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField({
    required TextEditingController controller,
    required String hintText,
    required CountryCode? countryCode,
    required ValueChanged<CountryCode> onCountryCodeChanged,
    required String prefixIcon,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) =>
        value?.isEmpty ?? true ? '$hintText field is required!' : null,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surface.withOpacity(0.1),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.15),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
          hintStyle: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontSize: 16,
          ),
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountryCodePicker(
                onChanged: onCountryCodeChanged,
                initialSelection: 'NG',
                favorite: ['+234', 'NG'],
                textStyle: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 14,
                ),
                showFlag: true,
                showFlagDialog: true,
                dialogTextStyle: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
                dialogBackgroundColor: theme.scaffoldBackgroundColor,
                searchStyle: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
                padding: const EdgeInsets.only(left: 10),
              ),
              Text(
                '|',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  prefixIcon,
                  width: 25,
                  height: 25,
                  fit: BoxFit.scaleDown,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,
        validator: validator,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surface,
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.15),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10),
          hintText: hintText,
          hintStyle: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          prefixIcon: SvgPicture.asset(
            'assets/images/password-icon.svg',
            width: 25,
            height: 25,
            fit: BoxFit.scaleDown,
            color: theme.colorScheme.onSurface,
          ),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: SvgPicture.asset(
              obscureText
                  ? 'assets/images/hide-password-icon.svg'
                  : 'assets/images/show-password-icon.svg',
              width: 25,
              height: 25,
              fit: BoxFit.scaleDown,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
            thickness: 1,
            indent: 20,
            endIndent: 10,
          ),
        ),
        Text(
          'OR',
          style: theme.textTheme.bodyMedium,
        ),
        Expanded(
          child: Divider(
            color: theme.colorScheme.onSurface.withOpacity(0.3),
            thickness: 1,
            indent: 10,
            endIndent: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt(ThemeData theme) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: theme.textTheme.bodyMedium,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInPage(),
                  ),
                );
              },
            text: 'Login',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}