# Use a multi-stage build to create a lean final image.

# --- Build Stage ---
# Use a Maven and JDK image to build the application.
FROM maven:3.9.6-eclipse-temurin-21 AS builder

# Set the working directory inside the container.
WORKDIR /app

# Copy the Maven wrapper and pom.xml to leverage Docker layer caching.
# This way, dependencies are only re-downloaded if pom.xml changes.
COPY .mvn/ .mvn
COPY mvnw .

# Ensure the Maven wrapper is executable.
RUN chmod +x mvnw

COPY pom.xml .

# Download the dependencies without building the application.
RUN mvn -X install

# Copy the rest of the application source code.
COPY src ./src

# Package the application.
RUN mvn package

# --- Final Stage ---
# Use a slim JRE image for the final application container.
FROM eclipse-temurin:21-jre

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]