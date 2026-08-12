#---------------------------------------------
# Stage 1: Build
#---------------------------------------------

FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /src

COPY . /src

RUN mvn clean install -DskipTests=true


#---------------------------------------------
# Stage 2: Runtime
#---------------------------------------------

FROM eclipse-temurin:21-jre-alpine AS deploy

COPY --from=build /src/target/*.jar /src/target/bankapp.jar

EXPOSE 8080

CMD ["java", "-jar", "/src/target/bankapp.jar"]
