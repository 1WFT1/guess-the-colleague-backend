# Используем официальный образ Eclipse Temurin с JDK 21
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Копируем Maven wrapper и POM
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

# Даем права на выполнение и качаем зависимости
RUN chmod +x mvnw && ./mvnw dependency:go-offline

# Копируем исходный код и собираем JAR
COPY src src
RUN ./mvnw package -DskipTests

# Указываем порт
EXPOSE 8080

# Запускаем приложение (переменные окружения будут подхвачены автоматически)
ENTRYPOINT ["java", "-jar", "-Dserver.port=${PORT}", "target/guesscolleague-0.0.1-SNAPSHOT.jar"]
