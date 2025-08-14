# Terminal Prompts and Commands for Football Application

This document captures all available terminal prompts and commands for the Spring Boot football application project, including development, testing, building, deployment, and security scanning operations.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Maven Commands](#maven-commands)
3. [Docker Commands](#docker-commands)
4. [Spring Boot Commands](#spring-boot-commands)
5. [Snyk Security Scanning](#snyk-security-scanning)
6. [GitHub Actions Workflows](#github-actions-workflows)
7. [Development Environment Setup](#development-environment-setup)
8. [Testing Commands](#testing-commands)
9. [Deployment Commands](#deployment-commands)

## Project Overview

The football application is a Spring Boot web service that provides a REST API for managing football players. It's built with:
- **Java 21**
- **Spring Boot 3.2.1**
- **Maven** for build management
- **Docker** for containerization
- **Snyk** for security scanning

### Project Structure
```
football/
├── src/main/java/com/snykdemo/football/
│   ├── FootballApplication.java
│   └── PlayerController.java
├── src/main/resources/
│   └── application.properties
├── src/test/java/com/snykdemo/football/
│   ├── FootballApplicationTests.java
│   └── PlayerControllerTest.java
├── pom.xml
├── Dockerfile
├── docker-compose.yml
├── mvnw (Maven wrapper)
├── mvnw.cmd (Maven wrapper for Windows)
└── .github/workflows/
    ├── main-ci-only-actions.yml
    ├── reusable-snyk-scans.yml
    └── setup-snyk-vars/
```

## Maven Commands

### Basic Maven Operations

```bash
# Clean and compile the project
mvn clean compile

# Run tests
mvn test

# Package the application (creates JAR file)
mvn package

# Clean, compile, test, and package
mvn clean install

# Skip tests during build
mvn clean install -DskipTests

# Run with Maven wrapper (recommended)
./mvnw clean install

# Windows Maven wrapper
mvnw.cmd clean install

# Download dependencies only
mvn dependency:go-offline

# Show dependency tree
mvn dependency:tree

# Show project information
mvn help:effective-pom
```

### Maven with Spring Boot

```bash
# Run Spring Boot application
mvn spring-boot:run

# Run with specific profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Build executable JAR
mvn spring-boot:repackage

# Run with Maven wrapper
./mvnw spring-boot:run
```

## Docker Commands

### Building Docker Image

```bash
# Build the Docker image
docker build -t football .

# Build with specific tag
docker build -t football:latest .

# Build with no cache
docker build --no-cache -t football .

# Build using Dockerfile in current directory
docker image build . --file Dockerfile --tag football:latest
```

### Running Docker Container

```bash
# Run the container
docker run -p 8080:8080 football

# Run in detached mode
docker run -d -p 8080:8080 football

# Run with specific name
docker run --name football-app -p 8080:8080 football

# Run with environment variables
docker run -e SPRING_PROFILES_ACTIVE=prod -p 8080:8080 football

# Run and remove container when stopped
docker run --rm -p 8080:8080 football
```

### Docker Compose Commands

```bash
# Start services defined in docker-compose.yml
docker-compose up

# Start in detached mode
docker-compose up -d

# Build and start
docker-compose up --build

# Stop services
docker-compose down

# View logs
docker-compose logs

# View logs for specific service
docker-compose logs app

# Restart services
docker-compose restart
```

### Docker Management

```bash
# List running containers
docker ps

# List all containers
docker ps -a

# List images
docker images

# Remove container
docker rm <container_id>

# Remove image
docker rmi <image_id>

# Remove all stopped containers
docker container prune

# Remove unused images
docker image prune
```

## Spring Boot Commands

### Running the Application

```bash
# Run with Maven
mvn spring-boot:run

# Run with Maven wrapper
./mvnw spring-boot:run

# Run JAR file directly
java -jar target/football-0.0.1-SNAPSHOT.jar

# Run with specific profile
java -jar target/football-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev

# Run with custom port
java -jar target/football-0.0.1-SNAPSHOT.jar --server.port=9090
```

### Application Properties

```bash
# Run with custom properties
java -jar target/football-0.0.1-SNAPSHOT.jar --server.port=9090 --logging.level.com.snykdemo=DEBUG

# Run with external config file
java -jar target/football-0.0.1-SNAPSHOT.jar --spring.config.location=classpath:/application-prod.properties
```

## Snyk Security Scanning

### Prerequisites

```bash
# Install Snyk CLI
npm install -g snyk

# Authenticate with Snyk
snyk auth

# Set Snyk token environment variable
export SNYK_TOKEN="your-snyk-token"
```

### Snyk Commands

```bash
# Test for vulnerabilities in dependencies
snyk test

# Test with specific organization
snyk test --org=<org-id>

# Test all projects
snyk test --all-projects

# Test with severity threshold
snyk test --severity-threshold=high

# Test and fail on any vulnerability
snyk test --fail-on=all

# Test code for vulnerabilities
snyk code test

# Test infrastructure as code
snyk iac test

# Monitor project (send results to Snyk dashboard)
snyk monitor

# Monitor with project attributes
snyk monitor --org=<org-id> --project-name=football --target-reference=main

# Test container image
snyk container test <image-name>

# Monitor container image
snyk container monitor <image-name>

# Test with policy file
snyk test --policy-path=.snyk
```

### Snyk with Docker

```bash
# Test container image using Snyk Docker image
docker run --env SNYK_TOKEN \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd):/project \
  -w /project \
  snyk/snyk:docker snyk container test football:latest

# Monitor container image
docker run --env SNYK_TOKEN \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd):/project \
  -w /project \
  snyk/snyk:docker snyk container monitor football:latest \
  --project-name=football --target-reference=main
```

### Snyk with Maven

```bash
# Test Maven project
snyk test --org=<org-id> --all-projects --fail-on=all --severity-threshold=low

# Monitor Maven project
snyk monitor --org=<org-id> --all-projects --remote-repo-url=<repo-url> --target-reference=<ref>
```

## GitHub Actions Workflows

### Manual Workflow Triggers

```bash
# Trigger workflow manually via GitHub CLI
gh workflow run "Snyk Demo using GithubActions - no Terraform"

# Trigger with inputs
gh workflow run "Snyk Demo using GithubActions - no Terraform" \
  --field name="Snyk TSM APJ"
```

### Workflow Status

```bash
# List workflows
gh workflow list

# View workflow runs
gh run list

# View specific run
gh run view <run-id>

# Download workflow logs
gh run download <run-id>
```

## Development Environment Setup

### Prerequisites Installation

```bash
# Install Java 21
# macOS with Homebrew
brew install openjdk@21

# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-21-jdk

# Install Maven
# macOS with Homebrew
brew install maven

# Ubuntu/Debian
sudo apt install maven

# Install Docker
# macOS
brew install --cask docker

# Ubuntu/Debian
sudo apt install docker.io

# Install Node.js (for Snyk CLI)
# macOS with Homebrew
brew install node

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Environment Variables

```bash
# Set Java home
export JAVA_HOME=/path/to/java21

# Set Maven home
export MAVEN_HOME=/path/to/maven

# Set Snyk token
export SNYK_TOKEN="your-snyk-token"

# Set Docker registry credentials
export DOCKER_LOGIN="your-docker-username"
export DOCKER_PASSWORD="your-docker-password"
```

## Testing Commands

### Unit Tests

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=PlayerControllerTest

# Run specific test method
mvn test -Dtest=PlayerControllerTest#testListPlayers

# Run tests with coverage
mvn test jacoco:report

# Run tests in parallel
mvn test -T 1C
```

### Integration Tests

```bash
# Run integration tests
mvn verify

# Run with Spring Boot test
mvn spring-boot:run &
# Then run tests against running application
mvn test -Dtest=IntegrationTest
```

### API Testing

```bash
# Test API endpoints with curl
curl http://localhost:8080/players

curl -X POST http://localhost:8080/players \
  -H "Content-Type: application/json" \
  -d '"Lionel Messi"'

curl http://localhost:8080/players/Lionel%20Messi

curl -X PUT http://localhost:8080/players/Lionel%20Messi \
  -H "Content-Type: application/json" \
  -d '"Leo Messi"'

curl -X DELETE http://localhost:8080/players/Lionel%20Messi
```

## Deployment Commands

### Local Deployment

```bash
# Build and run locally
mvn clean install
java -jar target/football-0.0.1-SNAPSHOT.jar

# Build and run with Docker
docker build -t football .
docker run -p 8080:8080 football
```

### Docker Registry Deployment

```bash
# Tag image for registry
docker tag football:latest <registry>/football:latest

# Push to registry
docker push <registry>/football:latest

# Pull from registry
docker pull <registry>/football:latest
```

### Kubernetes Deployment

```bash
# Apply Kubernetes manifests
kubectl apply -f k8s/

# Deploy to specific namespace
kubectl apply -f k8s/ -n football

# Check deployment status
kubectl get pods -n football

# View logs
kubectl logs -f deployment/football -n football
```

## Monitoring and Debugging

### Application Monitoring

```bash
# Check application health
curl http://localhost:8080/actuator/health

# View application info
curl http://localhost:8080/actuator/info

# View metrics
curl http://localhost:8080/actuator/metrics

# View specific metric
curl http://localhost:8080/actuator/metrics/http.server.requests
```

### Debugging Commands

```bash
# Run with debug logging
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dlogging.level.com.snykdemo=DEBUG"

# Run with remote debugging
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"

# Connect debugger to port 5005

# View container logs
docker logs <container_id>

# Execute commands in running container
docker exec -it <container_id> /bin/sh
```

## Troubleshooting

### Common Issues

```bash
# Port already in use
lsof -i :8080
kill -9 <pid>

# Docker permission issues
sudo usermod -aG docker $USER

# Maven dependency issues
mvn dependency:purge-local-repository

# Clear Docker cache
docker system prune -a

# Reset Maven wrapper permissions
chmod +x mvnw
```

### Log Analysis

```bash
# View application logs
tail -f logs/application.log

# Search for errors
grep -i error logs/application.log

# View Docker logs
docker logs -f <container_id>

# View specific time range
docker logs --since="2024-01-01T00:00:00" <container_id>
```

## Security Best Practices

### Container Security

```bash
# Scan container for vulnerabilities
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image football:latest

# Check for secrets in code
grep -r "password\|secret\|key" src/

# Run security audit
npm audit
```

### Dependency Security

```bash
# Check for vulnerable dependencies
mvn org.owasp:dependency-check-maven:check

# Update dependencies
mvn versions:use-latest-versions

# Check for outdated dependencies
mvn versions:display-dependency-updates
```

---

## Quick Reference

### Development Workflow
```bash
# 1. Start development
./mvnw spring-boot:run

# 2. Run tests
./mvnw test

# 3. Build for production
./mvnw clean package

# 4. Build Docker image
docker build -t football .

# 5. Run container
docker run -p 8080:8080 football

# 6. Security scan
snyk test --org=<org-id>
```

### CI/CD Pipeline Commands
```bash
# Build and test
mvn clean install

# Security scan
snyk test --org=<org-id> --all-projects --fail-on=all

# Build container
docker build -t football .

# Push to registry
docker push <registry>/football:latest

# Deploy
kubectl apply -f k8s/
```

This document provides a comprehensive reference for all terminal commands and prompts available for the football application project. Use the appropriate commands based on your specific needs and environment setup.
