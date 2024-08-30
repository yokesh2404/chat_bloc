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
    on<NavigateToSearchUser>((event, emit) {
      NavigationHelper.pushNamed(RouteHelper.searchUser);
    });
  }
}
