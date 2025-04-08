import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../service/rest_api_service.dart';
import '../utils/colors.dart';
import '../widgets/button.dart';
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? uid, verifyOTP;
  const ResetPasswordPage({super.key, this.uid, this.verifyOTP});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();

  bool _obscure = true;
  bool _obscure1 = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: createNewPasswordFormKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                  'assets/images/new-umrah-car-logo-big.svg',
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(height: size.height * 0.02),
                Center(
                  child: Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Center(
                  child: Text(
                    'Please enter a new password below\ndifferent from the last password',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ConstantColor.darkgreyColor, // 0xFF6B7280
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _obscure,
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
                      fontWeight: FontWeight.w400,
                      color: ConstantColor.darkgreyColor,
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
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/password-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscure = !_obscure;
                          });
                        },
                        child: SvgPicture.asset(
                          _obscure
                              ? 'assets/images/hide-password-icon.svg'
                              : 'assets/images/show-password-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscure1,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password field is required!';
                      } else if (value.length < 6) {
                        return "Confirm Password must be 6 Digits";
                      } else if (value != passwordController.text) {
                        return "Confirm Password is not matching with Password";
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ConstantColor.darkgreyColor,
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
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.15),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "Reconfirm Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/images/password-icon.svg',
                        width: 25,
                        height: 25,
                        fit: BoxFit.scaleDown,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscure1 = !_obscure1;
                          });
                        },
                        child: SvgPicture.asset(
                          _obscure1
                              ? 'assets/images/hide-password-icon.svg'
                              : 'assets/images/show-password-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                GestureDetector(
                  onTap: () async {
                    if (createNewPasswordFormKey.currentState!.validate()) {
                      print("users_drivers_id: ${widget.uid}");
                      print("otp: ${widget.verifyOTP}");
                      print("new_password: ${passwordController.text}");
                      print("confirm_password: ${confirmPasswordController.text}");
                      var mapData = {
                        "users_drivers_id": "${widget.uid}",
                        "otp": "${widget.verifyOTP}",
                        "new_password": passwordController.text,
                        "confirm_password": confirmPasswordController.text
                      };
                      var response = await DioClient().resetNewPassword(mapData, context);
                      print("response otp: ${response.message}");
                      if (response != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(backgroundColor: Theme.of(context).colorScheme.primary,content: Text("${response.message}")));
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LogInPage()),
                              (Route<dynamic> route) => false,
                        );
                      }
                    }
                  },
                  child: button('Confirm', context),
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