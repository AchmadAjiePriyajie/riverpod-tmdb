import 'package:rest_api_riverpod/Services/movie_service.dart';
import 'package:rest_api_riverpod/models/movie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_provider.g.dart';

MovieService movieService = MovieService();

@riverpod
class MovieNotifier extends _$MovieNotifier {
  @override
  FutureOr<List<Movie>> build() async {
    return [];
  }

  Future<void> getPopularMovies() async {
    state = const AsyncValue.loading();
    try {
      final movies = await movieService.getAllMovies();
      state = AsyncValue.data(movies);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
