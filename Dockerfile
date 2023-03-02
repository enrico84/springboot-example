#FROM openjdk:17-jdk-slim
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar

#ENTRYPOINT ["java","-jar","/app.jar"]
FROM maven:3.8.4-openjdk-17-slim AS build

LABEL mantainer="Enrico Capone <enrico8484@gmail.com>"

COPY src /usr/src/springboot-example/src
COPY pom.xml /usr/src/springboot-example
RUN mvn -f /usr/src/springboot-example/pom.xml clean package

FROM openjdk:17-jdk-slim
COPY --from=build /usr/src/springboot-example/target/springboot-example-0.0.1-SNAPSHOT.jar /usr/springboot-example/springboot-example-0.0.1-SNAPSHOT.jar

EXPOSE 8761
ENTRYPOINT ["java", "-jar", "/usr/springboot-example/springboot-example-0.0.1-SNAPSHOT.jar"]