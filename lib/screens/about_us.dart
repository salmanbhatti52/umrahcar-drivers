import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/const.dart'; // For mainColor if needed

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamic background
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Matches scaffold
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.onSurface, // Black or white based on theme
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ), // Uses theme text style
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
                'Welcome to UmrahCar, your trusted partner in reliable and comfortable transportation services in Saudi Arabia. We specialize in providing seamless travel experiences for pilgrims and visitors traveling between Makkah, Madinah, and Jeddah.',
                style: Theme.of(context).textTheme.bodyMedium, // Dynamic text color
              ),
              SizedBox(height: 16),
              Text(
                'At UmrahCar, we understand the importance of a smooth journey, especially during sacred travels like Umrah. Our commitment is to deliver exceptional service with a focus on convenience, punctuality, and comfort. Whether you need transportation from Jeddah to Makkah, Makkah to Madinah, or vice versa, we ensure a hassle-free and safe journey in well-maintained, air-conditioned vehicles driven by professional and courteous drivers.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Our services cater to individuals, families, and groups, ensuring personalized solutions that meet your travel needs. With a focus on customer satisfaction, we offer flexible scheduling, competitive pricing, and reliable communication throughout your journey.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Choosing UmrahCar means choosing peace of mind for your sacred travels. We take pride in being part of your spiritual journey and are dedicated to making it memorable and stress-free. Trust us to take you where you need to go with care and reliability.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'UmrahCar – Connecting hearts and destinations with excellence.',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ), // Bold text with theme color
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}