Projeto CRUD de Jogos com PocketBase e Docker
Este projeto implementa um sistema CRUD (Criar, Ler, Atualizar, Excluir) para jogos usando PocketBase como backend e um simples front-end HTML para interagir com o banco de dados. 
O servidor web utiliza Nginx para servir o HTML e o PocketBase para gerenciar a API e o banco de dados. Todo o sistema é executado via Docker, facilitando a instalação e execução.

Estrutura do Projeto
index.html: Interface web para criar, atualizar, excluir e visualizar jogos.
Dockerfile: Configuração para criar a imagem Docker com PocketBase e Nginx.
init.sh: Script de inicialização que configura o PocketBase e cria a tabela de jogos.


Funcionalidades
O sistema permite que o usuário:
Crie um novo jogo fornecendo nome, descrição e data de lançamento.
Atualize os dados de um jogo existente.
Exclua um jogo.
Liste todos os jogos cadastrados.
A comunicação com o backend é feita por meio da API do PocketBase, que gerencia a coleção "game".

Como executar o projeto
Pré-requisitos
Certifique-se de que o Docker esteja instalado na sua máquina.

Passo a Passo
Clonar o repositório:

Se o código estiver hospedado em um repositório Git, você pode clonar usando:
bash
git clone https://github.com/wilsongsf/games-docker
cd games-docker

Construir a imagem Docker:
Para construir a imagem do projeto, execute o seguinte comando na raiz do projeto:
bash
docker build -t my-app .

Executar o contêiner:
Após a construção da imagem, inicie o contêiner com:
bash
docker run -it --rm -p 8080:8080 -p 80:80 -v pocketbase_data:/pb/pb_data my-app
Esse comando:
Mapeia a porta 8080 para o PocketBase.
Mapeia a porta 80 para o servidor Nginx, que serve o index.html.
Cria um volume chamado pocketbase_data para persistir os dados do banco de dados.
Acessar a aplicação:

Para acessar a interface do PocketBase (Admin UI), vá para http://localhost:8080/_/.
A interface de usuário para CRUD de jogos estará disponível em http://localhost.
Observações importantes
Durante o desenvolvimento, tive dificuldade em criar automaticamente um perfil de administrador padrão diretamente na criação do contêiner. Como resultado, um administrador 
deverá ser criado manualmente após iniciar o PocketBase.

Para criar um administrador manualmente, siga estas etapas:

Acesse a interface de administração do PocketBase em http://localhost:8080/_/.
Na tela de login, clique em "Criar Conta" para cadastrar um administrador.
Preencha o formulário com um e-mail e senha.
Após o login, crie manualmente as coleções necessárias, se o script não tiver sido executado corretamente.
Configuração manual do banco de dados
Caso a tabela "game" não seja criada automaticamente, você pode criá-la manualmente via PocketBase Admin UI:

Faça login como administrador na interface de administração.
Vá para Collections e crie uma nova coleção chamada game.
Adicione os seguintes campos à coleção:
nome (Tipo: Texto, Obrigatório: Sim)
descricao (Tipo: Texto, Obrigatório: Sim)
lancamento (Tipo: Datetime, Obrigatório: Sim)
Salve a coleção.


Rotas da API do PocketBase
O PocketBase disponibiliza uma API RESTful para interagir com as coleções. No caso da coleção game, você pode usar as seguintes rotas:

Listar jogos (GET)
bash
GET http://localhost:8080/api/collections/game/records
Este endpoint retorna a lista de todos os jogos cadastrados.

Criar jogo (POST)
bash
POST http://localhost:8080/api/collections/game/records
Exemplo de payload JSON:

json
{
  "nome": "Nome do Jogo",
  "descricao": "Descrição do Jogo",
  "lancamento": "2023-09-12T10:00:00Z"
}
Atualizar jogo (PUT)
bash
PUT http://localhost:8080/api/collections/game/records/{id}
Substitua {id} pelo ID do jogo a ser atualizado.

Exemplo de payload JSON:

json
{
  "nome": "Novo Nome do Jogo",
  "descricao": "Nova Descrição do Jogo",
  "lancamento": "2023-09-15T12:00:00Z"
}
Excluir jogo (DELETE)
bash
DELETE http://localhost:8080/api/collections/game/records/{id}
Substitua {id} pelo ID do jogo a ser excluído.

Conclusão
Este projeto é uma aplicação simples de CRUD para jogos usando PocketBase e Docker. Caso enfrente problemas durante a execução ou queira expandir o projeto, 
não hesite em modificar o código ou abrir uma issue no repositório para obter suporte.