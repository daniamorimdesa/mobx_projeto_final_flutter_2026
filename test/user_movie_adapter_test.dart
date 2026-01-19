import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/movie_adapter.dart';

void main() {
  group('UserAdapter', () {
    test('serializa e desserializa User', () {
      final user = User()
        ..id = 1
        ..username = 'usuario'
        ..password = 'senha';

      final bytes = UserAdapter.encodeProto(user);
      final userDecoded = UserAdapter.decodeProto(bytes);

      expect(userDecoded.id, user.id);
      expect(userDecoded.username, user.username);
      expect(userDecoded.password, user.password);
    });
  });

  group('MovieAdapter', () {
    test('serializa e desserializa Movie', () {
      final movie = Movie()
        ..id = 10
        ..title = 'Filme'
        ..cover = Uint8List.fromList([1, 2, 3])
        ..value = 9.99
        ..year = '2023'
        ..director = 'Diretor'
        ..sinopse = 'Sinopse';

      final bytes = MovieAdapter.encodeProto(movie);
      final movieDecoded = MovieAdapter.decodeProto(bytes);

      expect(movieDecoded.id, movie.id);
      expect(movieDecoded.title, movie.title);
      expect(movieDecoded.cover, movie.cover);
      expect(movieDecoded.value, movie.value);
      expect(movieDecoded.year, movie.year);
      expect(movieDecoded.director, movie.director);
      expect(movieDecoded.sinopse, movie.sinopse);
    });

    test('serializa e desserializa lista de Movie', () {
      final movie1 = Movie()..id = 1..title = 'A';
      final movie2 = Movie()..id = 2..title = 'B';
      final movies = Movies()..movies.addAll([movie1, movie2]);

      final bytes = movies.writeToBuffer();
      final moviesDecoded = MovieAdapter.decodeProtoList(bytes);

      expect(moviesDecoded.length, 2);
      expect(moviesDecoded[0].id, movie1.id);
      expect(moviesDecoded[1].title, movie2.title);
    });
  });
}