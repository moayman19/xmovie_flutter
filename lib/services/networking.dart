import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const apiKey = 'd6039ee2bb74b1e8ca74dd05a6dee0fe';

class Networking {
  Future getMoviesData(String sortBy, int page) async {
    String url =
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=$sortBy&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);

      return jsonData['results'];
    } else {
      print(response.statusCode);
    }
  }

  Future getSearchMovieData(
    String name,
  ) async {
    String url =
        'https://api.themoviedb.org/3/search/movie?query=$name&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);

      return jsonData['results'];
    } else {
      print(response.statusCode);
    }
  }
}
