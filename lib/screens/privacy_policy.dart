import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Privacy Policy',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'At UmrahCar, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use our transportation services.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '1. Information We Collect:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Personal details such as name, contact number, and email address provided during booking.\n'
                    '- Payment information required to process transactions securely.\n'
                    '- Location data and travel details to facilitate seamless transportation services.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '2. How We Use Your Information:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- To confirm bookings and provide updates about your trip.\n'
                    '- To improve our services by analyzing travel preferences and feedback.\n'
                    '- To comply with legal and regulatory requirements.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '3. Data Security:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We use advanced security measures to protect your data from unauthorized access, alteration, or disclosure. Payment information is encrypted and processed through secure gateways.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '4. Third-Party Sharing:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We do not share your personal information with third parties unless necessary for service delivery (e.g., payment processing) or as required by law.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '5. Your Rights:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You have the right to access, update, or request deletion of your personal data. Contact us for assistance with privacy-related concerns.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'By using UmrahCar, you consent to this Privacy Policy. We are committed to ensuring your data is handled with the utmost care and respect.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}