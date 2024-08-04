import 'package:base_project_mvvm_provider/base/base_view_model.dart';
import 'package:base_project_mvvm_provider/repository/home_repository.dart';

import '../data/response/api_response.dart';
import '../models/movies_model.dart';

class HomeViewModel extends BaseModel {
  final HomeRepository homeRepo = HomeRepository();

  ApiResponse<MoviesModel> moviesList = ApiResponse.idle();

  void setMoviesList(ApiResponse<MoviesModel> response) async {
    moviesList = response;
    notifyListeners();
  }

  void fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());

    homeRepo.fetchMoviesList().then((data) {
      setMoviesList(ApiResponse.completed(data));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
