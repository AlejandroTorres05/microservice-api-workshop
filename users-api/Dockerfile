FROM maven:3.8-openjdk-8 as builder

WORKDIR /app

# Copiar archivos POM
COPY pom.xml .

# Descargar dependencias
RUN mvn dependency:go-offline -B

# Copiar código fuente
COPY src ./src/

# Compilar la aplicación
RUN mvn clean package -DskipTests

# Etapa final
FROM openjdk:8-jre-alpine

WORKDIR /app

# Copiar el JAR compilado
COPY --from=builder /app/target/*.jar app.jar

# Variables de entorno por defecto
ENV SERVER_PORT=8083
ENV JWT_SECRET=default_secret

# Exponer puerto
EXPOSE 8083

# Ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]