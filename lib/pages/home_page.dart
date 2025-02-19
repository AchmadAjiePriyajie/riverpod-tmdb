import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest_api_riverpod/models/movie.dart';
import 'package:rest_api_riverpod/providers/movie_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Movies'),
      ),
      body: moviesAsync.when(
        data: (movies) => GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            Movie movie = movies[index];
            return Column(
              children: [
                movie.backdropPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      )
                    : const Icon(Icons
                        .image_not_supported), // Show placeholder when no image
                Text(movie.title!),
              ],
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: IconButton(
          onPressed: () {
            ref.read(movieNotifierProvider.notifier).getPopularMovies();
          },
          icon: Icon(Icons.replay),
        ),
      ),
    );
  }
}
