import 'package:flutter/foundation.dart';
import 'package:tradexa/data_layer/models/movie.dart';
import 'package:tradexa/data_layer/services/apiservice.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get searchQuery => _searchQuery;

  Future<void> searchMovies(String query) async {
    if (query == _searchQuery) return;

    _searchQuery = query;
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _movies = await _apiService.searchMovies(query);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

