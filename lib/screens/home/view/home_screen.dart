import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/components/app_text_field.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/home/bloc/home_bloc.dart';
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
              child: Column(
                children: [
                  AppTextFormField(
                      onChanged: (p0) {
                        context.read<HomeBloc>().add(GetAllUsersEvent(
                            searchtext: searchController.text));
                      },
                      decoration: InputDecoration(
                        labelText: "",
                        hintText: AppStrings.searchUser,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.black),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            context.read<HomeBloc>().add(GetAllUsersEvent(
                                searchtext: searchController.text));
                          },
                          child: const Icon(
                            Icons.search,
                            color: AppColors.black,
                          ),
                        ),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      textInputAction: TextInputAction.done,
                      labelText: AppStrings.searchUser,
                      keyboardType: TextInputType.emailAddress,
                      controller: searchController),
                  if (state is HomeLoadingState) ...[
                    const Center(
                      child: CustomLoader(),
                    )
                  ] else if (state is UserFetchedState) ...[
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.headphones),
                                  backgroundColor: AppColors.borderPrimary,
                                ),
                                SizedBox(
                                  width: AppSizes.width_06,
                                ),
                                Text("${homeBloc.users[index].get("name")}")
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: AppSizes.size_12,
                          );
                        },
                        itemCount: homeBloc.users.length)
                  ] else if (state is UserFetchedError) ...[
                    const Text("error")
                  ] else ...[
                    const SizedBox()
                  ]
                ],
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
