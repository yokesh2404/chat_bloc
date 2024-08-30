import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/di.dart';
import 'package:state_management/screens/search/bloc/search_users_bloc.dart';
import 'package:state_management/screens/search/repository/search_user_repo.dart';
import 'package:state_management/utils/contants/app_colors.dart';
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Text("$index");
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: context.read<SearchUsersBloc>().users.length),
            );
            // }

            // return const SizedBox();
          },
        ),
      ),
    );
  }
}
