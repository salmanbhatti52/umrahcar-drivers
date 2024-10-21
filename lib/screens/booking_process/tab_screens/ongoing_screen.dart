import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';
import 'package:umrahcar_driver/screens/homepage_screen.dart';
import 'package:umrahcar_driver/utils/colors.dart';
import 'package:umrahcar_driver/widgets/ongoing_list.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_service.dart';

class OnGoingPage extends StatefulWidget {
  const OnGoingPage({super.key});

  @override
  State<OnGoingPage> createState() => _OnGoingPageState();
}

class _OnGoingPageState extends State<OnGoingPage> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  List<String> suggestions = [];

  bool isFocused = false;
  GetBookingListModel getBookingOngoingResponse = GetBookingListModel();

  getBookingListOngoing() async {
    print("phoneNmbr $userId");
    var mapData = {"users_drivers_id": userId.toString()};
    if (mounted) {
      getBookingOngoingResponse =
          await DioClient().getBookingOngoing(mapData, context);
      // print("response id: ${getBookingOngoingResponse.data}");
      if (mounted) {
        setState(() {});
      }
    }
  }

  GetBookingListModel getBookingOngoingResponseForSearch =
      GetBookingListModel();

  getBookingListOngoingSearch(String? searchText) async {
    print("userIdId $userId");
    getBookingOngoingResponseForSearch.data = [];
    var mapData = {
      "users_drivers_id": userId.toString(),
      "bookings_id": searchText
    };
    if (mounted) {
      getBookingOngoingResponseForSearch =
          await DioClient().getBookingOngoing(mapData, context);
      // print("response id: ${getBookingOngoingResponseForSearch.data}");
      setState(() {
        // getBookingOngoingResponse.data = [];
      });
    }
  }

  @override
  void initState() {
    getBookingListOngoing();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SearchField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  marginColor: mainColor,
                  suggestionsDecoration: SuggestionDecoration(
                    color: mainColor,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  offset: const Offset(0, 46),
                  suggestionItemDecoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  searchInputDecoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: isFocused == true
                        ? GestureDetector(
                            onTap: () {
                              isFocused = false;
                              searchController.clear();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xFF565656),
                            ),
                            // SvgPicture.asset(
                            //   'assets/images/close-icon.svg',
                            //   width: 10,
                            //   height: 10,
                            //   fit: BoxFit.scaleDown,
                            // ),
                          )
                        : null,
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Montserrat-Regular',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  itemHeight: 40,
                  maxSuggestionsInViewPort: 4,
                  onSearchTextChanged: (value) {
                    setState(() {
                      isFocused = true;
                      if (value.isNotEmpty) {
                        getBookingListOngoingSearch(value);
                      } else {
                        getBookingListOngoing();
                      }
                    });
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter a search term';
                  //   }
                  //   return null;
                  // },
                  // scrollbarAlwaysVisible: false,
                  scrollbarDecoration: ScrollbarDecoration(
                    thumbVisibility: false,
                  ),
                  suggestionState: Suggestion.hidden,
                  suggestions: suggestions
                      .map((e) => SearchFieldListItem<String>(e))
                      .toList(),
                  suggestionStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 14,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 16,
                    fontFamily: 'Montserrat-Regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            getBookingOngoingResponseForSearch.data == null &&
                        searchController.text.isEmpty ||
                    searchController.text == ""
                ? Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RefreshIndicator(
                          onRefresh: () async {
                            getBookingListOngoing();
                            if (!mounted) {
                              setState(() {});
                            }
                          },
                          child:
                              onGoingList(context, getBookingOngoingResponse)),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: onGoingList(
                          context, getBookingOngoingResponseForSearch),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
