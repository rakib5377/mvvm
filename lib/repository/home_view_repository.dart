


import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/model/movie_list_model.dart';
import 'package:mvvm/resources/app_url.dart';

class HomeViewRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> fetchMovieListRepo () async {

    try{
      dynamic response = await _apiServices.getGetApiServices(AppUrl.moviesListEndPoint);
      return MovieListModel.fromJson(response);
    }
    catch(e){
      throw e;
    }
  }


}