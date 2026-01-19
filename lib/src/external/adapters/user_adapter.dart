// user_adapt.dart: métodos estáticos de serialização e desserialização de mensagens protobuf

import "dart:typed_data";
import "package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart";

// classe responsável por adaptar e decodificar mensagens protobuf relacionadas ao usuário
class UserAdapter {
  // método estático que decodifica uma mensagem protobuf em instância de User - desserialização(Uint8List -> User)
  static User decodeProto(Uint8List encodedUser) {
    try {
      final user = User.fromBuffer(encodedUser); // desserialização
      return user;
    } catch (e) {
      throw Exception("Erro ao decodificar o proto: $e");
    }
  }

  // método estático que codifica uma instância de User em uma mensagem protobuf - serialização(User -> Uint8list)
  static Uint8List encodeProto(User user) {
    final encodedUser = user.writeToBuffer(); // serialização
    return encodedUser;
  }
}
