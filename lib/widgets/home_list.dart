import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/screens/tracking_process/track_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';

Widget homeList(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: myList.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(myList[index].image),
              ),
              SizedBox(width: size.width * 0.005),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myList[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-location-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Makkah Hottle Aziziz',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-car-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Sedan',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-bookings-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        '12:00 am on 2-12-2022',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  TrackPage(),
                      ));
                },
                child: Container(
                  color: Colors.transparent,
                  width: size.width * 0.2,
                  height: size.height * 0.024,
                  child: Text(
                    'Details',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      );
    },
  );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
];

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
