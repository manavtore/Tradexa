import 'package:http/http.dart' as http;
import 'package:tradexa/data_layer/models/movie.dart';
import 'dart:convert';


class ApiService {
  static const String baseUrl = 'http://www.omdbapi.com/';
  static const String apiKey = '78c88950';

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(
        Uri.parse('$baseUrl?apikey=$apiKey&s=$query&type=movie'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Search Response: $data'); 

        if (data['Response'] == 'False') {
          throw Exception(data['Error']);
        }

        final List<dynamic> searchResults = data['Search'] ?? [];
        List<Movie> movies = [];

        for (var result in searchResults) {
          try {
            final detailResponse = await http.get(
              Uri.parse('$baseUrl?apikey=$apiKey&i=${result['imdbID']}'),
            );

            if (detailResponse.statusCode == 200) {
              final detailData = json.decode(detailResponse.body);

              final movie = Movie.fromJson(detailData);
              movies.add(movie);
            }
          } catch (e) {
            print('Error fetching details for movie ${result['imdbID']}: $e');
            continue;
          }
        }

        return movies;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
