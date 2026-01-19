# API de Locadora de Filmes

Esta API foi desenvolvida com FastAPI e utiliza Protobuf para comunicação entre o backend e o frontend. Ela gerencia usuários, filmes, aluguéis e o status de visualização dos filmes.

## Rotas HTTP

### 1. Autenticação
- **POST /login**
  - Corpo: mensagem `User` (protobuf)
  - Retorno: mensagem `User` (protobuf) com o campo `id` preenchido
  - Status 200: login bem-sucedido
  - Status 401: credenciais inválidas

### 2. Listar filmes disponíveis
- **GET /available-movies**
  - Retorno: mensagem `Movies` (protobuf), lista de todos os filmes cadastrados

### 3. Listar filmes alugados por usuário
- **POST /movies-rental-by-user**
  - Corpo: mensagem `User` (protobuf) com o campo `id` preenchido
  - Retorno: mensagem `Movies` (protobuf), lista de filmes alugados pelo usuário

### 4. Alugar filme
- **POST /rental-movie**
  - Corpo: mensagem `Rental` (protobuf) com `user_id` e `movie_id`
  - Retorno: status 200

### 5. Marcar filme como assistido
- **POST /watch-movie**
  - Corpo: mensagem `Rental` (protobuf) com `user_id` e `movie_id`
  - Retorno: status 200

## Estruturas Protobuf

### User
- `id`: int32
- `username`: string
- `password`: string

### Movie
- `id`: int32
- `title`: string
- `cover`: bytes (imagem)
- `value`: float (valor do aluguel)
- `year`: string
- `director`: string
- `sinopse`: string

### Movies
- `movies`: lista de `Movie`

### Rental
- `user_id`: int32
- `movie_id`: int32

## Observações
- Todos os endpoints POST esperam o corpo da requisição em formato binário (protobuf).
- As respostas também são enviadas em formato binário (protobuf).
- Para consumir a API no frontend, é necessário serializar/deserializar as mensagens usando as definições do arquivo `packages.proto`.

## Exemplo de fluxo
1. Usuário faz login enviando `User` (username, password) → recebe `User` com `id`.
2. Busca filmes disponíveis via GET `/available-movies`.
3. Aluga um filme via POST `/rental-movie` enviando `Rental` (`user_id`, `movie_id`).
4. Lista filmes alugados via POST `/movies-rental-by-user`.
5. Marca filme como assistido via POST `/watch-movie`.

Consulte o arquivo `packages.proto` para detalhes das mensagens.
