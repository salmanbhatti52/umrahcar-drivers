import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/get_chat_model.dart';
import '../../../models/send_message_model.dart';
import '../../../service/rest_api_service.dart';
import '../../../utils/colors.dart';

class ChatPage extends StatefulWidget {
  final String? bookingId;
  final String? usersDriverId;
  final String? guestName;
  final String? driverName;

  const ChatPage({
    super.key,
    this.bookingId,
    this.usersDriverId,
    this.guestName,
    this.driverName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> chatFormKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  GetChatModel getChatModel = GetChatModel();
  SendMessageModel sendMessageModel = SendMessageModel();
  bool isLoading = false;
  String? errorMessage;

  Future<void> getChatData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      var mapData = {"bookings_id": widget.bookingId};
      getChatModel = await DioClient().getChat(mapData, context);
      setState(() {});
      // Scroll to the bottom after loading messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load chat. Please try again.";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    getChatData();
    timer = Timer.periodic(const Duration(seconds: 8), (timer) => getChatData());
  }

  @override
  void dispose() {
    timer?.cancel();
    _scrollController.dispose();
    messageController.dispose();
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/images/back-icon.svg',
                width: 22,
                height: 22,
                fit: BoxFit.scaleDown,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.surface,
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
                    widget.guestName ?? "Guest",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.003),
                  Text(
                    'Active Now',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 20),
            //   child: GestureDetector(
            //     onTap: () {
            //       // Add action for contact icon (e.g., make a call or open contact details)
            //     },
            //     child: SvgPicture.asset(
            //       'assets/images/contact-icon.svg',
            //       width: 22,
            //       height: 22,
            //       fit: BoxFit.scaleDown,
            //       color: Theme.of(context).colorScheme.onSurface,
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: isLoading && getChatModel.data == null
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      errorMessage!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: getChatData,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              )
                  : getChatModel.data != null &&
                  getChatModel.data!.message != null
                  ? RefreshIndicator(
                color: primaryColor,
                onRefresh: getChatData,
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10),
                  itemCount: getChatModel.data!.message!.length,
                  itemBuilder: (BuildContext context, int i) {
                    final message = getChatModel.data!.message![i];
                    final isSender =
                        message.receiver != "Drivers";
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? primaryColor
                                  : Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.9),
                              borderRadius: BorderRadius.only(
                                topLeft:
                                const Radius.circular(15),
                                topRight:
                                const Radius.circular(15),
                                bottomLeft: isSender
                                    ? const Radius.circular(15)
                                    : const Radius.circular(0),
                                bottomRight: isSender
                                    ? const Radius.circular(0)
                                    : const Radius.circular(15),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              message.message ?? "",
                              style: TextStyle(
                                color: isSender
                                    ? Colors.white
                                    : Theme.of(context)
                                    .colorScheme
                                    .onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // const SizedBox(height: 3),
                          // Text(
                          //   // Replace with actual timestamp if available
                          //   "02:09",
                          //   style: TextStyle(
                          //     color: isSender
                          //         ? primaryColor
                          //         : Colors.grey,
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Text(
                  "No Chat Found",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: chatFormKey,
                child: TextFormField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Message field is required!';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                    Theme.of(context).colorScheme.surface.withOpacity(0.1),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
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
                    hintStyle:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        if (chatFormKey.currentState!.validate()) {
                          var mapData = {
                            "bookings_id": widget.bookingId,
                            "users_drivers_id": widget.usersDriverId,
                            "receiver": "Guest",
                            "guest_name": widget.guestName,
                            "message": messageController.text,
                          };
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            sendMessageModel = await DioClient()
                                .sendMessage(mapData, context);
                            if (sendMessageModel.data != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                                  content: Text(
                                    sendMessageModel.data!,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              );
                              await getChatData();
                              messageController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Failed to send message. Please try again.",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                              : SvgPicture.asset(
                            'assets/images/send-icon.svg',
                            width: 25,
                            height: 25,
                            fit: BoxFit.scaleDown,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}