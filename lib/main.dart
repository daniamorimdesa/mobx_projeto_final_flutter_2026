// main.dart: ponto de entrada da aplicação Flutter
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/presenter/pages/login_page.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/login_store.dart';
import 'package:projeto_final_flutter_2026/src/presenter/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar tamanho mínimo da janela
  await windowManager.ensureInitialized();
  
  await windowManager.setMinimumSize(const Size(1050, 630)); // tamanho mínimo da janela
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStore()),
        ChangeNotifierProvider(create: (context) => LoginStore()),
      ],
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
