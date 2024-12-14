import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontFamily: 'Montserrat-Regular',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'At UmrahCar, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our transportation services.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Information We Collect :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Personal details such as name, contact number, and email address provided during booking.\n'
                    '- Payment information required to process transactions securely.\n'
                    '- Location data and travel details to facilitate seamless transportation services.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. How We Use Your Information:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- To confirm bookings and provide updates about your trip.\n'
                    '- To improve our services by analyzing travel preferences and feedback.\n'
                    '- To comply with legal and regulatory requirements.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Data Security:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We use advanced security measures to protect your data from unauthorized access, alteration, or disclosure. Payment information is encrypted and processed through secure gateways.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4. Third-Party Sharing:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We do not share your personal information with third parties unless necessary for service delivery (e.g., payment processing) or as required by law.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '5. Your Rights:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You have the right to access, update, or request deletion of your personal data. Contact us for assistance with privacy-related concerns.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'By using UmrahCar, you consent to this Privacy Policy. We are committed to ensuring your data is handled with the utmost care and respect.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}