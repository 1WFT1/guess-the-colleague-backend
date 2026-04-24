FROM openjdk:21-jdk-slim

WORKDIR /app

# Копируем файлы для сборки
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

# Делаем mvnw исполняемым
RUN chmod +x mvnw

# Скачиваем зависимости
RUN ./mvnw dependency:go-offline -B

# Копируем исходники
COPY src src

# Собираем JAR
RUN ./mvnw package -DskipTests

# Запускаем
EXPOSE 8080
CMD ["java", "-jar", "target/*.jar"]