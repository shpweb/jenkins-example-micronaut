FROM eclipse-temurin:11-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw package

FROM eclipse-temurin:11-alpine
COPY --from=build /workspace/app/target/demo-0.1.jar /app/
ENTRYPOINT ["java","-Dmicronaut.server.port=${PORT}","-jar","/app/demo-0.1.jar"]