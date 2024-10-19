# Build stage
FROM maven:3.6.3-jdk-8-slim AS build
LABEL Muzaffar Khan "muzafferjoya@gmail.com"
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B -f pom.xml clean package -DskipTests

# Run stage
FROM openjdk:24-ea-18-jdk-oraclelinux8

# Update and install the required openssl-libs package using microdnf
RUN microdnf update -y && microdnf install -y openssl-libs-1:1.1.1k-5.0.1.ksplice1.el8_5

# Copy the jar from the build stage
COPY --from=build /workspace/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
