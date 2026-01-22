// available_movies_tab.dart: Aba para exibir filmes disponíveis para aluguel
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/movies_grid.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

class AvailableMoviesTab extends StatelessWidget {
  const AvailableMoviesTab({super.key});

  // construir a interface da aba de filmes disponíveis
  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>(); // observar mudanças na UserStore

    if (store.isLoadingAvailable) {
      return const Center(child: CircularProgressIndicator()); // mostrar loading enquanto carrega
    }

     // mostrar mensagem de erro, se houver
    if (store.errorMessage.isNotEmpty) {
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

    return Padding( // padding ao redor do grid de filmes
      padding: const EdgeInsets.all(24),
      child: MoviesGrid(
        movies: store.availableMovies,
        emptyText: "Nenhum filme disponível no momento.",
        footerBuilder: (movie) => Text(
          "R\$ ${movie.value.toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white, fontSize: 22),
          textAlign: TextAlign.center,
        ),
        onTap: (movie) async {
          final ok = await context.read<UserStore>().rentalMovie(movie);
          if (!context.mounted) return;

          if (!ok && context.read<UserStore>().errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.read<UserStore>().errorMessage)),
            );
          }
        },
      ),
    );
  }
}
