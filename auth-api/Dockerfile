# Etapa de construcción
FROM golang:1.20 AS builder

WORKDIR /app

# Copiar archivos de dependencias
COPY Gopkg.lock Gopkg.toml ./
RUN go mod init github.com/bortizf/microservice-app-example/tree/master/auth-api && \
    go mod tidy

# Copiar código fuente
COPY *.go ./

# Compilar la aplicación
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o auth-api .

# Etapa final
FROM alpine:3.15    

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiar el binario compilado
COPY --from=builder /app/auth-api .

# Variables de entorno por defecto
ENV AUTH_API_PORT=8000
ENV JWT_SECRET=default_secret
ENV USERS_API_ADDRESS=http://users-api:8083

# Exponer puerto
EXPOSE 8000

# Ejecutar la aplicación
CMD ["./auth-api"]