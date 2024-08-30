import 'package:dio/dio.dart';
import 'package:state_management/screens/search/model/api_response.dart';
import 'package:state_management/utils/network/api_client.dart';
import 'package:state_management/utils/network/api_repo.dart';

class SearchUserRepo {
  final ApiRepo apiRepo;

  SearchUserRepo({required this.apiRepo});

  Future<List<ApiResponse>> getUserData() async {
    List<ApiResponse> list = [];
    try {
      Response response = await apiRepo.getData(ApiClient.apiUrl);

      if (response.data != null && response.data.isNotEmpty) {
        for (var element in response.data) {
          ApiResponse result = ApiResponse.fromJson(element);
          list.add(result);
        }
      }
      return list;
    } catch (e) {
      return list;
    }
  }
}
