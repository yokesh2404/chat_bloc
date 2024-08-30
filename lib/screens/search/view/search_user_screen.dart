import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/components/box_decorations.dart';
import 'package:state_management/di.dart';
import 'package:state_management/screens/search/bloc/search_users_bloc.dart';
import 'package:state_management/screens/search/repository/search_user_repo.dart';
import 'package:state_management/utils/contants/app_colors.dart';
import 'package:state_management/utils/contants/app_sizes.dart';
import 'package:state_management/utils/helper/functions_helper.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';
import 'package:state_management/widgets/custom_loader.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchUsersBloc(DependencyInjection().getIt<SearchUserRepo>())
            ..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search User"),
          backgroundColor: AppColors.darkBlue,
        ),
        body: BlocBuilder<SearchUsersBloc, SearchUsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return const Center(
                child: CustomLoader(),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            return SingleChildScrollView(
              child: ListView.separated(
                  padding: const EdgeInsets.all(AppSizes.size_12),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var users = context.read<SearchUsersBloc>().allUsers[index];
                    return GestureDetector(
                      onTap: () => NavigationHelper.pushNamed(RouteHelper.chat,
                          arguments: users),
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.size_12),
                        decoration: BoxDecorations.boxDecorationwithoutShadow(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.darkBlue,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: AppSizes.width_06,
                                  ),
                                  SizedBox(
                                    width: AppSizes.screenWidth -
                                        AppSizes.width_180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FunctionsHelper.getInstance
                                              .capitalizeString(
                                                  users.name ?? ""),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        if (users.about != null &&
                                            users.about!.isNotEmpty)
                                          Text(
                                            FunctionsHelper.getInstance
                                                .capitalizeString(
                                                    users.about ?? ""),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: AppSizes.size_10),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chat,
                              color: AppColors.darkBlue,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: context.read<SearchUsersBloc>().allUsers.length),
            );
            // }

            // return const SizedBox();
          },
        ),
      ),
    );
  }
}
