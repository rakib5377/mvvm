

import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/resources/app_url.dart';

class AuthRepository{

  BaseApiServices _baseApiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {

    try{
      dynamic response = await _baseApiServices.getPostApiServices(AppUrl.loginApiEndpoint, data, AppHeaders.headersData);
      return response;
    }
    catch(e){
      throw e;
    }


  }

  Future<dynamic> signUpApi(dynamic data) async{

    try{
      dynamic response = await _baseApiServices.getPostApiServices(AppUrl.registerApiEndpoint, data, AppHeaders.headersData);
      return response;
    }
    catch(e){
      throw e;
    }

  }

}