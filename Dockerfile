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

# Запускаем приложение, передавая переменные окружения
ENTRYPOINT ["java", "-jar", "-Dserver.port=${PORT}", "-DDB_HOST=${DB_HOST}", "-DDB_PORT=${DB_PORT}", "-DDB_NAME=${DB_NAME}", "-DDB_USER=${DB_USER}", "-DDB_PASSWORD=${DB_PASSWORD}", "target/guesscolleague-0.0.1-SNAPSHOT.jar"]
