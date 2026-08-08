# Stage 1: Build stage
FROM maven:3.9-eclipse-temurin-21 AS builder

# Set working directory inside the container
WORKDIR /src

# Copy source code from local machine into the container
COPY . /src

# Build the application and skip tests for faster image creation
RUN mvn clean install -DskipTests=true

#----------------------------------
# Stage 2: Runtime stage
#----------------------------------
FROM eclipse-temurin:21-jre-alpine AS deployer

# Copy the built JAR from the builder stage into the runtime image
COPY --from=builder /src/target/*.jar /app/bankapp.jar

# Expose application port
EXPOSE 8080

# Start the application
CMD ["java", "-jar", "/app/bankapp.jar"]
