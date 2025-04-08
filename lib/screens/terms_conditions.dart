import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
          'Terms Conditions',
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
                'Welcome to UmrahCar! By using our transportation services, you agree to the following terms and conditions.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '1. Booking and Confirmation:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All bookings must be made through our official website, app, or authorized representatives. A booking is confirmed upon receiving a confirmation email or message.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '2. Payment Policy:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Payments must be made as per the agreed terms during booking. We accept various payment methods, and all transactions are subject to our payment gateway policies.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '3. Cancellations and Refunds:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Cancellations must be made at least 36 hours before the scheduled journey for a full or partial refund, depending on our cancellation policy. Late cancellations or no-shows may result in a charge.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '4. Travel Conditions:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Passengers are required to arrive at the pickup location on time. UmrahCar reserves the right to adjust schedules due to unforeseen circumstances like traffic or weather.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '5. Liability:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'UmrahCar ensures the safety and comfort of passengers but is not liable for delays, accidents, or damages caused by factors beyond our control.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '6. Code of Conduct:',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Passengers must respect drivers, vehicles, and fellow travelers. Any misconduct may result in termination of service without a refund.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'By using UmrahCar, you acknowledge and accept these terms. We strive to provide a safe and pleasant travel experience for all.',
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