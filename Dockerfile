FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /
COPY pom.xml .
RUN mvn dependency:go-offline
COPY /src /src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
COPY --from=build target/*.jar application.jar
EXPOSE 8080
ENTRYPOINT ["java", "-Xmx256m", "-Dspring.profiles.active=prod", "-jar", "application.jar"]