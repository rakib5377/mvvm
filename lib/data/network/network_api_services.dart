import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiServices(String url)async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }
  @override
  Future getPostApiServices (String url, dynamic data) async {
    dynamic responseJson;
    try{
      Response response = await post(Uri.parse(url),
      body: data
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnAuthorizedRequest(response.body.toString());
      default:
        throw FetchDataException('Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }
}