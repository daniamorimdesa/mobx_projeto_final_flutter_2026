// user_store.dart
import 'package:flutter/material.dart';
import 'package:projeto_final_flutter_2026/src/external/datasources/movies_datasource.dart';
import 'package:projeto_final_flutter_2026/src/external/protos/packages.pb.dart';

class UserStore extends ChangeNotifier {
  var _user = User(); // variável privada para armazenar o usuário
  User get user => _user; // getter para acessar o usuário

  // instâncias dos datasources para reutilização
  final _moviesDs = MoviesDatasource();
 
  // váriavel para guardar a lista de filmes disponíveis
  List<Movie> availableMovies = [];

  // variável para guardar a lista de filmes alugados pelo usuário
  List<Movie> rentalMovies = [];

  // variáveis para indicar se uma operação está em andamento
  bool isLoadingAvailable = false;
  bool isLoadingRental = false;
  bool isRenting = false;
  bool isWatching = false;

  // variável para armazenar mensagens de erro
  String errorMessage = "";

  // método para salvar o user no estado e notificar UI
  void initUser(User user) {
    this._user = user;
    // limpar estado de filmes
    availableMovies = [];
    rentalMovies = [];
    errorMessage = "";
    // resetar flags de loading
    isLoadingAvailable = false;
    isLoadingRental = false;
    isRenting = false;
    isWatching = false;
    notifyListeners();
  }

  // método para buscar filmes disponíveis
  Future<void> getAvailableMovies() async {
    // ligar loading da aba "available"
    isLoadingAvailable = true;
    notifyListeners(); // notificar UI

    try {
      //chamar datasource para buscar filmes disponíveis
      final movies = await _moviesDs.getAvailableMovies();
      availableMovies = movies; // salvar filmes no estado
      errorMessage = ""; // limpar erro apenas em caso de sucesso
    } catch (e) {
      errorMessage = e.toString(); // salvar mensagem de erro
    } finally {
      // desligar loading da aba "available"
      isLoadingAvailable = false;
      notifyListeners(); // notificar UI
    }
  }

  // método para buscar filmes alugados pelo usuário
  Future<void> getRentalMovies() async {
    //verificar se o usuário está autenticado
    if (user.id == 0) {
      errorMessage = "Usuário não autenticado";
      notifyListeners();
      return;
    }

    // ligar loading da aba "rental"
    isLoadingRental = true;
    notifyListeners(); // notificar UI

    try {
      errorMessage = ""; // limpar erro antes de começar
      // chamar datasource para buscar filmes alugados pelo usuário
      final movies = await _moviesDs.getMoviesRentalByUser(user);
      rentalMovies = movies; // salvar filmes alugados no estado
    } catch (e) {
      errorMessage = e.toString(); // salvar mensagem de erro
    } finally {
      // desligar loading da aba "rental"
      isLoadingRental = false;
      notifyListeners(); // notificar UI
    }
  }

  // método para alugar um filme para o usuário
  Future<bool> rentalMovie(Movie movie) async {
    // verificar se o usuário está autenticado
    if (user.id == 0) {
      errorMessage = "Usuário não autenticado";
      notifyListeners();
      return false;
    }

    try {
      errorMessage = "";
      // checar se filme já está alugado
      if (rentalMovies.any((m) => m.id == movie.id)) {
        errorMessage = "Este filme já foi alugado";
        notifyListeners();
        return false;
      }

      // ligar loading de aluguel
      isRenting = true;
      notifyListeners();

      // chamar datasource para alugar o filme
      final success = await _moviesDs.rentalMovie(user.id, movie.id);

      // se deu certo, recarregar lista de filmes alugados e filmes disponíveis
      if (success) {
        await getRentalMovies();
        await getAvailableMovies();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      // desligar loading de aluguel
      isRenting = false;
      notifyListeners();
    }
  }

  // método para marcar um filme como assistido
  Future<bool> watchMovie(Movie movie) async {
    // verificar se o usuário está autenticado
    if (user.id == 0) {
      errorMessage = "Usuário não autenticado";
      notifyListeners();
      return false;
    }

    // ligar loading de "assistir"
    isWatching = true;
    notifyListeners();

    try {
      errorMessage = "";
      // chamar datasource para assistir o filme
      final success = await _moviesDs.watchMovie(user.id, movie.id);

      // se deu certo, recarregar lista de filmes alugados e filmes disponíveis
      if (success) {
        await getRentalMovies();
        await getAvailableMovies();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      // desligar loading de "assistir"
      isWatching = false;
      notifyListeners();
    }
  }

  // método para limpar listas quando fizer logout
  void clearDataOnLogout() {
    availableMovies = [];
    rentalMovies = [];
    isLoadingAvailable = false;
    isLoadingRental = false;
    isRenting = false;
    isWatching = false;
    errorMessage = "";
    notifyListeners();
  }
}
