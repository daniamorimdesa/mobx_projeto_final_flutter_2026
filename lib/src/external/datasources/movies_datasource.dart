// movies_datasource.dart: fonte de dados externa para operações relacionadas aos filmes via API http

import 'package:http/http.dart' as http;
import 'package:projeto_final_flutter_2026/src/external/adapters/movie_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

class MoviesDatasource {
  final client = http.Client(); // cliente http para fazer requisições

  // método getAvailableMovies via GET: listar filmes disponíveis
  Future<List<Movie>> getAvailableMovies() async {
    try {
      // requisição GET
      final response = await client.get(
        Uri.parse('http://127.0.0.1:8000/available-movies'),
      );
      if (response.statusCode == 200) {
        return MovieAdapter.decodeProtoList(
          response.bodyBytes,
        ); // desserializa a resposta
      } else {
        throw Exception(
          "Servidor não conseguiu processar a requisição (status ${response.statusCode})",
        ); // erro de status
      }
    } on http.ClientException catch (e) {
      throw Exception(
        "Não foi possível conectar ao servidor: $e",
      ); // erro de conexão
    } catch (e) {
      throw Exception("Erro ao buscar filmes disponíveis: $e"); // erro genérico
    }
  }

  // método getMoviesRentalByUser via POST: listar filmes alugados pelo usuário
  Future<List<Movie>> getMoviesRentalByUser(User user) async {
    try {
      // requisição POST
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/movies-rental-by-user'),
        body: UserAdapter.encodeProto(user),
        headers: {'Content-Type': 'application/octet-stream'},
      );
      if (response.statusCode == 200) {
        return MovieAdapter.decodeProtoList(response.bodyBytes);
      } else {
        throw Exception(
          "Servidor não conseguiu processar a requisição (status ${response.statusCode})",
        );
      }
    } on http.ClientException catch (e) {
      throw Exception("Não foi possível conectar ao servidor: $e");
    } catch (e) {
      throw Exception("Erro ao buscar filmes alugados pelo usuário: $e");
    }
  }

  // método rentalMovie via POST: alugar um filme para o usuário
  Future<bool> rentalMovie(int userId, int movieId) async {
    try {
      // criar rental
      final rental = Rental()
        ..userId = userId
        ..movieId = movieId;
      // requisição POST
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/rental-movie'),
        body: rental.writeToBuffer(), // serializa o rental
        headers: {'Content-Type': 'application/octet-stream'},
      );
      return response.statusCode == 200;
    } on http.ClientException catch (e) {
      throw Exception("Não foi possível conectar ao servidor: $e");
    } catch (e) {
      throw Exception("Erro ao alugar filme: $e");
    }
  }
}

  // método watchMovie via POST: assistir um filme para o usuário
  Future<bool> watchMovie(int userId, int movieId) async {
    try {
      // criar rental
      final rental = Rental()
        ..userId = userId
        ..movieId = movieId;
      // requisição POST
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/rental-movie'),
        body: rental.writeToBuffer(), // serializa o rental
        headers: {'Content-Type': 'application/octet-stream'},
      );
      return response.statusCode == 200;
    } on http.ClientException catch (e) {
      throw Exception("Não foi possível conectar ao servidor: $e");
    } catch (e) {
      throw Exception("Erro ao alugar filme: $e");
    }
  }
}