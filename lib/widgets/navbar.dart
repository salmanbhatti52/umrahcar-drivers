import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/screens/profile_screen.dart';
import 'package:umrahcar_driver/screens/homepage_screen.dart';
import 'package:umrahcar_driver/screens/settings_screen.dart';
import 'package:umrahcar_driver/screens/booking_process/bookings_screen.dart';

import '../screens/wallet_screen.dart';

class NavBar extends StatefulWidget {
  int? indexNmbr;
  int? walletPage;
  int? bookingNmbr;
  NavBar({super.key, this.indexNmbr, this.walletPage, this.bookingNmbr});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  @override
  void initState() {
    if (widget.indexNmbr != null) {
      index = widget.indexNmbr!;
    }
    print("index Id; $index");
    print("bookingPage0; ${widget.bookingNmbr}");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      BookingsPage(indexNmbr: widget.bookingNmbr),
      const ProfilePage(),
      WalletPage(
        indexNmbr: widget.walletPage,
      ),
      const SetttingsPage(),
    ];

    return Scaffold(
      backgroundColor: mainColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          border: Border.all(
            color: const Color(0xFFFFFFFF).withOpacity(0.15),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorShape: const CircleBorder(),
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: mainColor,
              selectedIndex: index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/home-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-home-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/bookings-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-bookings-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Bookings',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/profile-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-profile-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/wallet-icon.svg',
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-wallet-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Wallet',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/settings-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-settings-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
