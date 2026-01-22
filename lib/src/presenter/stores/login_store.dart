// login_store.dart: gerencia o estado de login do usuário usando ChangeNotifier
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/external/datasources/user_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

class LoginStore extends ChangeNotifier {
  var _user = User(); // variável privada para armazenar o usuário
  User get user => _user; // getter para acessar o usuário

  String errorMessage = ""; // variável para armazenar mensagens de erro

  // método login para realizar o login do usuário
  Future<bool> login(String username, String password) async {
    User user = User()
      ..username = username
      ..password = password;
    try {
      final userResponse = await UserDatasource().login(
        user,
      ); // busca informações do usuário
      _user = userResponse;
      errorMessage =
          ""; // limpa a mensagem de erro quando o login é bem-sucedido
      notifyListeners();
      return true; // retorna verdadeiro se o login for bem-sucedido
    } catch (e) {
      debugPrint("Login error: $e");
      final msg = e.toString().toLowerCase();
      if (msg.contains("credenciais inválidas") || msg.contains("401")) {
        errorMessage = "Usuário ou senha inválidos. Tente novamente.";
      } else if (msg.contains("conectar ao servidor") ||
          msg.contains("socket")) {
        errorMessage =
            "Não foi possível conectar ao servidor. Verifique se a API está rodando.";
      } else {
        errorMessage = "Ocorreu um erro ao tentar entrar. Tente novamente.";
      }
      notifyListeners(); // notifica para atualizar a UI
      return false; // retorna falso se ocorrer um erro
    }
  }

  // método logout para limpar o estado do usuário
  void logout() {
    _user = User(); // reseta o usuário
    errorMessage = ""; // limpa mensagens de erro
    notifyListeners();
  }

  // método para limpar a mensagem de erro
  void clearError() {
    errorMessage = "";
    notifyListeners();
  }
}
