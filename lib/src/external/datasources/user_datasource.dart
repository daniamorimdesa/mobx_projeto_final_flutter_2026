// user_datasource.dart: fonte de dados externa para operações relacionadas ao User via API http

import 'package:http/http.dart' as http;
import 'package:projeto_final_flutter_2026/src/external/adapters/user_adapter.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

class UserDatasource {
  final client = http.Client(); // cliente http para fazer requisições

  // método para fazer login do usuário via POST
  Future<User> login(User usercredentials) async {
    try {
      // requisição POST
      final response = await client.post(
        Uri.parse('http://127.0.0.1:8000/login'),
        body: UserAdapter.encodeProto(
          usercredentials,
        ), // serializa as credenciais do usuário
        headers: {
          'Content-Type': 'application/octet-stream',
        }, // cabeçalho indicando o tipo de conteúdo(bytes)
      );
      if (response.statusCode == 200) {
        return UserAdapter.decodeProto(
          response.bodyBytes,
        ); // desserializa a resposta
      } else if (response.statusCode == 401) {
        throw Exception("Credenciais inválidas"); // erro de autenticação
      } else {
        throw Exception(
          "Servidor não conseguiu processar a requisição (status ${response.statusCode})",
        ); // erro de status
      }
    } on http.ClientException catch (e) {
      throw Exception(
        "Não foi possível conectar ao servidor: $e",
      ); // erro de conexão
    } catch (e) {
      throw Exception("Erro ao fazer login: $e"); // erro genérico
    }
  }
}

//   // méteodo showInformations: busca informações do usuário via GET
//   Future<User> showInformations() async {
//     try {
//       // requisição GET
//       final response = await client.get(
//         Uri.parse('http://127.0.0.1:8000/show-informations'),
//       ); // rota da API

//       // verifica o status da resposta
//       if (response.statusCode == 200) {
//         return UserAdapter.decodeProto(
//           response.bodyBytes,
//         ); // desserializa a resposta
//       } else {
//         throw Exception("Servidor não conseguiu processar a requisição (status ${response.statusCode})"); // erro de status
//       }
//     } on http.ClientException catch (e) {
//       throw Exception("Não foi possível conectar ao servidor: $e"); // erro de conexão
//     } catch (e) {
//       throw Exception("Erro ao buscar informações do usuário: $e"); // erro genérico
//     }
//   }

//   // método updateInformations: atualiza informações do usuário via POST
//   Future<bool> updateInformations(User user) async {
//     try {
//       // requisição POST
//       final response = await client.post(
//         Uri.parse('http://127.0.0.1:8000/update-informations'), // rota da API
//         body: UserAdapter.encodeProto(user),                    // serializa o usuário
//         headers: {'Content-Type': 'application/octet-stream'},  // cabeçalho indicando o tipo de conteúdo(bytes)
//       );
//       return response.statusCode == 200; // retorna true se a atualização foi bem-sucedida
//     } on http.ClientException catch (e) {
//       throw Exception("Não foi possível conectar ao servidor: $e");
//     } catch (e) {
//       throw Exception("Erro ao atualizar informações do usuário: $e");
//     }
//   }
// }
