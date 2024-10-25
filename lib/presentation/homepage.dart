import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradexa/data_layer/providers/movieprovider.dart';
import 'package:tradexa/presentation/components/moviecard.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(fontFamily: 'Montserrat'),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      ),
                      onPressed: () {
                        final currentText =
                            context.read<MovieProvider>().searchQuery;
                        if (currentText.isNotEmpty) {
                          context
                              .read<MovieProvider>()
                              .searchMovies(currentText);
                        }
                      },
                    ),
                    border: const OutlineInputBorder(
                      borderRadius:BorderRadius.all(
                        Radius.zero,
                      ),

                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context.read<MovieProvider>().searchMovies(value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Consumer<MovieProvider>(
                  builder: (context, movieProvider, child) {
                    if (movieProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (movieProvider.error.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${movieProvider.error}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'Montserrat',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => movieProvider.searchMovies(''),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (movieProvider.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: movieProvider.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movieProvider.movies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
