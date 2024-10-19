FROM maven:3.6.3-jdk-8-slim AS build
LABEL Muzaffar Khan "muzafferjoya@gmail.com"
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B -f pom.xml clean package -DskipTests

FROM openjdk:24-ea-18-jdk-oraclelinux8
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
