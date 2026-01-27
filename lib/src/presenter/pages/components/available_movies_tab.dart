// available_movies_tab.dart: Aba para exibir filmes disponíveis para aluguel
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/movie_details_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/movies_grid.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

class AvailableMoviesTab extends StatelessWidget {
  const AvailableMoviesTab({super.key});

  // construir a interface da aba de filmes disponíveis
  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>(); // observar mudanças na UserStore

    // se estiver carregando, mostrar indicador de progresso
    if (store.isLoadingAvailable) {
      return const Center(child: CircularProgressIndicator());
    }

    // se houver erro, mostrar mensagem de erro
    if (store.errorMessage.isNotEmpty && store.availableMovies.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF2B003F).withOpacity(0.9), 
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF9C27B0), width: 1.2),
          ),
          child: Text(
            store.errorMessage,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // mostrar grade de filmes disponíveis
    return Padding(
      padding: const EdgeInsets.all(42), // padding ao redor da grade
      child: MoviesGrid(
        movies: store.availableMovies, // lista de filmes disponíveis
        emptyText: "Nenhum filme disponível no momento.",
        footerBuilder: (movie) => Column(
          children: [
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ), // estilo do título
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              "R\$ ${movie.value.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Color.fromARGB(255, 213, 213, 249),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onTap: (movie) async {
          // abre a tela de detalhes
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  MovieDetailsPage(movie: movie, mode: MoveDetailsMode.rental),
            ),
          );
        },
      ),
    );
  }
}
