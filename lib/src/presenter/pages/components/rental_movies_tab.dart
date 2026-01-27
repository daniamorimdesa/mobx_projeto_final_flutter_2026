// rental_movies_tab.dart: Aba para exibir filmes alugados pelo usuário
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/movies_grid.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/movie_details_page.dart';

class RentalMoviesTab extends StatelessWidget {
  const RentalMoviesTab({super.key});

  // construir a interface da aba de filmes alugados
  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>(); // observar mudanças na UserStore

    if (store.isLoadingRental) {
      return const Center(child: CircularProgressIndicator());
    }

    // se houver erro, mostrar mensagem de erro
    if (store.errorMessage.isNotEmpty && store.rentalMovies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            store.errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // mostrar grade de filmes alugados
    return Padding(
      padding: const EdgeInsets.all(24),
      child: MoviesGrid(
        movies: store.rentalMovies, // lista de filmes alugados
        emptyText: "Você ainda não alugou nenhum filme.",
        footerBuilder: (_) => const Text(
          "Details",
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        onTap: (movie) async {
          // abre a página de detalhes do filme
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  MovieDetailsPage(movie: movie, mode: MoveDetailsMode.watch),
            ),
          );
        },
      ),
    );
  }
}
