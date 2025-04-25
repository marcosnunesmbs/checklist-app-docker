# Estágio de build
FROM node:22-alpine AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de configuração e package.json
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante dos arquivos do projeto
COPY . .

# Compila o aplicativo para produção
RUN npm run build

# Estágio de produção
FROM nginx:stable-alpine AS production

# Copia os arquivos de build para o diretório do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Criar arquivo de configuração customizado para o Nginx
RUN echo 'server {\n\
    listen 3000;\n\
    server_name localhost;\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html index.htm;\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

# Expõe a porta 3000 em vez da porta 80
EXPOSE 3000

# Comando para iniciar o Nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]