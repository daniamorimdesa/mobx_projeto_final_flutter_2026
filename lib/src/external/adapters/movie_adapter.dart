// movie_adapter.dart: métodos estáticos de serialização/desserialização de mensagens protobuf relacionadas a filmes

import "dart:typed_data";
import "package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart";

// classe responsável por adaptar e decodificar mensagens protobuf relacionadas ao filme
class MovieAdapter {
  // método estático que decodifica uma mensagem protobuf em instância de Movie - desserialização(Uint8List -> Movie)
  static Movie decodeProto(Uint8List encodedMovie) {
    try {
      final movie = Movie.fromBuffer(encodedMovie); // desserialização
      return movie;
    } catch (e) {
      throw Exception("Erro ao decodificar o proto: $e");
    }
  }

  // método estático que codifica uma instância de Movie em uma mensagem protobuf - serialização(Movie -> Uint8list)
  static Uint8List encodeProto(Movie movie) {
    try {
      final encodedMovie = movie.writeToBuffer(); // serialização
      return encodedMovie;
    } catch (e) {
      throw Exception("Erro ao codificar o proto: $e");
    }
  }

  // método estático para decodificar uma lista de filmes que vem na mensagem Movies
  static List<Movie> decodeProtoList(Uint8List encodedMovies) {
    try {
      final moviesList = Movies.fromBuffer(encodedMovies); // desserialização da mensagem que contém a lista
      return moviesList.movies; // retorna a lista de filmes
    } catch (e) {
      throw Exception("Erro ao decodificar a lista de filmes: $e");
    }
  }
}
