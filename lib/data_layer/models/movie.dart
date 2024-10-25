class Movie {
  final String title;
  final String year;
  final String posterUrl;
  final double rating;
  final List<String> cast;
  final String imdbId;
  final List<String> genres; 

  Movie({
    required this.title,
    required this.year,
    required this.posterUrl,
    required this.rating,
    required this.cast,
    required this.imdbId,
    required this.genres, 
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      posterUrl: json['Poster'] != 'N/A' ? json['Poster'] : '',
      rating: double.tryParse(json['imdbRating'] ?? '0.0') ?? 0.0,
      cast: (json['Actors'] ?? '')
          .toString()
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      imdbId: json['imdbID'] ?? '',
      genres: (json['Genre'] ?? '')
          .toString()
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );
  }
}
