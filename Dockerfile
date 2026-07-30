#----------------------------------
# Stage 1: Build stage
#----------------------------------
# Use Maven and Java 21 to build the application
#FROM maven:3.9-eclipse-temurin-21 as builder

# Set working directory inside the container
#WORKDIR /src

# Copy source code from local machine into the container
#COPY . /src

# Build the application and skip tests for faster image creation
#RUN mvn clean install -DskipTests=true

#----------------------------------
# Stage 2: Runtime stage
#----------------------------------
# Use a lightweight OpenJDK runtime image for the final container
#FROM eclipse-temurin:21-jre-alpine as deployer

# Copy the built JAR from the builder stage into the runtime image
#COPY --from=builder /src/target/*.jar /src/target/bankapp.jar

# Expose application port 
#EXPOSE 8080 

# Start the application
#ENTRYPOINT ["java", "-jar", "/src/target/bankapp.jar"]

# Stage-1
FROM maven:3.9-eclipse-temurin-21 as buildered

WORKDIR /src

COPY . /src

RUN mvn clean install -DskipTests=true

#---------------------------------------------
# Stage-2
FROM eclipse-temurin:21-jre-alpine as deployered

COPY --from=buildered /src/target/*.jar /src/target/bankapp.jar

EXPOSE 8080

CMD ["java", "-jar", "/src/target/bankapp.jar"]