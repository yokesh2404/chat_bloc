import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/components/app_text_field.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/chat/model/chat_contact.dart';
import 'package:state_management/screens/home/bloc/home_bloc.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/contants/app_strings.dart';
import 'package:state_management/widgets/button_widget.dart';
import 'package:state_management/widgets/custom_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.homeHeader,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: AppSizes.size_18,
              fontWeight: FontWeight.w600,
              color: AppColors.white),
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(FirebaseStorageService()),
        child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            var homeBloc = context.read<HomeBloc>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.size_12),
              child: StreamBuilder(
                  stream: firebaseStorageService.getAllChatUserStream(),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        if (snapshot.hasData)
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    homeBloc.add(NavigateToChat(
                                        userProfile: snapshot
                                            .data![index].userProfile!));
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor:
                                              AppColors.borderPrimary,
                                          child: Icon(Icons.headphones),
                                        ),
                                        const SizedBox(
                                          width: AppSizes.width_06,
                                        ),
                                        Text("${snapshot.data![index].name}")
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: AppSizes.size_12,
                                );
                              },
                              itemCount: snapshot.data!.length)
                      ],
                    );
                  }),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
