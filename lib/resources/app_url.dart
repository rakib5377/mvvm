class AppUrl {

  static const baseUrl = "https://reqres.in/";

  static const loginApiEndpoint = baseUrl + 'api/login';

  static const registerApiEndpoint = baseUrl + 'api/register';

  static var moviesBaseUrl = "https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/";
  static var moviesListEndPoint =  moviesBaseUrl + "movies_list" ;

}

class AppHeaders {
   static const Map<String, String> headersData = {
    "x-api-key": "reqres-free-v1"
  };
}