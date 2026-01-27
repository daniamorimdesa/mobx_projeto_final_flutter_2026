// HomePage com TabBar: available movies e movies rental by user
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/available_movies_tab.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/components/rental_movies_tab.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';

// HomePage - Página que exibe uma TabBar com 2 abas: Available Movies e Movies Rental by User
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final userStore = context.read<UserStore>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userStore.getAvailableMovies();
      userStore.getRentalMovies();
    },);
    super.initState();
  }

  // método para Limpar o estado do usuário (logout)
  void _handleLogout(BuildContext context) {
    context.read<LoginStore>().logout();
    context.read<UserStore>().clearDataOnLogout();

    // Navegar de volta para o login substituindo a página atual
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // construir a interface da HomePage
  @override
  Widget build(BuildContext context) {
    final username = context
        .watch<LoginStore>()
        .user
        .username; // obter nome do usuário logado

    return DefaultTabController(
      length: 2, // número de abas
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: const Color.fromARGB(255, 23, 4, 65), // cor roxa
          foregroundColor: const Color.fromARGB(
            255,
            204,
            187,
            248,
          ), // cor do texto e ícones
          elevation: 0,
          titleSpacing: 16,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color.fromARGB(255, 249, 247, 252),
                  child: Icon(
                    Icons.person_rounded,
                    color: Color.fromARGB(255, 204, 187, 248),
                  ),
                ),
                const SizedBox(width: 8), // espaçamento entre o avatar e o nome
                Expanded(
                  child: Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 204, 187, 248),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ), // nome do usuário logado
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IconButton(
                iconSize: 22,
                icon: const Icon(Icons.logout_rounded),
                onPressed: () => _handleLogout(context),
                tooltip: 'Logout',
              ),
            ),
            const SizedBox(
              width: 16,
            ), // espaçamento à direita do ícone de logout
          ],

          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: TabBar(
              indicatorColor:
                  Colors.white, // cor do indicador da aba selecionada
              indicatorWeight: 3, // espessura do indicador
              labelColor: Colors.white, // cor do texto da aba selecionada
              unselectedLabelColor: Color.fromARGB(
                179,
                255,
                255,
                255,
              ), // cor do texto não selecionado
              labelStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ), // estilo do texto da aba selecionada
              tabs: [
                Tab(icon: Icon(Icons.movie_filter), text: 'Available movies'),
                Tab(
                  icon: Icon(Icons.recent_actors_outlined),
                  text: 'Movies rental',
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 21, 1, 32), // cor de fundo roxa
          child: const TabBarView(
            children: [AvailableMoviesTab(), RentalMoviesTab()],
          ),
        ),
      ),
    );
  }
}
