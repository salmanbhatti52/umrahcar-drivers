import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../models/get_chat_model.dart';
import '../../../models/send_message_model.dart';
import '../../../service/rest_api_service.dart';
import '../../../utils/colors.dart';

class ChatPage extends StatefulWidget {
  String? bookingId;
  String? usersDriverId;
  String? guestName;
  String? driverName;
  ChatPage({super.key,this.bookingId,this.usersDriverId,this.guestName,this.driverName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> chatFormKey = GlobalKey<FormState>();


  GetChatModel getChatModel=GetChatModel();

  SendMessageModel sendMessageModel=SendMessageModel();

  getChatData()async{
    print("bookingId ${widget.bookingId}");
    var mapData={
      "bookings_id": widget.bookingId
    };
    getChatModel= await DioClient().getChat(mapData, context);
    print("response id: ${getChatModel.data!.message}");
    setState(() {

    });

  }
  GlobalKey<RefreshIndicatorState>? refreshKey;
  Timer? timer;

  @override
  void initState() {
    getChatData();
    timer =
        Timer.periodic( const Duration(seconds: 8), (timer) => getChatData());
    setState(() {

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
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
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/images/back-icon.svg',
              width: 22,
              height: 22,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: Image.asset(
                        'assets/images/user-profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: size.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.driverName}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * 0.003),
                        Text(
                          'Active Now',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/images/contact-icon.svg',
                width: 22,
                height: 22,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: chatFormKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  getChatModel.data !=null ?
                  Container(
                    height:MediaQuery.of(context).size.height/1.3,
                    child: RefreshIndicator(
                      key: refreshKey,
                      color: primaryColor,
                      onRefresh: ()async{
                        await Future.delayed(const Duration(milliseconds: 1500));
                        getChatData();

                        setState(() {

                        });
                      },
                      child: ListView.builder(
                          itemCount: getChatModel.data!.message!.length,
                          itemBuilder: (BuildContext context,i){
                            return Column(
                              children: [
                                Align(
                                  alignment:getChatModel.data!.message![i].receiver=="Drivers" ?  Alignment.centerLeft: Alignment.centerRight,
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: getChatModel.data!.message![i].receiver=="Drivers" ? const Color(0xFFF2F2F2) : primaryColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        '${getChatModel.data!.message![i].message}',
                                        style:  TextStyle(
                                          color: getChatModel.data!.message![i].receiver=="Drivers" ? Colors.black: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat-Regular',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.005),
                                // Align(
                                //   alignment:getChatModel.data!.message![i].receiver=="Drivers" ?  Alignment.centerLeft: Alignment.centerRight,
                                //   child: const Text(
                                //     '02:09',
                                //     style: TextStyle(
                                //       color: primaryColor,
                                //       fontSize: 10,
                                //       fontFamily: 'Montserrat-Regular',
                                //       fontWeight: FontWeight.w500,
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          }),
                    ),
                  )
                      : Container(
                      height:MediaQuery.of(context).size.height/1.3,
                      child: const Column(

                        children: [
                          SizedBox(height: 350,),
                          Text("No Chat Found"),
                        ],
                      )),



                  TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Message field is required!';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                    decoration: InputDecoration(
                      filled: false,
                      errorStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: const Color(0xFF000000).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      hintText: "Write a message",
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: InkWell(
                        onTap: () async {
                          if(chatFormKey.currentState!.validate()){
                            var mapData={
                              "bookings_id":"${widget.bookingId}",
                              "users_drivers_id":"${widget.usersDriverId}",
                              "receiver":"Guest",
                              "guest_name":"${widget.guestName}",
                              "message":messageController.text
                            };
                            print("mapData: $mapData");
                            sendMessageModel= await DioClient().sendMessage(mapData, context);
                            print("Status id: ${sendMessageModel.data!}");
                            if(sendMessageModel.data !=null){
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${sendMessageModel.data}")));
                              getChatData();
                              messageController.text="";
                              FocusManager.instance.primaryFocus?.unfocus();

                              setState(() {

                              });
                            }

                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: SvgPicture.asset(
                              'assets/images/send-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
