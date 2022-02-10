#FROM openjdk:8-jdk-alpine
# For Java 11, try this
# FROM adoptopenjdk/openjdk11:alpine-jre
# Refer to Maven build -> finalName
#ARG JAR_FILE=target/spring-boot-web.jar
# cd /opt/app
#WORKDIR /opt/app
# cp target/spring-boot-web.jar /opt/app/app.jar
#COPY ${JAR_FILE} app.jar
# java -jar /opt/app/app.jar
#ENTRYPOINT ["java","-jar","app.jar"]

FROM maven:3.6.3-jdk-8-slim AS build
LABEL Muzaffar Khan "muzafferjoya@gmail.com"
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B -f pom.xml clean package -DskipTests

FROM openjdk:8-jdk-slim
COPY --from=build /workspace/target/*.jar app.jar
#EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
