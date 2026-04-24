FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

COPY src src
RUN ./mvnw package -DskipTests

EXPOSE 8080
CMD ["sh", "-c", "java -jar -Dserver.port=${PORT:8080} target/guesscolleague-*.jar"]
