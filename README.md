# Projeto Final Flutter 2026 - Versão MobX 🎬

Aplicação Flutter de locadora de filmes desenvolvida para estudar e aplicar conceitos fundamentais de arquitetura, gerenciamento de estado e comunicação com backend.

## 📚 Conceitos Explorados

### 1. Protocol Buffers (Protobuf)
- Serialização e desserialização de dados binários
- Definição de schemas de mensagens (`.proto`)
- Integração Flutter + Backend Python (FastAPI)
- Comunicação eficiente entre cliente e servidor

### 2. Gerenciamento de Estado com MobX
- **Observables** - Estados reativos com `@observable`
- **Actions** - Métodos que modificam o estado com `@action`
- **Computed** - Valores derivados com `@computed`
- **Reactions** - Reatividade automática na UI com `Observer`
- **Code Generation** - Geração automática de código reativo com `build_runner`

### 3. Arquitetura em Camadas

#### **PROTO** - Estrutura de Dados
Definição dos modelos de dados usando Protocol Buffers:
- `User` → Dados do usuário vindos do backend (login)
- `Movie` → Detalhes de um filme vindo do backend
- `Movies` → Lista de filmes vindos do backend
- `Rental` → Dados de aluguel enviados para o backend

**Localização:** `lib/src/external/protos/`

#### **ADAPTER** - Interpretação de Resposta
Classes responsáveis por converter entre formatos:
- Serialização: `Objeto Dart` → `Uint8List` (binário)
- Desserialização: `Uint8List` → `Objeto Dart`
- Métodos estáticos `encodeProto()` e `decodeProto()`

**Localização:** `lib/src/external/adapters/`
- `user_adapter.dart`
- `movie_adapter.dart`

#### **DATASOURCE** - Transporte HTTP
Camada de comunicação com a API:
- Requisições HTTP usando o pacote `http`
- Envio de dados binários (protobuf)
- Tratamento de respostas e erros HTTP
- Configuração de headers e endpoints

**Localização:** `lib/src/external/datasources/`
- `user_datasource.dart` - Login e autenticação
- `movies_datasource.dart` - Operações com filmes (listar, alugar, assistir)

#### **STORE** - Lógica de Negócio e Estado
Gerenciamento de estado usando **MobX**:
- Estados observáveis com `@observable` (ex: `isLoading`, `errorMessage`, `user`)
- Ações que modificam estado com `@action` (ex: `login()`, `getAvailableMovies()`)
- Valores computados com `@computed` (ex: `isAuthenticated`, `hasError`)
- Listas reativas com `ObservableList<Movie>`
- Notificação automática de mudanças para a UI
- Controle de carregamento e erros

**Localização:** `lib/src/presenter/stores/`
- `login_store.dart` + `login_store.g.dart` - Estado e lógica de login
- `user_store.dart` + `user_store.g.dart` - Estado do usuário, filmes disponíveis e alugados

**Exemplo de Store MobX:**
```dart
class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  bool isLoadingAvailable = false;
  
  @observable
  ObservableList<Movie> availableMovies = ObservableList<Movie>();
  
  @computed
  bool get hasMovies => availableMovies.isNotEmpty;
  
  @action
  Future<void> getAvailableMovies() async {
    isLoadingAvailable = true;
    // ... lógica
    isLoadingAvailable = false;
  }
}
```

#### **UI** - Apresentação
Interface do usuário e componentes visuais:
- Páginas principais da aplicação
- Componentes reutilizáveis
- Consumo dos Stores via `Provider` (injeção) e `context.read<Store>()`
- Reatividade automática com widget `Observer` do MobX
- Atualizações eficientes e granulares da tela

**Localização:** `lib/src/presenter/pages/`
- `login_page.dart` - Tela de autenticação
- `home_page.dart` - Tela principal com filmes
- `movie_details_page.dart` - Detalhes do filme
- `components/` - Componentes reutilizáveis

**Exemplo de uso do Observer:**
```dart
Widget build(BuildContext context) {
  final store = context.read<UserStore>();
  
  return Observer(
    builder: (_) {
      if (store.isLoadingAvailable) {
        return CircularProgressIndicator();
      }
      return MoviesGrid(movies: store.availableMovies.toList());
    },
  );
}
```

### 4. Recursos Flutter

#### Window Manager
- Configuração de tamanho mínimo de janela desktop
- Controle de características da janela

#### Material Design
- Uso de widgets Material (Scaffold, AppBar, Card, etc.)
- Temas e estilos consistentes

#### Navigation
- Navegação entre telas
- Passagem de dados entre rotas

#### HTTP Client
- Comunicação assíncrona com API REST
- Tratamento de Future e async/await

## 🏗️ Ordem de Criação e Desenvolvimento

### Fase 1: Estruturação Inicial
1. **Definição dos Protobuf** (`.proto`)
   - Criação do arquivo `packages.proto`
   - Definição das mensagens: User, Movie, Movies, Rental
   - Geração dos arquivos Dart usando `protoc`

2. **Criação dos Adapters**
   - `UserAdapter` - Conversão User ↔ Binário
   - `MovieAdapter` - Conversão Movie/Movies ↔ Binário

### Fase 2: Camada de Dados
3. **Implementação dos Datasources**
   - `UserDatasource` - Endpoint de login
   - `MoviesDatasource` - Endpoints de filmes (listar, alugar, assistir)
   - Configuração do cliente HTTP

### Fase 3: Lógica e Estado
4. **Criação dos Stores com MobX**
   - `LoginStore` - Gerenciamento de autenticação com `@observable` e `@action`
   - `UserStore` - Gerenciamento de usuário logado e filmes
   - Definição de observables, actions e computed properties
   - Geração de código com `build_runner`

### Fase 4: Interface
5. **Desenvolvimento das Páginas**
   - `LoginPage` - Tela inicial de login
   - `HomePage` - Dashboard principal
   - `MovieDetailsPage` - Visualização detalhada

6. **Componentes Reutilizáveis**
   - `MovieCard` - Card de filme
   - `MoviesGrid` - Grid de filmes
   - `AvailableMoviesTab` - Aba de filmes disponíveis
   - `RentalMoviesTab` - Aba de filmes alugados
   - `ErrorBox` - Componente de exibição de erros

### Fase 5: Integração e Configuração
7. **Configuração do Provider e MobX**
   - Setup do `MultiProvider` no `main.dart`
   - Injeção de dependências dos Stores MobX
   - Uso de `Observer` widgets para reatividade
   - Execução do `build_runner` para gerar arquivos `.g.dart`

8. **Configuração Desktop**
   - Integração do `window_manager`
   - Configuração de tamanho mínimo da janela

## 🛠️ Tecnologias Utilizadas

### Frontend (Flutter)
- **Flutter SDK**: ^3.10.4
- **mobx**: ^2.3.0 - Gerenciamento de estado reativo
- **flutter_mobx**: ^2.2.0 - Widgets para integração MobX + Flutter
- **provider**: ^6.1.5+1 - Injeção de dependências
- **http**: ^1.5.0 - Cliente HTTP
- **protobuf**: ^4.2.0 - Protocol Buffers
- **fixnum**: ^1.1.1 - Números fixos para protobuf
- **window_manager**: ^0.3.8 - Controle de janela desktop

### DevDependencies
- **build_runner**: ^2.4.11 - Execução de geradores de código
- **mobx_codegen**: ^2.6.1 - Gerador de código MobX

### Backend (Python/FastAPI)
- **FastAPI** - Framework web
- **Protobuf** - Serialização de dados
- API REST documentada

## 📦 Estrutura do Projeto

```
lib/
├── main.dart                    # Entry point da aplicação
├── src/
    ├── external/                # Camada externa (dados)
    │   ├── protos/             # Definições Protocol Buffers
    │   │   ├── packages.proto
    │   │   └── packages.pb.dart
    │   ├── adapters/           # Conversão protobuf ↔ Dart
    │   │   ├── user_adapter.dart
    │   │   └── movie_adapter.dart
    │   └── datasources/        # Comunicação HTTP
    │       ├── user_datasource.dart
    │       └── movies_datasource.dart
    └── presenter/              # Camada de apresentação
        ├── stores/             # Estado e lógica (MobX)
        │   ├── login_store.dart
        │   ├── login_store.g.dart      # Gerado pelo build_runner
        │   ├── user_store.dart
        │   └── user_store.g.dart       # Gerado pelo build_runner
        └── pages/              # Interface
            ├── login_page.dart
            ├── home_page.dart
            ├── movie_details_page.dart
            └── components/     # Componentes reutilizáveis
```

## 🚀 Como Executar

### Backend (API)
1. Navegue até `api/api/`
2. Instale as dependências: `poetry install`
3. Execute a API: `poetry run uvicorn main:app --reload`
4. API disponível em: `http://127.0.0.1:8000`

### Frontend (Flutter)
1. Certifique-se de ter o Flutter instalado
2. Instale as dependências: `flutter pub get`
3. Gere os arquivos MobX: `dart run build_runner build --delete-conflicting-outputs`
4. Execute a aplicação: `flutter run -d windows`

**Nota:** Durante o desenvolvimento, você pode usar o watch mode para gerar código automaticamente:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 📝 Funcionalidades

- ✅ Login de usuário com autenticação
- ✅ Listagem de filmes disponíveis
- ✅ Visualização de detalhes do filme
- ✅ Aluguel de filmes
- ✅ Listagem de filmes alugados
- ✅ Marcar filme como assistido
- ✅ Tratamento de erros e estados de carregamento
- ✅ Interface responsiva

## 🎯 Aprendizados Principais

1. **Arquitetura Limpa**: Separação clara de responsabilidades em camadas
2. **Protocol Buffers**: Comunicação eficiente e tipada entre frontend e backend
3. **State Management com MobX**: 
   - Reatividade automática e eficiente
   - Decorators para simplificar código (`@observable`, `@action`, `@computed`)
   - Separação clara entre estado e lógica
   - Code generation para boilerplate
4. **Assincronicidade**: Tratamento de operações assíncronas com Future/async/await
5. **Componentização**: Criação de componentes reutilizáveis e modulares
6. **Desktop Flutter**: Configurações específicas para aplicações desktop
7. **Build Runner**: Geração automática de código com ferramentas de build

---

**Desenvolvido como projeto de estudo de Flutter - 2026**
