// rental_movies_tab.dart: Aba para exibir filmes alugados pelo usuário
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/movies_grid.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

class RentalMoviesTab extends StatelessWidget {
  const RentalMoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>();

    if (store.isLoadingRental) {
      return const Center(child: CircularProgressIndicator());
    }

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

    return Padding(
      padding: const EdgeInsets.all(24),
      child: MoviesGrid(
        movies: store.rentalMovies,
        emptyText: "Você ainda não alugou nenhum filme.",
        footerBuilder: (_) => const Text(
          "Details",
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        onTap: (movie) async {
          final ok = await context.read<UserStore>().watchMovie(movie);
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
