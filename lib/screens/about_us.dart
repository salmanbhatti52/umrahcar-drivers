import 'package:flutter/material.dart';
import 'package:umrahcar_driver/utils/colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          'About Us',
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
                'Welcome to UmrahCar, your trusted partner in reliable and comfortable transportation services in Saudi Arabia. We specialize in providing seamless travel experiences for pilgrims and visitors traveling between Makkah, Madinah, and Jeddah.',
                 style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'At UmrahCar, we understand the importance of a smooth journey, especially during sacred travels like Umrah. Our commitment is to deliver exceptional service with a focus on convenience, punctuality, and comfort. Whether you need transportation from Jeddah to Makkah, Makkah to Madinah, or vice versa, we ensure a hassle-free and safe journey in well-maintained, air-conditioned vehicles driven by professional and courteous drivers.',
                 style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Our services cater to individuals, families, and groups, ensuring personalized solutions that meet your travel needs. With a focus on customer satisfaction, we offer flexible scheduling, competitive pricing, and reliable communication throughout your journey.',
                 style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choosing UmrahCar means choosing peace of mind for your sacred travels. We take pride in being part of your spiritual journey and are dedicated to making it memorable and stress-free. Trust us to take you where you need to go with care and reliability.',
                 style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'UmrahCar – Connecting hearts and destinations with excellence.',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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