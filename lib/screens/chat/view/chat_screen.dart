import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    chatController.dispose();
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
                  child: StreamBuilder<List<Message>>(
                    stream: FirebaseStorageService()
                        .getChatStream(widget.userProfile.userId ?? ""),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("data");
                      } else if (snapshot.connectionState ==
                              ConnectionState.active &&
                          snapshot.hasData) {
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
                                        ? 25
                                        : 0,
                                    right: snapshot.data![index].recieverid ==
                                            widget.userProfile.userId
                                        ? 0
                                        : 25),
                                alignment: snapshot.data![index].recieverid ==
                                        widget.userProfile.userId
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: snapshot.data![index].recieverid ==
                                          widget.userProfile.userId
                                      ? EdgeInsets.only(
                                          left: 30,
                                        )
                                      : EdgeInsets.only(right: 30),
                                  padding: EdgeInsets.only(
                                      top: 17, bottom: 17, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: snapshot
                                                  .data![index].recieverid ==
                                              widget.userProfile.userId
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            )
                                          : BorderRadius.only(
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
                                          snapshot.data![index].text ?? "",
                                          textAlign: TextAlign.center,
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
                              return SizedBox(
                                height: AppSizes.height_12,
                              );
                            },
                            itemCount: snapshot.data!.length);
                      } else {
                        return SizedBox();
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
