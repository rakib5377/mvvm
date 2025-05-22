import 'package:flutter/foundation.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movie_list_model.dart';
import 'package:mvvm/repository/home_view_repository.dart';



class HomeViewViewModel with ChangeNotifier {


  final _myRepo = HomeViewRepository();


  ApiResponse<MovieListModel> movieList = ApiResponse.loading();

  seMovieList(ApiResponse<MovieListModel> response){
    movieList = response;
    notifyListeners();
  }

  Future<void> fetchMovieList() async {
    
    seMovieList(ApiResponse.loading());
    _myRepo.fetchMovieListRepo().then((value){
      seMovieList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
      seMovieList(ApiResponse.error(error.toString()));
    });
  }
}