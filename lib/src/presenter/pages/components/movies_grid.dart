// movies_grid.dart: componente para exibir uma grade de filmes com layout responsivo
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/movie_card.dart';

typedef MovieFooterBuilder = Widget Function(Movie movie);

class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;
  final String emptyText;
  final MovieFooterBuilder footerBuilder;
  final void Function(Movie movie)? onTap;

  const MoviesGrid({
    super.key,
    required this.movies,
    required this.emptyText,
    required this.footerBuilder,
    this.onTap,
  });

  int _calcColumns(double width) {
    if (width >= 1400) return 6;
    if (width >= 1100) return 5;
    if (width >= 900) return 4;
    if (width >= 700) return 3;
    if (width >= 520) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Text(
          emptyText,
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    return LayoutBuilder(
      builder: (_, constraints) {
        final cols = _calcColumns(constraints.maxWidth);

        return GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (_, index) {
            final movie = movies[index];
            return MovieCard(
              movie: movie,
              footer: footerBuilder(movie),
              onTap: onTap == null ? null : () => onTap!(movie),
            );
          },
        );
      },
    );
  }
}
