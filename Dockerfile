# Usa a imagem oficial do OpenJDK 11
FROM openjdk:11

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo WAR para o container
COPY target/maven_lib-1.0.war /app/app.war

# Comando para rodar a aplicação
CMD ["java", "-jar", "/app/app.war"]
