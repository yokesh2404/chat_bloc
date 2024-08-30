import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_management/screens/login/bloc/login_bloc.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/screens/search/model/api_response.dart';
import 'package:state_management/screens/search/repository/search_user_repo.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final SearchUserRepo repository;
  List<ApiResponse> users = [];
  List<UserProfile> allUsers = [];
  StreamSubscription? _subscription;
  SearchUsersBloc(this.repository) : super(SearchUsersInitial()) {
    on<SearchUsersEvent>((event, emit) {});

    on<FetchUsersEvent>(_onLoadUsers);
  }

  _onLoadUsers(FetchUsersEvent event, Emitter emit) async {
    emit(UsersLoadingState());
    try {
      var _users = await repository.getAllUsers().first;

      if (_users.isEmpty) {
        emit(ErrorState(message: "There is no data found"));
      } else {
        allUsers.addAll(_users);
        emit(FetchAllUsers(allUsers: allUsers));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
