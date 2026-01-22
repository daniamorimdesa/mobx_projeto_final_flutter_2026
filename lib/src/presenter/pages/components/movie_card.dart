// movie_card.dart: componente para exibir um cartão de filme
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie; // filme a ser exibido
  final Widget footer; // widget de rodapé personalizado
  final VoidCallback? onTap; // callback para toque no cartão

  const MovieCard({
    super.key,
    required this.movie,
    required this.footer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final coverBytes = movie.coverImage; // obtém os bytes da imagem de capa

    return InkWell(
      // efeito de toque
      onTap: onTap, // chama o callback se fornecido
      borderRadius: BorderRadius.circular(
        5,
      ), // bordas arredondadas para o efeito de toque
      child: Container(
        padding: const EdgeInsets.all(14), // padding interno
        decoration: BoxDecoration(
          // decoração do cartão
          color: const Color.fromARGB(255, 0, 0, 0), // fundo do cartão
          borderRadius: BorderRadius.circular(5), // bordas arredondadas
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ), // borda do cartão
        ),
        child: Column(
          children: [
            Expanded(
              // expande para preencher o espaço disponível
              child: ClipRRect(
                // recorta o conteúdo com bordas arredondadas
                borderRadius: BorderRadius.circular(5), // bordas arredondadas
                child: coverBytes.isNotEmpty
                    ? Image.memory(
                        coverBytes,
                        fit: BoxFit.cover, // cobre todo o espaço disponível
                        width: double.infinity, // largura máxima
                        // evita "quebrar" se os bytes estiverem ruins
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.white.withOpacity(
                            0.06,
                          ), // fundo do contêiner do filme
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.local_movies_outlined, // ícone de filme
                            color: Color.fromARGB(255, 217, 177, 222),
                            size: 36, // tamanho do ícone
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white.withOpacity(0.06),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.local_movies_outlined,
                          color: Color.fromARGB(255, 217, 177, 222),
                          size: 36,
                        ),
                      ),
            ),
            const SizedBox(height: 10), // espaçamento entre a imagem e o rodapé
            footer,
          ],
        ),
      ),
    );
  }
}