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

# Pre-create Tomcat work and temp directories with correct permissions
RUN mkdir -p /tmp/tomcat-lifedrop && chown -R lifedropuser:lifedropgroup /tmp/tomcat-lifedrop

# Copy static web assets, JSP pages, and compiled servlet classes required by Tomcat
COPY --from=builder --chown=lifedropuser:lifedropgroup /build/src/main/webapp /app/src/main/webapp
COPY --from=builder --chown=lifedropuser:lifedropgroup /build/target/classes /app/target/classes

# Copy executable fat JAR (provide both app.jar and target/ path for complete compatibility)
COPY --from=builder --chown=lifedropuser:lifedropgroup /build/target/BloodDonorManagementSystem.jar /app/app.jar
RUN mkdir -p /app/target && ln -sf /app/app.jar /app/target/BloodDonorManagementSystem.jar && chown -R lifedropuser:lifedropgroup /app/target

USER lifedropuser

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
