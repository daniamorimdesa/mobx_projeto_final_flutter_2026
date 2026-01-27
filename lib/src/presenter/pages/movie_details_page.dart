// movie_details_page.dart : Página de detalhes do filme
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';

enum MoveDetailsMode {
  rental,
  watch,
} // modos de exibição da página de detalhes

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  final MoveDetailsMode mode;

  const MovieDetailsPage({
    super.key,
    required this.movie,
    this.mode = MoveDetailsMode.rental,
  }); // padrão de modo é rental

  @override
  Widget build(BuildContext context) {
    final store = context.watch<UserStore>();
    final coverBytes = Uint8List.fromList(movie.cover);

    const pageBg1 = Color.fromARGB(255, 30, 1, 46);
    const pageBg2 = Color.fromARGB(255, 0, 0, 0);

    return Scaffold(
      body: Container(
        // fundo com gradiente
        width: double.infinity, // largura total
        height: double.infinity, // altura total
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [pageBg1, pageBg2],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // determinar se está no modo rental
            final isRentalMode = mode == MoveDetailsMode.rental;

            // rótulo do botão principal
            final primaryLabel = isRentalMode ? "rental" : "watch";

            // estado de carregamento do botão principal
            final primaryLoading = isRentalMode
                ? store.isRenting
                : store.isWatching;

            Future<void> onPrimaryPressed() async {
              if (isRentalMode) {
                final ok = await context.read<UserStore>().rentalMovie(
                  movie,
                ); // alugar filme
                if (!context.mounted) return;

                if (ok) {
                  Navigator.pop(context); // voltar se sucesso
                } else if (context.read<UserStore>().errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    // mostrar erro se houver
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // claro elegante
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                      content: Text(
                        context.read<UserStore>().errorMessage,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 57, 4, 90), // roxo do seu tema
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              } else {
                final ok = await context.read<UserStore>().watchMovie(
                  movie,
                ); // assistir filme
                if (!context.mounted) return;

                if (ok) {
                  Navigator.pop(context); // voltar se sucesso
                } else if (context.read<UserStore>().errorMessage.isNotEmpty) {
                  // mostrar erro se houver
                  ScaffoldMessenger.of(context).showSnackBar(
                    // mostrar erro se houver
                    SnackBar(
                      content: Text(context.read<UserStore>().errorMessage),
                    ),
                  );
                }
              }
            }

            final w = constraints.maxWidth; // largura disponível

            // Escala responsiva baseada em 1600px (telas grandes)
            // Notebook: 1366px → s ≈ 0.85
            // Monitor Full HD: 1920px → s ≈ 1.2
            final s = (w / 1600).clamp(0.7, 1.15);

            // Valores responsivos
            final hPad = (90 * s).clamp(24.0, 110.0); // padding horizontal
            final vPad = (30 * s).clamp(20.0, 65.0); // padding vertical
            final gap = (34 * s).clamp(
              16.0,
              44.0,
            ); // espaçamento entre poster e infos
            final posterW = (500 * s).clamp(280.0, 680.0); // largura do poster
            final titleTop = (100 * s).clamp(
              20.0,
              130.0,
            ); // espaço acima do título
            final titleSize = (88 * s).clamp(
              36.0,
              105.0,
            ); // tamanho da fonte do título
            final titleLetter = (-5 * s).clamp(
              -7.0,
              -2.0,
            ); // espaçamento entre letras do título
            final bodySize = (16 * s).clamp(
              13.0,
              22.0,
            ); // tamanho da fonte do corpo do texto
            final infoLabelSize = (12 * s).clamp(
              11.0,
              17.0,
            ); // tamanho da fonte do rótulo das infos
            final infoValueSize = (16 * s).clamp(
              12.0,
              18.0,
            ); // tamanho da fonte do valor das infos
            final buttonW = (360 * s).clamp(200.0, 420.0); // largura dos botões
            final buttonH = (90 * s).clamp(52.0, 105.0); // altura dos botões
            final buttonFont = (19 * s).clamp(
              13.0,
              22.0,
            ); // tamanho da fonte dos botões
            final buttonGap = (28 * s).clamp(
              12.0,
              36.0,
            ); // espaçamento entre os botões
            final infoSpacing = (32 * s).clamp(
              20.0,
              42.0,
            ); // espaçamento entre linhas de info
            final posterVPad = (20 * s).clamp(
              16.0,
              50.0,
            ); // padding vertical do poster

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // poster
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: posterVPad),
                    child: SizedBox(
                      width: posterW,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: coverBytes.isNotEmpty
                            ? Image.memory(coverBytes, fit: BoxFit.contain)
                            : _fallback(),
                      ),
                    ),
                  ),

                  SizedBox(width: gap),

                  // infos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: titleTop),
                        Text(
                          movie.title.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: titleLetter,
                            height: 0.92,
                          ),
                        ),
                        SizedBox(height: (8 * s).clamp(6.0, 10.0)),

                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: (1000 * s).clamp(500.0, 1200.0),
                          ),
                          child: Text(
                            movie.sinopse,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: bodySize,
                              height: 1.5,
                            ),
                          ),
                        ),

                        SizedBox(height: infoSpacing),

                        _InfoLine(
                          label: "DIRECTOR",
                          value: movie.director,
                          labelSize: infoLabelSize,
                          valueSize: infoValueSize,
                        ),
                        SizedBox(height: (10 * s).clamp(6.0, 12.0)),
                        _InfoLine(
                          label: "YEAR",
                          value: movie.year,
                          labelSize: infoLabelSize,
                          valueSize: infoValueSize,
                        ),
                        SizedBox(height: (10 * s).clamp(6.0, 12.0)),
                        _InfoLine(
                          label: "PRICE",
                          value: "R\$ ${movie.value.toStringAsFixed(2)}",
                          labelSize: infoLabelSize,
                          valueSize: infoValueSize,
                        ),

                        SizedBox(height: (32 * s).clamp(24.0, 40.0)),

                        // botões
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: buttonW,
                              height: buttonH,
                              child: OutlinedButton(
                                onPressed: () {
                                  context.read<UserStore>().clearError();
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.35),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: Text(
                                  "cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: buttonFont),
                                ),
                              ),
                            ),
                            SizedBox(width: buttonGap),
                            SizedBox(
                              width: buttonW,
                              height: buttonH,
                              child: ElevatedButton(
                                onPressed: primaryLoading
                                    ? null
                                    : () => onPrimaryPressed(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF4B0377),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: primaryLoading
                                    ? SizedBox(
                                        height: (22 * s).clamp(18.0, 24.0),
                                        width: (22 * s).clamp(18.0, 24.0),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        primaryLabel,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: buttonFont),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _fallback() => Container(
    color: Colors.white.withOpacity(0.08),
    alignment: Alignment.center,
    child: const Icon(
      Icons.local_movies_outlined,
      size: 64,
      color: Color.fromARGB(255, 217, 177, 222),
    ),
  );
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;
  final double labelSize;
  final double valueSize;

  const _InfoLine({
    required this.label,
    required this.value,
    required this.labelSize,
    required this.valueSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color.fromARGB(255, 141, 89, 209),
            fontSize: labelSize,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            color: const Color.fromARGB(255, 228, 222, 222),
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }
}
