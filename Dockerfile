# Use a multi-stage build to create a lean final image.

# --- Build Stage ---
# Use a Maven and JDK image to build the application.
# Using a specific version ensures reproducible builds.
FROM maven:3.9.10-eclipse-temurin-21-alpine AS builder

# Set the working directory inside the container.
WORKDIR /app

# Copy the Maven wrapper and pom.xml to leverage Docker layer caching.
# This way, dependencies are only re-downloaded if pom.xml or the wrapper changes.
# Using the wrapper ensures a consistent Maven version across all environments.
# COPY .mvn/ .mvn
# COPY mvnw .
COPY pom.xml .

# Fix CRLF (Windows) line endings in the mvnw script that can cause execution errors in Linux containers.
# This is a common issue when files are checked out on a Windows machine.
# RUN sed -i 's/\r$//' mvnw

# Ensure the Maven wrapper is executable.
# RUN chmod +x mvnw

# Download the dependencies. Using dependency:go-offline is more efficient
# for this purpose than 'install' or 'package'.
RUN mvn dependency:go-offline -B

# Copy the rest of the application source code.
COPY src ./src

# Package the application, skipping tests as they should be run in a separate CI stage.
RUN mvn clean install

# --- Final Stage ---
# Use a slim JRE image for the final application container.
FROM eclipse-temurin:21-jre-alpine AS final

# Set the working directory inside the container.

WORKDIR /app

# Create a non-root user and group for security.
# Running as a non-root user is a security best practice.
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy the built application JAR from the builder stage and set ownership.
COPY --from=builder --chown=appuser:appgroup /app/target/*.jar app.jar

# Switch to the non-root user.
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]