# Use an official Maven image as the base image
FROM  maven:3.9-eclipse-temurin-17-focal@sha256:bc80703c075c7f242eaf2dcef8cf8c075915c354323621134f342c406f50cb26
# maven:3.8.4-openjdk-11-slim AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests
# Use an official OpenJDK image as the base image
FROM openjdk:17-jre-slim
# Set the working directory in the container
WORKDIR /app
# Copy the built JAR file from the previous stage to the container
COPY - from=build /app/target/student-services-0.0.1-SNAPSHOT.jar .
# Set the command to run the application
CMD ["java", "-jar", "student-services-0.0.1-SNAPSHOT.jar"]
