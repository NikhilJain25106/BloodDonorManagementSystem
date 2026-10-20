# =========================================================================
# LifeDrop - Multi-Stage Production Dockerfile
# Optimized for lightweight execution, layered caching, and zero-downtime
# =========================================================================

# Stage 1: Build fat JAR with Maven and JDK 17
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /build

# Cache dependency layer
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Compile and package fat JAR
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Minimal, secure JRE 17 runtime
FROM eclipse-temurin:17-jre-alpine AS runtime
WORKDIR /app

# Run as non-privileged system user for defensive container security
RUN addgroup -S lifedropgroup && adduser -S lifedropuser -G lifedropgroup
USER lifedropuser

# Copy executable fat JAR from builder stage
COPY --from=builder --chown=lifedropuser:lifedropgroup /build/target/BloodDonorManagementSystem.jar app.jar

# Expose default HTTP application port
ENV PORT=8080
EXPOSE 8080

# Production JVM ergonomics: G1GC, memory limits, and headless mode
ENTRYPOINT ["java", \
    "-XX:+UseG1GC", \
    "-XX:MaxRAMPercentage=75.0", \
    "-XX:+ExitOnOutOfMemoryError", \
    "-Djava.awt.headless=true", \
    "-jar", "app.jar"]
