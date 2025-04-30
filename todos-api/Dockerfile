FROM node:8.17.0-alpine

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY *.js ./

# Variables de entorno por defecto
ENV TODO_API_PORT=8082
ENV JWT_SECRET=default_secret
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Exponer puerto
EXPOSE 8082

# Ejecutar la aplicación
CMD ["npm", "start"]