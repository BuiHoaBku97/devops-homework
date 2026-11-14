# Stage Build
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

COPY gradlew .
COPY gradle ./gradle
COPY build.gradle settings.gradle ./

RUN chmod +x gradlew
RUN ./gradlew dependencies --no-daemon
COPY src ./src
RUN ./gradlew bootJar -x test --no-daemon

# Stage Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/order-service-*.jar ./order-service.jar
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

EXPOSE 8082
ENTRYPOINT ["sh", "-c", "java -jar /app/order-service.jar"]
