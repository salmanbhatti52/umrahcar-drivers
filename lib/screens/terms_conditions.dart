import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
          'Terms Conditions',
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
                'Welcome to UmrahCar! By using our transportation services, you agree to the following terms and conditions.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Booking and Confirmation:',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All bookings must be made through our official website, app, or authorized representatives. A booking is confirmed upon receiving a confirmation email or message.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. Payment Policy :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Payments must be made as per the agreed terms during booking. We accept various payment methods, and all transactions are subject to our payment gateway policies.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Cancellations and Refunds :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Cancellations must be made at least 36 hours before the scheduled journey for a full or partial refund, depending on our cancellation policy. Late cancellations or no-shows may result in a charge.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4. Travel Conditions :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Passengers are required to arrive at the pickup location on time. UmrahCar reserves the right to adjust schedules due to unforeseen circumstances like traffic or weather.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '5. Liability :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'UmrahCar ensures the safety and comfort of passengers but is not liable for delays, accidents, or damages caused by factors beyond our control.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '6. Code of Conduct :',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Passengers must respect drivers, vehicles, and fellow travelers. Any misconduct may result in termination of service without a refund.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'By using UmrahCar, you acknowledge and accept these terms. We strive to provide a safe and pleasant travel experience for all.',
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