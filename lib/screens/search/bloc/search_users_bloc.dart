import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_management/screens/login/bloc/login_bloc.dart';
import 'package:state_management/screens/search/model/api_response.dart';
import 'package:state_management/screens/search/repository/search_user_repo.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final SearchUserRepo repository;
  List<ApiResponse> users = [];

  SearchUsersBloc(this.repository) : super(SearchUsersInitial()) {
    on<SearchUsersEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchUsersEvent>(_onLoadUsers);
  }

  _onLoadUsers(FetchUsersEvent event, Emitter emit) async {
    emit(UsersLoadingState());
    try {
      users = await repository.getUserData();
      if (users.isEmpty) {
        emit(ErrorState(message: "There is no data found"));
      } else {
        emit(FetchUsersState(usersList: users));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
