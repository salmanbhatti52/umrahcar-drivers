import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget box(image, priceText, titleText, context) {
  return Center(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0, -1),
          end: Alignment(0.037, 1.01),
          colors: [Color(0x84438f01), Color(0xff7cd037)],
          stops: [0, 1],
        ),
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   tileMode: TileMode.clamp,
        //   colors: [
        //     const Color(0xFF438F02).withOpacity(0.52),
        //     const Color(0xFF7DD038),
        //   ],
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Text(
                priceText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w700,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}