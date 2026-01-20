import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/datasources/movies_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/datasources/user_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => LoginStore())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // testar o encode/decode do protobuf
    testeProto();
    // testar endpoints de movies
    testMoviesEndpoints();
  }

  @override
  void dispose() {
    super.dispose(); // liberar recursos
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

void testeProto() {
  try {
    // criar um usuário
    final user = User()
      ..username = "Dani"
      ..password = "1234";

    // testar a serialização - (User -> Uint8List)
    final encoded = UserAdapter.encodeProto(user);
    debugPrint("Encoded: $encoded. Tamanho: ${encoded.length}");

    // testar a desserialização - (Uint8List -> User)
    final decoded = UserAdapter.decodeProto(encoded);
    debugPrint(
      "Decoded: \nusername: ${decoded.username} \npassword: ${decoded.password}",
    );
  } catch (e, st) {
    debugPrint('Falha no autoteste do proto: $e');
    debugPrint(st.toString());
  }
}


Future<void> testMoviesEndpoints() async {
  User? user;
  
  // 1) login do usuário para obter user com id
  try {
    final credentials = User()
      ..username = "joao"
      ..password = "1234";

    user = await UserDatasource().login(credentials);
    debugPrint("Usuário logado: ${user.username} com id ${user.id}");
  } catch (e) {
    debugPrint('Falha no login: $e');
    return; // se o login falhar, não continua
  }

  // 2) Filmes disponíveis - available-movies
  try {
    final movies = await MoviesDatasource().getAvailableMovies();
    debugPrint("Quantidade de filmes: ${movies.length}");
    debugPrint("Primeiro filme: ${movies.first.title}");
    debugPrint("Último filme: ${movies.last.title}");
  } catch (e) {
    debugPrint('Falha ao buscar filmes: $e');
  }

  // 3) Filmes alugados pelo usuário - movies-rental-by-user
  try {
    final rentals = await MoviesDatasource().getMoviesRentalByUser(user);
    debugPrint("Quantidade de filmes alugados pelo usuário: ${rentals.length}");
    if (rentals.isNotEmpty) {
      debugPrint("Primeiro filme alugado: ${rentals.first.title}");
    }
  } catch (e) {
    debugPrint('Falha ao buscar filmes alugados: $e');
  }
}
