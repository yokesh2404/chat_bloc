import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/components/app_text_field.dart';
import 'package:state_management/components/box_decorations.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/chat/bloc/chat_bloc.dart';
import 'package:state_management/screens/chat/model/message_model.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_enums.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/helper/encrypt_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _scrollToEnd();
    });
  }

  // void _scrollToEnd() {
  //   // Scroll to the maximum scroll extent (bottom of the content)
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

  @override
  void dispose() {
    chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: Text(widget.userProfile.name ?? ""),
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: BlocBuilder<ChatBloc, ChatState>(
          bloc: ChatBloc()
            ..add(GetChatListEvent(receiverDetails: widget.userProfile)),
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  controller: _scrollController,
                  child: StreamBuilder<List<Message>>(
                    stream: FirebaseStorageService()
                        .getChatStream(widget.userProfile.userId ?? ""),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else if (snapshot.connectionState ==
                              ConnectionState.active &&
                          snapshot.hasData) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        });
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                    left: snapshot.data![index].recieverid ==
                                            widget.userProfile.userId
                                        ? 12
                                        : 12,
                                    right: snapshot.data![index].recieverid ==
                                            widget.userProfile.userId
                                        ? 12
                                        : 12),
                                alignment: snapshot.data![index].recieverid ==
                                        widget.userProfile.userId
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: snapshot.data![index].recieverid ==
                                          widget.userProfile.userId
                                      ? const EdgeInsets.only(
                                          left: 30,
                                        )
                                      : const EdgeInsets.only(right: 30),
                                  padding: const EdgeInsets.only(
                                      top: 6, bottom: 6, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: snapshot
                                                  .data![index].recieverid ==
                                              widget.userProfile.userId
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            )
                                          : const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                      color: snapshot.data![index].recieverid ==
                                              widget.userProfile.userId
                                          ? AppColors.darkBlue
                                          : Colors.grey[700]),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   snapshot.data![index].,
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(
                                        //     fontSize: 13,
                                        //     fontWeight: FontWeight.bold,
                                        //     letterSpacing: -0.2,
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 8,
                                        // ),
                                        Text(
                                          EncryptHelper.decryptAES(
                                              snapshot.data![index].text ?? ""),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: AppColors.white),
                                        )
                                      ]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 2,
                              );
                            },
                            itemCount: snapshot.data!.length);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppTextFormField(
                      textInputAction: TextInputAction.done,
                      labelText: "",
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (chatController.text.isNotEmpty) {
                            context.read<ChatBloc>().add(SendMessageEvent(
                                receiverDetails: widget.userProfile,
                                message: chatController.text,
                                messageType: MessageEnum.text));
                            chatController.clear();
                            // FocusScope.of(context).unfocus();
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      controller: chatController),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
