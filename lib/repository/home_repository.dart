import 'package:base_project_mvvm_provider/data/network/api_services.dart';
import 'package:base_project_mvvm_provider/models/movies_model.dart';
import 'package:base_project_mvvm_provider/data/network/api_endpoints.dart';

class HomeRepository {
  final ApiServices apiService = ApiServices();

  Future<MoviesModel> fetchMoviesList() async {
    try {
      dynamic response =
          await apiService.getGetApiResponse(ApiEndpoints.moviesListEndPoint);
      return response = MoviesModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
