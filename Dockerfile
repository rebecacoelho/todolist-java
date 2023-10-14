FROM ubuntu:latest AS build

RUN app-get update
RUN app-get install openjdk-17-jdk -y

COPY . .

RUN app-get install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim
EXPOSE 8080

COPY --from=build /target/todolist-java-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]