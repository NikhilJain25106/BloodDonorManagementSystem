.PHONY: help up down logs build test clean native

help:
	@echo "LifeDrop Management Commands:"
	@echo "  make up       - Start LifeDrop + MySQL in Docker (Recommended)"
	@echo "  make down     - Stop all Docker containers"
	@echo "  make logs     - Follow application logs"
	@echo "  make build    - Compile and package standalone fat JAR"
	@echo "  make test     - Run automated test suite (55 tests)"
	@echo "  make native   - Run executable JAR directly on host"
	@echo "  make clean    - Clean build artifacts"

up:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f app

build:
	mvn clean package -DskipTests

test:
	mvn test

native: build
	java -XX:+UseG1GC -Djava.awt.headless=true -jar target/BloodDonorManagementSystem.jar

clean:
	mvn clean

