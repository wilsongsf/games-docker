# Fase 1: PocketBase
FROM alpine:latest AS pocketbase

ARG PV_VERSION=0.10.1

# Instalação de dependências
RUN apk add --no-cache \
    unzip \
    openssh

# Baixar e descompactar PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.22.20/pocketbase_0.22.20_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

# Fase 2: Servidor Nginx
FROM nginx:alpine

# Diretório padrão do Nginx para HTML
WORKDIR /usr/share/nginx/html

# Copiar o arquivo HTML para o diretório do Nginx
COPY index.html /usr/share/nginx/html/

# Copiar PocketBase da fase anterior para o contêiner final
COPY --from=pocketbase /pb/pocketbase /pb/pocketbase

# Expor a porta 80 para o servidor web e 8080 para PocketBase
EXPOSE 80 8080

# Criar o diretório de dados do PocketBase e definir o volume
RUN mkdir -p /pb/pb_data  # Diretório onde o banco de dados será armazenado

# Script de inicialização para iniciar o PocketBase e o nginx
CMD ["/bin/sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:8080 & nginx -g 'daemon off;'"]
