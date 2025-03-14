# Usa uma imagem base com Java e Maven
FROM maven:3.8.1-openjdk-11 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Compila o projeto
RUN mvn clean package

# Usa uma imagem leve para rodar o WAR
FROM openjdk:11-jdk

WORKDIR /app

# Copia o arquivo WAR gerado
COPY --from=build /app/target/maven_lib-1.0.war app.war

# Expõe a porta 8080
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["java", "-jar", "app.war"]
