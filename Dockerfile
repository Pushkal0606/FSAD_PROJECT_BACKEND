# ==========================================
# Build Stage
# ==========================================
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# ==========================================
# Run Stage
# ==========================================
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/eduerp-0.0.1-SNAPSHOT.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
