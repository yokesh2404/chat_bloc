import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/register/model/user_details_model.dart';
import 'package:state_management/utils/helper/navigation_helper.dart';
import 'package:state_management/utils/helper/route_helper.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseStorageService firebaseStorageService;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
  HomeBloc(this.firebaseStorageService) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<NavigateToChat>((event, emit) {
      NavigationHelper.pushNamed(RouteHelper.chat,
          arguments: event.userProfile);
    });
    // on<GetAllUsersEvent>(_getAllUser);
  }

  // Stream<QuerySnapshot<UserProfile>> _getAllUser(
  //     GetAllUsersEvent event, Emitter emit) {
  //   return firebaseStorageService.getAllUser();
  // }

  // _getUser(GetAllUsersEvent event, Emitter emit) async {
  //   emit(HomeLoadingState());
  //   var data = await firebaseStorageService.searchUser(event.searchtext);

  //   if (data != null && data.isNotEmpty) {
  //     users = [];
  //     users.addAll(data);
  //     emit(UserFetchedState(users: users));
  //   } else if (data != null && data.isEmpty) {
  //     users = [];
  //     emit(UserFetchedState(users: users));
  //   } else {
  //     emit(UserFetchedError());
  //   }
  // }
}
