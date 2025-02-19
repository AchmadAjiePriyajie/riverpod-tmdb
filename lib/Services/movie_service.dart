import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rest_api_riverpod/models/movie.dart';

class MovieService {
  final dio = Dio(
    BaseOptions(
      headers: {
        'authorization': dotenv.env['TMDB_API_KEY'],
        'accept': 'application/json',
      },
    ),
  );

  Future<List<Movie>> getAllMovies() async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/trending/movie/day?language=en-US');
      final results = response.data['results'] as List<dynamic>;
      return results.map((e) => Movie.fromJson(e)).toList();
    } catch (e) {
      // You might want to handle different types of errors differently
      throw Exception('Failed to fetch movies');
    }
  }
}
