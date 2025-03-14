# Usa uma imagem com Maven e Java 11 já instalados
FROM maven:3.8.5-openjdk-11

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o código do projeto para dentro do container
COPY . .

# Executa o build do projeto
RUN mvn clean package

# Expõe a porta usada pelo Jetty
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["mvn", "jetty:run"]
