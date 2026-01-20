// login_page.dart: Página de login com campos para nome de usuário e senha

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/home_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';

// widget da página de login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// estado da página de login
class _LoginPageState extends State<LoginPage> {
  // controladores para recuperar textos digitados
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // método para lidar com o login
  Future<void> _handleLogin() async {
    // chamar o método de login da store
    final success = await context.read<LoginStore>().login(
      _usernameController.text,
      _passwordController.text,
    );

    // se o login for bem-sucedido e o widget ainda estiver montado, navegar para a HomePage
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  // liberar os controladores quando o widget for descartado
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // função helper para criar InputDecoration consistente
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.55), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  // construir o formulário de login
  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Título "Entrar" dentro do painel
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Entrar',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Campo de texto para nome do usuário
        TextField(
          controller: _usernameController,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Username'),
        ),
        const SizedBox(height: 16),

        // Campo de texto para senha do usuário
        TextField(
          controller: _passwordController,
          obscureText: true, // oculta o texto para senha
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration('Password'),
        ),
        const SizedBox(height: 4),

        // Botão esqueceu senha
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // ação ao pressionar esqueceu senha
            },
            child: const Text(
              'Esqueceu a senha?',
              style: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Botão entrar em formato pílula
        Center(
          child: SizedBox(
            width: 260,
            height: 46,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6A1B9A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Exibe mensagem de erro se houver
        if (context.watch<LoginStore>().errorMessage.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.red.shade900.withOpacity(0.8),
              border: Border.all(color: Colors.red.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.watch<LoginStore>().errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // construir a interface da página de login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1) Background (repetindo)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                repeat: ImageRepeat.repeat, // repete em X e Y
                fit: BoxFit.none, // mantém tamanho original do tile
                alignment: Alignment.topLeft,
              ),
            ),
          ),

          // 2) Overlay escuro por cima
          Container(color: Colors.black.withOpacity(0.7)),

          // 3) Painel central
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 71, 20, 102),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: const Color.fromARGB(255, 47, 39, 53).withOpacity(0.8)),
                  ),
                  child: _buildLoginForm(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
