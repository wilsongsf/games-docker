#!/bin/sh

# Iniciar o PocketBase em segundo plano
/pb/pocketbase serve --http=0.0.0.0:8080 &

# Esperar até que o PocketBase esteja disponível
until $(curl --output /dev/null --silent --head --fail http://localhost:8080/_); do
    printf '.'
    sleep 5
done

echo "PocketBase is up!"

# Criar a coleção 'game' usando a API do PocketBase
curl -X POST http://localhost:8080/api/collections -H "Content-Type: application/json" -d '{
    "name": "game",
    "schema": [
        {"name": "nome", "type": "text", "required": true},
        {"name": "descricao", "type": "text", "required": true},
        {"name": "lancamento", "type": "datetime", "required": true}
    ]
}'

# Manter o servidor PocketBase em execução em primeiro plano
wait
